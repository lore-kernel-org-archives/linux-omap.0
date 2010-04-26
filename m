From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/2 V6] OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP
Date: Mon, 26 Apr 2010 18:57:14 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E1EBEB2@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E304C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51280 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790Ab0DZN10 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 09:27:26 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E304C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Y, Kishore" <kishore.y@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Y, Kishore
> Sent: Monday, April 26, 2010 6:36 PM
> To: Tomi Valkeinen; Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 2/2 V6] OMAP: DSS: Enable display on ZOOM2/3 & 3630SDP
> 
> 
> Enable dss and framebuffer on zoom2, zoom3 and 3630sdp boards.
> 
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> Reviewed-by: Gadiyar, Anand <gadiyar@ti.com>
> ---
>  arch/arm/configs/omap_3630sdp_defconfig |   60
> ++++++++++++++++++++++++++++++-
>  arch/arm/configs/omap_zoom2_defconfig   |   60
> ++++++++++++++++++++++++++++++-
>  arch/arm/configs/omap_zoom3_defconfig   |   60
> ++++++++++++++++++++++++++++++-
>  3 files changed, 177 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/configs/omap_3630sdp_defconfig
> b/arch/arm/configs/omap_3630sdp_defconfig
> index 609f348..57c1c4f 100644
> --- a/arch/arm/configs/omap_3630sdp_defconfig
> +++ b/arch/arm/configs/omap_3630sdp_defconfig
> @@ -886,7 +886,57 @@ CONFIG_REGULATOR_TWL4030=y
>  #
>  # CONFIG_VGASTATE is not set
>  CONFIG_VIDEO_OUTPUT_CONTROL=m
> -# CONFIG_FB is not set
> +CONFIG_FB=y
> +# CONFIG_FIRMWARE_EDID is not set
> +# CONFIG_FB_DDC is not set
> +# CONFIG_FB_BOOT_VESA_SUPPORT is not set
> +CONFIG_FB_CFB_FILLRECT=y
> +CONFIG_FB_CFB_COPYAREA=y
> +CONFIG_FB_CFB_IMAGEBLIT=y
> +# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> +# CONFIG_FB_SYS_FILLRECT is not set
> +# CONFIG_FB_SYS_COPYAREA is not set
> +# CONFIG_FB_SYS_IMAGEBLIT is not set
> +# CONFIG_FB_FOREIGN_ENDIAN is not set
> +# CONFIG_FB_SYS_FOPS is not set
> +# CONFIG_FB_SVGALIB is not set
> +# CONFIG_FB_MACMODES is not set
> +# CONFIG_FB_BACKLIGHT is not set
> +# CONFIG_FB_MODE_HELPERS is not set
> +# CONFIG_FB_TILEBLITTING is not set
> +
> +#
> +# Frame buffer hardware drivers
> +#
> +# CONFIG_FB_UVESA is not set
> +# CONFIG_FB_S1D13XXX is not set
> +# CONFIG_FB_VIRTUAL is not set
> +# CONFIG_FB_METRONOME is not set
> +# CONFIG_FB_MB862XX is not set
> +# CONFIG_FB_BROADSHEET is not set
> +# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> +CONFIG_OMAP2_VRAM=y
> +CONFIG_OMAP2_VRFB=y
> +CONFIG_OMAP2_DSS=y
> +CONFIG_OMAP2_VRAM_SIZE=4
> +# CONFIG_OMAP2_DSS_DEBUG_SUPPORT is not set
> +# CONFIG_OMAP2_DSS_RFBI is not set
> +CONFIG_OMAP2_DSS_VENC=y
> +# CONFIG_OMAP2_DSS_SDI is not set
> +# CONFIG_OMAP2_DSS_DSI is not set
> +# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
> +CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4
> +CONFIG_FB_OMAP2=y
> +# CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
> +# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
> +CONFIG_FB_OMAP2_NUM_FBS=3
> +
> +#
> +# OMAP2/3 Display Device Drivers
> +#
> +# CONFIG_PANEL_GENERIC is not set
> +# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
> +CONFIG_PANEL_NEC_NL8048HL11_01B=y
>  # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
>  #
> @@ -899,6 +949,14 @@ CONFIG_VIDEO_OUTPUT_CONTROL=m
>  #
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_DUMMY_CONSOLE=y
> +CONFIG_FRAMEBUFFER_CONSOLE=y
[Hiremath, Vaibhav] Are you sure you want FRAMEBUFFER_CONSOLE option to be enabled here? This actually brings a dark cursor on display which is annoying. Atleast I have seen multiple request in the past to remove this option from field.

