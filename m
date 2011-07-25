From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/2 V2] OMAP3+: PM: SR: add suspend/resume handlers
Date: Mon, 25 Jul 2011 12:55:39 -0500
Message-ID: <CAOMWX4dnD+GX+G8eFBgqqtwF0=+mgcqdJc2vfhf7eMW+LLnwSw@mail.gmail.com>
References: <1311526357-7578-1-git-send-email-nm@ti.com>
	<20110725084238.GC18062@legolas.emea.dhcp.ti.com>
	<CAOMWX4dC60SuF9=KDCrQo7zD5_PhTJhwuyqRkqj0ag8FHDQaxw@mail.gmail.com>
	<20110725171317.GH18062@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110725171317.GH18062@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Kevin <khilman@ti.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Colin <ccross@google.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 25, 2011 at 12:13, Felipe Balbi <balbi@ti.com> wrote:
[..]
>> > while at that, SR's IRQ is never freed on exit path, could fix it while
>> > you're already there ?
>>
>> This is not really related to this patch is it? IMHO IRQ handling is
>
> I didn't say to put it on the same patch ;-) I meant that while at that,
> you could add that simple fix before this patch ;-)
Not really that simple - it is just one part of the equation, my point
being - if we are cleaning up, we better cleanup completely on that
thread at least.

>
>> broken badly. Current support is for SmartReflex class3 - which does
>> not use the IRQ, Class2 and Class1.5 use it, but the current code
>> requires major fixes which I dont intend to support in this series.
>
> And that's exactly what I mean. IMHO it's far better to fix the mess
> before adding more stuff, otherwise it just becomes an even bigger mess,
> even more difficult to fix in the long run. We've seen that with GPIO
> and sDMA drivers _at_least_ ;-(

I tried pushing the cleanups in my series
http://marc.info/?l=3Dlinux-omap&m=3D129933897910785&w=3D2

few of them did go through and I have since personally lost interest
and depending on my next free slot (not forthcoming for next few
months), I might want to retry it, but I guess there is more interest
in turning things into regulators than add new code.

I am ok if folks want to drop this patch - like previously, things
tend to get forgotten..

>
>> >> @@ -998,10 +1020,75 @@ static int __devexit omap_sr_remove(struct pla=
tform_device *pdev)
>> >> =A0 =A0 =A0 return 0;
>> >> =A0}
>> >>
>> >> +static int omap_sr_suspend(struct device *dev)
>> >> +{
>> >> + =A0 =A0 struct omap_sr_data *pdata;
>> >> + =A0 =A0 struct omap_sr *sr_info;
>> >> +
>> >> + =A0 =A0 pdata =3D dev_get_platdata(dev);
>> >
>> > I'm not sure you need to use platform data here...
>> see below
>> >
>> >> + =A0 =A0 if (!pdata) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: platform data missing\n",=
 __func__);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 sr_info =3D _sr_lookup(pdata->voltdm);
>> >
>> > this field is held on struct omap_sr. Can't you:
>> >
>> > =A0 =A0 =A0 =A0struct omap_sr =A0*info =3D dev_get_drvdata(dev);
>> >
>> > ?? I see that a platform_set_drvdata() is missing from the driver, but
>> > maybe you should add that instead of accessing platform_data.
>> omap_sr_data is added in arch/arm/mach-omap2/sr_device.c
>>
>> With the current handling - it needs sr_data from which sr_info is
>> pulled out. in the current implementation, sr_data contains the voltdm
>> pointer from which sr_info is pulled out.
>
> but sr_info is allocated on probe() isn't it ? if you add
> platform_set_drvdata(pdev, sr_info) on probe, you won't need sr_data to
> fetch sr_info, all you need is to use dev_get_drvdata(dev). Am I missing
> something ?
sr_info - I am not debating that this is not possible - I am just
explaining how it is being done now. I just dont have the bandwidth to
kill all evils in smartreflex driver. :(

Regards,
Nishanth Menon
