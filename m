From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: am3517: USB state in 3.5-rc6
Date: Thu, 02 Aug 2012 11:52:08 +0200
Message-ID: <501A4DC8.1010401@visionsystems.de>
References: <500CF852.4020005@visionsystems.de> <1343143805.834.3.camel@coredoba.hi.pengutronix.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:56019 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab2HBJwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 05:52:21 -0400
In-Reply-To: <1343143805.834.3.camel@coredoba.hi.pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?SmFuIEzDvGJiZQ==?= <jlu@pengutronix.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>

Am 24.07.2012 17:30, schrieb Jan L=C3=BCbbe:
> Hi,
>
> On Mon, 2012-07-23 at 09:08 +0200, Yegor Yefremov wrote:
>> After getting MMC working I now have following issues: both musb and=
 EHCI make problems.
>>
>> musb:
>>
>> musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
>> musb-am35x musb-am35x: failed to get clock
>> musb-am35x: probe of musb-am35x failed with error -2 =20
> I've seen the same problem after merging omap-devel-d-for-3.6 onto v3=
=2E5.
> (see http://git.kernel.org/?p=3Dlinux/kernel/git/pjw/omap-pending.git=
;a=3Dtag;h=3Drefs/tags/omap-devel-d-for-3.6)
>
> So far I've worked around it like this (I'm not sure this is the corr=
ect
> approach, but it works):
>
> diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> index 9f3eda9..2184693 100644
> --- a/drivers/usb/musb/am35x.c
> +++ b/drivers/usb/musb/am35x.c
> @@ -480,14 +480,14 @@ static int __devinit am35x_probe(struct platfor=
m_device *pdev)
>                 goto err1;
>         }
> =20
> -       phy_clk =3D clk_get(&pdev->dev, "fck");
> +       phy_clk =3D clk_get(&pdev->dev, "hsotgusb_ick");
>         if (IS_ERR(phy_clk)) {
>                 dev_err(&pdev->dev, "failed to get PHY clock\n");
>                 ret =3D PTR_ERR(phy_clk);
>                 goto err2;
>         }
> =20
> -       clk =3D clk_get(&pdev->dev, "ick");
> +       clk =3D clk_get(&pdev->dev, "hsotgusb_fck");
>         if (IS_ERR(clk)) {
>                 dev_err(&pdev->dev, "failed to get clock\n");
>                 ret =3D PTR_ERR(clk);

Jan, thanks for the patch. It helped. I've taken the upcoming vanila 3.=
6 kernel and got both musb and EHCI running. I will test it further aft=
er linux-omap will be merged with linux-2.6 after merge window is close=
d.

Yegor
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
