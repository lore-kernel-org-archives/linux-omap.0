From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Tue, 22 Nov 2011 09:57:41 -0800
Message-ID: <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org> <20111122154900.GB18954@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111122154900.GB18954@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Mike Turquette <mturquette@ti.com>, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, paul@pwsan.com, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 22, 2011 at 7:49 AM, Greg KH <greg@kroah.com> wrote:
> On Mon, Nov 21, 2011 at 05:40:47PM -0800, Mike Turquette wrote:
>> Introduces kobject support for the common struct clk, exports per-cl=
k
>> data via read-only callbacks and models the clk tree topology in sys=
fs.
>>
>> Also adds support for generating the clk tree in clk_init and migrat=
ing
>> nodes when input sources are switches in clk_set_parent.
>>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
>
> Thanks Arnd for pointing me at this.
>
>> +#define MAX_STRING_LENGTH =A0 =A032
>
> Why?

Copy paste from other implementations.  What do you recommend?

>
>> +static struct kobject *clk_kobj;
>> +LIST_HEAD(kobj_list);
>
> Um, no, please NEVER use raw kobjects, you should be using struct dev=
ice
> instead. =A0Please change the code to do that.

Today the clk tree doesn't create a struct device for each clk, which
I assume would be necessary to do what you're talking about.  Is that
right?

Maybe that will be necessary with the device tree stuff anyways... any
feedback from Sascha or Grant on that?

>
>> +static ssize_t clk_show(struct kobject *kobj, struct attribute *att=
r,
>> + =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
>> +{
>> + =A0 =A0 struct clk *clk;
>> + =A0 =A0 struct clk_attribute *clk_attr;
>> + =A0 =A0 ssize_t ret =3D -EINVAL;
>> +
>> + =A0 =A0 clk =3D container_of(kobj, struct clk, kobj);
>> + =A0 =A0 clk_attr =3D container_of(attr, struct clk_attribute, attr=
);
>> +
>> + =A0 =A0 if (!clk || !clk_attr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 /* we don't do any locking for debug operations */
>> +
>> + =A0 =A0 /* refcount++ */
>> + =A0 =A0 kobject_get(&clk->kobj);
>> +
>> + =A0 =A0 if (clk_attr->show)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_attr->show(clk, buf);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
>> +
>> + =A0 =A0 /* refcount-- */
>> + =A0 =A0 kobject_put(&clk->kobj);
>
> Why in the world would you be incrementing and decrementing the
> reference count of the kobject in the show function? =A0What are you
> trying to protect here that is not already protected by the core?

Will remove in v4.

>
>
>> +static void clk_release(struct kobject *kobj)
>> +{
>> + =A0 =A0 struct clk *clk;
>> +
>> + =A0 =A0 clk =3D container_of(kobj, struct clk, kobj);
>> +
>> + =A0 =A0 complete(&clk->kobj_unregister);
>> +}
>
> Look Ma, a memory leak!

Oops.  Will fix in V4.

>
>> +static struct kobj_type clk_ktype =3D {
>> + =A0 =A0 .sysfs_ops =A0 =A0 =A0=3D &clk_ops,
>> + =A0 =A0 .default_attrs =A0=3D clk_default_attrs,
>> + =A0 =A0 .release =A0 =A0 =A0 =A0=3D clk_release,
>> +};
>> +
>> +int clk_kobj_add(struct clk *clk)
>> +{
>> + =A0 =A0 if (IS_ERR(clk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Some kobject trickery!
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* We want to (ab)use the kobject infrastructure to trac=
k our
>> + =A0 =A0 =A0* tree topology for us, specifically the root clocks (w=
hich are
>> + =A0 =A0 =A0* otherwise not remembered in a global list).
>> + =A0 =A0 =A0* Unfortunately we might not be able to allocate memory=
 yet
>> + =A0 =A0 =A0* when this path is hit. =A0This pretty much rules out =
anything
>> + =A0 =A0 =A0* that looks or smells like kobject_add, since there ar=
e
>> + =A0 =A0 =A0* allocations for kobject->name and a dependency on sys=
fs being
>> + =A0 =A0 =A0* initialized.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* To get around this we initialize the kobjects and (ab=
)use
>> + =A0 =A0 =A0* struct kobject's list_head member, "entry". =A0Later =
on we walk
>> + =A0 =A0 =A0* this list in clk_sysfs_tree_create() to make proper
>> + =A0 =A0 =A0* kobject_add calls once it is safe to do so.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* FIXME - this is starting to smell alot like clkdev (i=
=2Ee.
>> + =A0 =A0 =A0* tracking the clocks in a list)
>
> Ah, comments like this warm my heart.
>
> Come on, no abusing the kobject code please, if have problems with ho=
w
> the kernel core works, and it doesn't do things you want it to, then =
why
> not change it to work properly for you, or at the least, ASK ME!!!

Ok, I'm asking you now.  There are two ways to solve this problem:

1) have kobject core create the lists linking the objects but defer
allocations and any interactions with sysfs until later in the boot
sequence, OR

2) my code can create a list of clks (the same way that clkdev does)
and defer kobject/sysfs stuff until later, which walks the list made
during early-boot

#1 is most closely aligned with the code I have here, #2 presents
challenges that I haven't really though through.  I know that OMAP
uses the clk framework VERY early in it's boot sequence, but as long
as the per-clk data is properly initialized then it should be OK.

What do you think?

Regards,
Mike
