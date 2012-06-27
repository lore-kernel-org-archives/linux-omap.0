From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap2plus_defconfig: Enable EXT4 support
Date: Thu, 28 Jun 2012 00:28:03 +0200
Message-ID: <CAAwP0s2eTWk2Uf0HZ13Lq5gA0HNp8V87znjd6rX6Uh0ZPy03PA@mail.gmail.com>
References: <1340489939-5390-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:64819 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab2F0W2Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 18:28:24 -0400
Received: by gglu4 with SMTP id u4so1380741ggl.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 15:28:23 -0700 (PDT)
In-Reply-To: <1340489939-5390-1-git-send-email-javier@dowhile0.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Jun 24, 2012 at 12:18 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> On OMAP boards that includes an SD card slot, an EXT4 partition could
> be used to store the root file system. So, the kernel should have
> built-in support for EXT4 to be able to mount the VFS root on boot.
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
> =C2=A0arch/arm/configs/omap2plus_defconfig | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/=
omap2plus_defconfig
> index 9854ff4..f3087cb 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -197,6 +197,7 @@ CONFIG_RTC_DRV_TWL4030=3Dy
> =C2=A0CONFIG_EXT2_FS=3Dy
> =C2=A0CONFIG_EXT3_FS=3Dy
> =C2=A0# CONFIG_EXT3_FS_XATTR is not set
> +CONFIG_EXT4_FS=3Dy
> =C2=A0CONFIG_QUOTA=3Dy
> =C2=A0CONFIG_QFMT_V2=3Dy
> =C2=A0CONFIG_MSDOS_FS=3Dy
> --
> 1.7.7.6
>

Hi,

any news about this patch?

Is quite annoying to have to enable EXT4 support each time I want to
try a new kernel on my board.

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
