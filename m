From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Tue, 1 Mar 2011 11:23:31 -0500
Message-ID: <AANLkTikmwLoUPJrFZ2o7qsO8MbxBLe2hMbetwxeToW-Z@mail.gmail.com>
References: <1298925943.16391.19.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:34885 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756417Ab1CAQYM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 11:24:12 -0500
Received: by mail-gx0-f174.google.com with SMTP id 8so2700647gxk.5
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 08:24:11 -0800 (PST)
In-Reply-To: <1298925943.16391.19.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi,

On Mon, Feb 28, 2011 at 15:45, Michael Buesch <mb@bu3sch.de> wrote:
> The n810 LCD does not work on the 2.6.38(-rc6) kernel
> due to changes in the OMAP GPIO-hwmod code.
>
> The hwmod code performs a soft-reset on the GPIO
> module. The first GPIO module carries the MIPID
> "nreset" line, which is toggled due to the hwmod soft reset.
> This resets Blizzard and breaks it, because
> it assumes the LCD was left in the state that the
> bootloader initialized it to:

It is the design of hwmod framework that all the omap devices
should be reset independent of bootloader settings. The
corresponding board file/ the driver should take care of init settings
of the device based on the requirement. Avoid dependency on
bootloader.

>
> =A0 =A0 =A0 =A0if (!(blizzard_read_reg(BLIZZARD_PLL_DIV) & 0x80)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(fbdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"controller not in=
itialized by the bootloader\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err3;
> =A0 =A0 =A0 =A0}
>
> My temporary workaround to this issue is to disable
> soft reset for the first GPIO module:
>
> =A0 =A0 =A0 =A0static struct omap_hwmod omap2420_gpio1_hwmod =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio1",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_IN=
IT_NO_RESET, /* Workaround: Don't reset the n810 MIPID */

NACK.

As the problem is specific to the board settings, this shall be handled
in the board file itself.

>
> I'm wondering if a better fix suitable for the mainline
> kernel inclusion could be found.
> Any ideas?

Re-initialize the  "nreset" line of the Blizzard in the
corresponding board file.

- V Charulatha

>
> --
> Greetings, Michael.
>
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