If yes, then

Acked/Reviewed-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav

> +# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> +# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> +# CONFIG_FONTS is not set
> +CONFIG_LOGO=y
> +CONFIG_LOGO_LINUX_MONO=y
> +CONFIG_LOGO_LINUX_VGA16=y
> +CONFIG_LOGO_LINUX_CLUT224=y
>  CONFIG_SOUND=y
>  # CONFIG_SOUND_OSS_CORE is not set
>  CONFIG_SND=y
> diff --git a/arch/arm/configs/omap_zoom2_defconfig
> b/arch/arm/configs/omap_zoom2_defconfig
> index 881faea..c47002a 100644
> --- a/arch/arm/configs/omap_zoom2_defconfig
> +++ b/arch/arm/configs/omap_zoom2_defconfig
> @@ -860,7 +860,57 @@ CONFIG_DAB=y
>  #
>  # CONFIG_VGASTATE is not set
>  CONFIG_VIDEO_OUTPUT_CONTROL=m
> -# CONFIG_FB is not set
> +CONFIG_FB=y
> +# CONFIG_FIRMWARE_EDID is not set
> +# CONFIG_FB_DDC is not set
> +# CONFIG_FB_BOOT_VESA_SUPPORT is not set
> +CONFIG_FB_CFB_FILLRECT=y
> +CONFIG_FB_CFB_COPYAREA=y
> +CONFIG_FB_CFB_IMAGEBLIT=y
> +# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> +# CONFIG_FB_SYS_FILLRECT is not set
> +# CONFIG_FB_SYS_COPYAREA is not set
> +# CONFIG_FB_SYS_IMAGEBLIT is not set
> +# CONFIG_FB_FOREIGN_ENDIAN is not set
> +# CONFIG_FB_SYS_FOPS is not set
> +# CONFIG_FB_SVGALIB is not set
> +# CONFIG_FB_MACMODES is not set
> +# CONFIG_FB_BACKLIGHT is not set
> +# CONFIG_FB_MODE_HELPERS is not set
> +# CONFIG_FB_TILEBLITTING is not set
> +
> +#
> +# Frame buffer hardware drivers
> +#
> +# CONFIG_FB_UVESA is not set
> +# CONFIG_FB_S1D13XXX is not set
> +# CONFIG_FB_VIRTUAL is not set
> +# CONFIG_FB_METRONOME is not set
> +# CONFIG_FB_MB862XX is not set
> +# CONFIG_FB_BROADSHEET is not set
> +# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> +CONFIG_OMAP2_VRAM=y
> +CONFIG_OMAP2_VRFB=y
> +CONFIG_OMAP2_DSS=y
> +CONFIG_OMAP2_VRAM_SIZE=4
> +# CONFIG_OMAP2_DSS_DEBUG_SUPPORT is not set
> +# CONFIG_OMAP2_DSS_RFBI is not set
> +CONFIG_OMAP2_DSS_VENC=y
> +# CONFIG_OMAP2_DSS_SDI is not set
> +# CONFIG_OMAP2_DSS_DSI is not set
> +# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
> +CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4
> +CONFIG_FB_OMAP2=y
> +# CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
> +# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
> +CONFIG_FB_OMAP2_NUM_FBS=3
> +
> +#
> +# OMAP2/3 Display Device Drivers
> +#
> +# CONFIG_PANEL_GENERIC is not set
> +# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
> +CONFIG_PANEL_NEC_NL8048HL11_01B=y
>  # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
>  #
> @@ -873,6 +923,14 @@ CONFIG_VIDEO_OUTPUT_CONTROL=m
>  #
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_DUMMY_CONSOLE=y
> +CONFIG_FRAMEBUFFER_CONSOLE=y
> +# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> +# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> +# CONFIG_FONTS is not set
> +CONFIG_LOGO=y
> +CONFIG_LOGO_LINUX_MONO=y
> +CONFIG_LOGO_LINUX_VGA16=y
> +CONFIG_LOGO_LINUX_CLUT224=y
>  CONFIG_SOUND=y
>  # CONFIG_SOUND_OSS_CORE is not set
>  CONFIG_SND=y
> diff --git a/arch/arm/configs/omap_zoom3_defconfig
> b/arch/arm/configs/omap_zoom3_defconfig
> index 5e55b55..7137843 100644
> --- a/arch/arm/configs/omap_zoom3_defconfig
> +++ b/arch/arm/configs/omap_zoom3_defconfig
> @@ -887,7 +887,57 @@ CONFIG_REGULATOR_TWL4030=y
>  #
>  # CONFIG_VGASTATE is not set
>  CONFIG_VIDEO_OUTPUT_CONTROL=m
> -# CONFIG_FB is not set
> +CONFIG_FB=y
> +# CONFIG_FIRMWARE_EDID is not set
> +# CONFIG_FB_DDC is not set
> +# CONFIG_FB_BOOT_VESA_SUPPORT is not set
> +CONFIG_FB_CFB_FILLRECT=y
> +CONFIG_FB_CFB_COPYAREA=y
> +CONFIG_FB_CFB_IMAGEBLIT=y
> +# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> +# CONFIG_FB_SYS_FILLRECT is not set
> +# CONFIG_FB_SYS_COPYAREA is not set
> +# CONFIG_FB_SYS_IMAGEBLIT is not set
> +# CONFIG_FB_FOREIGN_ENDIAN is not set
> +# CONFIG_FB_SYS_FOPS is not set
> +# CONFIG_FB_SVGALIB is not set
> +# CONFIG_FB_MACMODES is not set
> +# CONFIG_FB_BACKLIGHT is not set
> +# CONFIG_FB_MODE_HELPERS is not set
> +# CONFIG_FB_TILEBLITTING is not set
> +
> +#
> +# Frame buffer hardware drivers
> +#
> +# CONFIG_FB_UVESA is not set
> +# CONFIG_FB_S1D13XXX is not set
> +# CONFIG_FB_VIRTUAL is not set
> +# CONFIG_FB_METRONOME is not set
> +# CONFIG_FB_MB862XX is not set
> +# CONFIG_FB_BROADSHEET is not set
> +# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> +CONFIG_OMAP2_VRAM=y
> +CONFIG_OMAP2_VRFB=y
> +CONFIG_OMAP2_DSS=y
> +CONFIG_OMAP2_VRAM_SIZE=4
> +# CONFIG_OMAP2_DSS_DEBUG_SUPPORT is not set
> +# CONFIG_OMAP2_DSS_RFBI is not set
> +CONFIG_OMAP2_DSS_VENC=y
> +# CONFIG_OMAP2_DSS_SDI is not set
> +# CONFIG_OMAP2_DSS_DSI is not set
> +# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
> +CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4
> +CONFIG_FB_OMAP2=y
> +# CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
> +# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
> +CONFIG_FB_OMAP2_NUM_FBS=3
> +
> +#
> +# OMAP2/3 Display Device Drivers
> +#
> +# CONFIG_PANEL_GENERIC is not set
> +# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
> +CONFIG_PANEL_NEC_NL8048HL11_01B=y
>  # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
>  #
> @@ -900,6 +950,14 @@ CONFIG_VIDEO_OUTPUT_CONTROL=m
>  #
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_DUMMY_CONSOLE=y
> +CONFIG_FRAMEBUFFER_CONSOLE=y
> +# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> +# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> +# CONFIG_FONTS is not set
> +CONFIG_LOGO=y
> +CONFIG_LOGO_LINUX_MONO=y
> +CONFIG_LOGO_LINUX_VGA16=y
> +CONFIG_LOGO_LINUX_CLUT224=y
>  CONFIG_SOUND=y
>  # CONFIG_SOUND_OSS_CORE is not set
>  CONFIG_SND=y
> --
> 1.5.6.3
> 
> 
> Regards,
> Kishore Y
