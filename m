From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Tue, 22 Nov 2011 07:49:00 -0800
Message-ID: <20111122154900.GB18954@kroah.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1321926047-14211-6-git-send-email-mturquette@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Turquette <mturquette@ti.com>
Cc: linaro-dev@lists.linaro.org, eric.miao@linaro.org, grant.likely@secretlab.ca, aul@pwsan.com, jeremy.kerr@canonical.com, Mike Turquette <mturquette@linaro.org>, sboyd@quicinc.com, magnus.damm@gmail.com, dsaxena@linaro.org, linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org, patches@linaro.org, linux@arm.linux.org.uk, tglx@linutronix.de, linux-omap@vger.kernel.org, richard.zhao@linaro.org, shawn.guo@freescale.com, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, skannan@quicinc.com
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 21, 2011 at 05:40:47PM -0800, Mike Turquette wrote:
> Introduces kobject support for the common struct clk, exports per-clk
> data via read-only callbacks and models the clk tree topology in sysfs.
> 
> Also adds support for generating the clk tree in clk_init and migrating
> nodes when input sources are switches in clk_set_parent.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>

Thanks Arnd for pointing me at this.

> +#define MAX_STRING_LENGTH	32

Why?

> +static struct kobject *clk_kobj;
> +LIST_HEAD(kobj_list);

Um, no, please NEVER use raw kobjects, you should be using struct device
instead.  Please change the code to do that.

> +static ssize_t clk_show(struct kobject *kobj, struct attribute *attr,
> +		char *buf)
> +{
> +	struct clk *clk;
> +	struct clk_attribute *clk_attr;
> +	ssize_t ret = -EINVAL;
> +
> +	clk = container_of(kobj, struct clk, kobj);
> +	clk_attr = container_of(attr, struct clk_attribute, attr);
> +
> +	if (!clk || !clk_attr)
> +		goto out;
> +
> +	/* we don't do any locking for debug operations */
> +
> +	/* refcount++ */
> +	kobject_get(&clk->kobj);
> +
> +	if (clk_attr->show)
> +		ret = clk_attr->show(clk, buf);
> +	else
> +		ret = -EIO;
> +
> +	/* refcount-- */
> +	kobject_put(&clk->kobj);

Why in the world would you be incrementing and decrementing the
reference count of the kobject in the show function?  What are you
trying to protect here that is not already protected by the core?


> +static void clk_release(struct kobject *kobj)
> +{
> +	struct clk *clk;
> +
> +	clk = container_of(kobj, struct clk, kobj);
> +
> +	complete(&clk->kobj_unregister);
> +}

Look Ma, a memory leak!

> +static struct kobj_type clk_ktype = {
> +	.sysfs_ops	= &clk_ops,
> +	.default_attrs	= clk_default_attrs,
> +	.release	= clk_release,
> +};
> +
> +int clk_kobj_add(struct clk *clk)
> +{
> +	if (IS_ERR(clk))
> +		return -EINVAL;
> +
> +	/*
> +	 * Some kobject trickery!
> +	 *
> +	 * We want to (ab)use the kobject infrastructure to track our
> +	 * tree topology for us, specifically the root clocks (which are
> +	 * otherwise not remembered in a global list).
> +	 * Unfortunately we might not be able to allocate memory yet
> +	 * when this path is hit.  This pretty much rules out anything
> +	 * that looks or smells like kobject_add, since there are
> +	 * allocations for kobject->name and a dependency on sysfs being
> +	 * initialized.
> +	 *
> +	 * To get around this we initialize the kobjects and (ab)use
> +	 * struct kobject's list_head member, "entry".  Later on we walk
> +	 * this list in clk_sysfs_tree_create() to make proper
> +	 * kobject_add calls once it is safe to do so.
> +	 *
> +	 * FIXME - this is starting to smell alot like clkdev (i.e.
> +	 * tracking the clocks in a list)

Ah, comments like this warm my heart.

Come on, no abusing the kobject code please, if have problems with how
the kernel core works, and it doesn't do things you want it to, then why
not change it to work properly for you, or at the least, ASK ME!!!

> +	 */
> +
> +	kobject_init(&clk->kobj, &clk_ktype);
> +	list_add_tail(&clk->kobj.entry, &kobj_list);

Yeah, no kobject lists for you, sorry, DO NOT DO THIS!

> +static int __init clk_sysfs_init(void)
> +{
> +	struct list_head *tmp;
> +
> +	clk_kobj = kobject_create_and_add("clk", NULL);
> +
> +	WARN_ON(!clk_kobj);

Why?  What is this helping with?

Please rewrite to use 'struct device'.

thanks,

greg k-h
