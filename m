From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: framebuffer and lcd question
Date: Fri, 6 Jun 2008 20:57:04 +0200
Message-ID: <EB74C93B-36C7-4E8A-B737-7652B030A2AD@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:50826 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbYFFTCr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jun 2008 15:02:47 -0400
Received: from [172.20.1.5] (vpn006121.vpn.utwente.nl [130.89.6.121])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m56Iv7WC003504
          for <linux-omap@vger.kernel.org>; Fri, 6 Jun 2008 20:57:09 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On the beagleboard we have the omapfb hooked up to a DVI framer  
(TFP410), with the EDID hooked up to omap-i2c bus 3[1]. The 'problem'  
we have is that we don't have a way to switch resolution in userspace  
because of this:

drivers/video/omap/lcd_omap3beagle.c

#define LCD_XRES                1600
#define LCD_YRES                1200
#define LCD_PIXCLOCK            65000 /* in kHz */

[..]

struct lcd_panel omap3beagle_panel = {
         .name           = "omap3beagle",
         .config         = OMAP_LCDC_PANEL_TFT,

         .bpp            = 24,
         .data_lines     = 24,
         .x_res          = LCD_XRES,
         .y_res          = LCD_YRES,

[..]

That hardcodes the resolution and bitdepth :(

Ideally the kernel would read and parse the EDID and adjust the  
resolution accordingly. We could use the fb_ddc driver:

int beagleboard_probe_i2c_connector(struct fb_info *info, u8
**out_edid)
{
         struct beagleboardfb_par *par = info->par;
         u8 *edid = NULL;

         DPRINTK("beagleboard DVI: Probe DDC\n);

         edid = fb_ddc_read(&omap3-i2c.3);

         *out_edid = edid;

         return (edid) ? 0 : 1;

}
But I don't see a way make that work with omapfb and lcd_omap3beagle.  
Does anyone have a suggestion on how to make this work? And after  
that, how can we hook in the image and videoplane migration between  
the DVI and s-video port?

regards,

Koen

[1]

root@beagleboard:/usr/sbin# decode-edid
decode-edid: using bus 3 (autodetected)
decode-edid: decode-edid version 1.1
parse-edid: parse-edid version 1.4.1
parse-edid: EDID checksum passed.

         # EDID version 1 revision 3
Section "Monitor"
         # Block type: 2:0 3:fd
         # Block type: 2:0 3:fc
         Identifier "AU5131      "
         VendorName "IVM"
         ModelName "AU5131      "
         # Block type: 2:0 3:fd
         HorizSync 24-80
         VertRefresh 50-85
         # Max dot clock (video bandwidth) 160 MHz
         # Block type: 2:0 3:fc
         # Block type: 2:0 3:ff
         # DPMS capabilities: Active off:yes  Suspend:yes  Standby:yes

         Mode    "1600x1200"     # vfreq 60.000Hz, hfreq 75.000kHz
                 DotClock        162.000000
                 HTimings        1600 1664 1856 2160
                 VTimings        1200 1201 1204 1250
                 Flags   "+HSync" "+VSync"
         EndMode
         # Block type: 2:0 3:fd
         # Block type: 2:0 3:fc
         # Block type: 2:0 3:ff
EndSection
root@beagleboard:/usr/sbin#







-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFISYiCMkyGM64RGpERAhSpAJwJLy2mNHCDFnpk8OPF3VHOczW5xACff7Jm
ioqUAiN3JUTGLDJUO7qvGZI=
=JaND
-----END PGP SIGNATURE-----
