From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 2.6.39] omap: board-4430sdp: revert hsmmc_info reordering
Date: Fri, 1 Apr 2011 12:46:42 +0530
Message-ID: <AANLkTikPawWg8Wt8F4oeEBbvUOziPNrH+7A3MyXkx8Lw@mail.gmail.com>
References: <1301640748-17161-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55595 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811Ab1DAHRD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 03:17:03 -0400
Received: by vxi39 with SMTP id 39so2488567vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 00:17:02 -0700 (PDT)
In-Reply-To: <1301640748-17161-1-git-send-email-coelho@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, Apr 1, 2011 at 12:22 PM, Luciano Coelho <coelho@ti.com> wrote:
> The order in which the MMC cards are defined in the the 4430sdp board
> file seems to have been mistakenly reorderded as part of an unrelated
> patch. =A0In commit 0005ae73cfe44ee42d0be12a12cc82bf982f518e, where o=
nly
> the dev_name was supposed to be changed, the mmc order was changed as
> well. =A0This caused the external SD card reader not to be recognized=
,
> at least on Blaze.

Both OMAP4 SDP & Blaze boards have internal eMMC as storage.

Just think of some scenario as below with FS in  eMMC
[with external card recognized as mmcblk0 and eMMC as mmcblk1]:
Booting with both external card on MMC1 and eMMC on MMC2 and having
bootargs set to root=3D/dev/mmcblk1px [x=3D parition number].
Removing the external card from slot makes eMMC recognized as mmcblk0 a=
nd
in this case kernel can't pick the file system as passed above in the b=
ootargs.

So, making the permanent storage on the boards registered as first
block device gets
rid of the problem.

Regards,
Kishore
>
> This patch reverts this change so that the external SD card is
> recognized again.
>
> Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> ---
>
> I have started investigating the cause for this problem, because it
> seems to me that the value in the mmc element is what should matter,
> but it doesn't seem to be the case. =A0I believe there is a bug
> elsewhere, that causes the order of the array to matter, but I'm not
> very familiar with hsmmc and I don't have much time right now to delv=
e
> into the problem, so I leave this to the omap people. ;) I can always
> help testing if necessary.
>
> The change indeed seems to have been a mistake, because it was
> introduced silently in v6:
> https://patchwork.kernel.org/patch/595861/
>
> In v5, the change was not there:
> https://patchwork.kernel.org/patch/590441/
>
> =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 10 +++++-----
> =A01 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index 56702c5..8991d56 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -351,6 +351,11 @@ static struct twl4030_usb_data omap4_usbphy_data=
 =3D {
>
> =A0static struct omap2_hsmmc_info mmc[] =3D {
> =A0 =A0 =A0 =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_4=
_BIT_DATA | MMC_CAP_8_BIT_DATA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.caps =A0 =A0 =A0 =A0 =A0 =3D =A0MMC_C=
AP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> @@ -358,11 +363,6 @@ static struct omap2_hsmmc_info mmc[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.nonremovable =A0 =3D true,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ocr_mask =A0 =A0 =A0 =3D MMC_VDD_29_3=
0,
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_4=
_BIT_DATA | MMC_CAP_8_BIT_DATA,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> - =A0 =A0 =A0 },
> =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
> =A0};
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
