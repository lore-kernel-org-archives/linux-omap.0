From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 15:00:50 +0530
Message-ID: <CAP05o4LkWpANqibBXsY-FbCTOsioUq4qPdA8k=Ct4HHGYfL4Ng@mail.gmail.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
	<1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
	<20120319100603.GB20279@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:56090 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753631Ab2CTJaw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 05:30:52 -0400
Received: by obbef5 with SMTP id ef5so2329773obb.35
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 02:30:50 -0700 (PDT)
In-Reply-To: <20120319100603.GB20279@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, sameo@linux.intel.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com

On Mon, Mar 19, 2012 at 3:36 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Mar 19, 2012 at 12:18:31PM +0530, Keshava Munegowda wrote:
>> + =A0 =A0 ver =3D =A0usbtll_read(base, OMAP_USBTLL_REVISION);
>> + =A0 =A0 if (ver =3D=3D OMAP_USBTLL_REV1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D OMAP_TLL_CHANNEL_COUNT;
>> + =A0 =A0 else if (ver =3D=3D OMAP_USBTLL_REV2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D OMAP_REV2_TLL_CHANNEL_COUNT;
>> + =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "TLL version failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_ioremap;
>> + =A0 =A0 }
>
> wrong coding style.
>
>> +static const struct dev_pm_ops usbtllomap_dev_pm_ops =3D {
>> + =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D usbtll_runtime_suspend=
,
>> + =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D usbtll_runtime_resume,
>
> use SET_RUNTIME_PM_OPS()
>
>> +static struct platform_driver usbtll_omap_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D (char *)usbt=
ll_driver_name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &usbtlloma=
p_dev_pm_ops,
>> + =A0 =A0 },
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(usbtll_omap_remove),
>
> __devexit_p()
>
>> +};
>> +
>> +int omap_tll_enable(void)
>> +{
>> + =A0 =A0 if (!tll_pdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&tll_pdev->dev, "missing platform_=
data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
>> + =A0 =A0 }
>> + =A0 =A0 return pm_runtime_get_sync(&tll_pdev->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(omap_tll_enable);
>
> why ?

the usb hs core driver uses omap_tll_enable and omap_tll_disable
apis based on the port selection in ./drivers/mfd/omap-usb-host.c file.


>> +
>> +int omap_tll_disable(void)
>> +{
>> + =A0 =A0 if (!tll_pdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&tll_pdev->dev, "missing platform_=
data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
>> + =A0 =A0 }
>> + =A0 =A0 return pm_runtime_put_sync(&tll_pdev->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(omap_tll_disable);
>
> why ?
>
>> +MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
>> +MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI contro=
llers");
>> +
>> +static int __init omap_usbtll_drvinit(void)
>> +{
>> + =A0 =A0 return platform_driver_probe(&usbtll_omap_driver, usbtll_o=
map_probe);
>
> please don't. Make sure you use platform_driver_register, instead.


Here , omap_usbtll_drvinit is registered through fs_initcall call;
this is required because, the TLL driver is required to initialized
before the UHH ( usb host core) driver.

regards
keshava



>
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
