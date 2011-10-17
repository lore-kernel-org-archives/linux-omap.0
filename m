From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Linux 3.0 DSS support
Date: Mon, 17 Oct 2011 10:19:54 +0300
Message-ID: <4E9BD71A.90703@ti.com>
References: <CANLagX8WaHGkqOZ2UnLR1ihOABbdDy1ZAyW19yO=f-JNUaLKfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:49337 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752521Ab1JQHUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Oct 2011 03:20:06 -0400
Received: by mail-bw0-f50.google.com with SMTP id q10so5919825bka.9
        for <linux-omap@vger.kernel.org>; Mon, 17 Oct 2011 00:19:58 -0700 (PDT)
In-Reply-To: <CANLagX8WaHGkqOZ2UnLR1ihOABbdDy1ZAyW19yO=f-JNUaLKfw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: linux-omap@vger.kernel.org

On 10/14/2011 07:52 PM, Ashwin Bihari wrote:
> Greetings,
>
> I'm trying to add support for our custom DM3730 based board to the Linux
> 3.0 Kernel and am having issues with the DSS support. I also have a
> AM3517 and BeagleBoard xM devkit as reference hardware. I've done some
> searching and have found that the AM3517 display support isn't fully
> functioning, so I tried to focus on the BeagleBoard xM which seems to be
> doing something but the LCD never comes to life.

I don't have any of those boards, and I'm totally unfamiliar with DM3730 
and AM3517, so I can't if the mainline works with them or not. But I 
presume DM3730 and AM3517 are using the same DSS hardware than OMAPs? 
 From DSS driver's perspective everything should be there, and if their 
board files contain the definitions for the displays, then they should work.

> I'm currently using the following bootargs:
>
> console=ttyO2,115200n8 mpurate=auto buddy=none vram=12M
> omapfb.mode=dvi:640x480MR-16@60 omapfb.debug=y omapdss.def_disp=dvi
> root=/dev/ram0 rw ramdisk_size=65536 initrd=0x81000000,64M rootfstype=ext2
>
> I have tried different resolutions which all yield the same blank screen
> on the LCD with it going into power-save mode..
>
> I've looked at all the current board-* files that define displays and
> have done the same for my display, and the display portion itself seems
> to run and my LCD gets powered-on and the backlight turned on, but I
> don't see a valid HSYNC or VSYNC signal out there..

So are you using the DVI output or what? If so, is the DVI framer 
enabled? Is pin muxing set up correctly?

> On the BeagleBoard xM, I also see the following debug messages from
> OMAPDSS and OMAPFB
>
> ---Begin OMAPDSS--
> [    1.175659] omapdss DSS: clk ick, rate 50000000
> [    1.175689] omapdss DSS: clk fck, rate 96000000
> [    1.175720] omapdss DSS: clk sys_clk, rate 13000000
> [    1.175750] omapdss DSS: clk tv_clk, rate 54000000
> [    1.175781] omapdss DSS: clk video_clk, rate 96000000
> [    1.175842] omapdss DSS: initial ctx id 0
> [    1.264221] omapdss CORE: bus_match. dev display0/generic_dpi_panel,
> drv venc
> [    1.264953] omapdss CORE: bus_match. dev display1/venc, drv venc
> [    1.265045] omapdss CORE: driver_probe: dev display1/venc, drv venc
> [    1.265045] omapdss VENC: init_display
> [    1.265533] omapdss CORE: probe done for device display1
> [    1.265594] omapdss DSS: save context
> [    1.266479] omapdss CORE: bus_match. dev display0/generic_dpi_panel,
> drv generic_dpi_panel
> [    1.266540] omapdss CORE: driver_probe: dev
> display0/generic_dpi_panel, drv generic_dpi_panel
> [    1.266571] omapdss DPI: init_display
> [    1.266815] omapdss DSS: save context
> [    1.266906] omapdss DSS: save context
> [    1.266967] omapdss DSS: save context
> [    1.267028] omapdss CORE: probe done for device display0
> [    1.267059] omapdss CORE: bus_match. dev display1/venc, drv
> generic_dpi_panel
> [    2.689788] omapdss DPI: dpi_set_timings
> [    2.698883] omapdss MANAGER: omap_dss_mgr_apply(lcd)
> [    2.699157] omapdss MANAGER: configure_manager(0)
> [    2.699218] omapdss MANAGER: configure_manager(1)
> [    2.699279] omapdss DSS: save context
> [    2.715332] omapdss OVERLAY: check_overlay 0: (0,0 640x480 ->
> 640x480) disp (640x480)
> [    2.715362] omapdss MANAGER: omap_dss_mgr_apply(lcd)
> [    2.715423] omapdss OVERLAY: check_overlay 0: (0,0 640x480 ->
> 640x480) disp (640x480)
> [    2.715484] omapdss MANAGER: configure_overlay(0)
> [    2.715515] omapdss DISPC: dispc_setup_plane 0, pa 8f400000, sw 640,
> 0, 0, 640x480 -> 640x480, ilace 0, cmode 40, rot 0, mir 0 chan 0
> [    2.715545] omapdss DISPC: calc_rot(0): scrw 640, 640x480
> [    2.715576] omapdss DISPC: offset0 0, offset1 0, row_inc 1, pix_inc 1
> [    2.715576] omapdss DISPC: 0,0 640x480 -> 640x480
> [    2.715637] omapdss DISPC: fifo(0) low/high old 960/1023, new 960/1023
> [    2.715667] omapdss DISPC: dispc_enable_plane 0, 1
> [    2.715698] omapdss DSS: save context
> [    2.715728] omapdss MANAGER: omap_dss_mgr_apply(tv)
> [    2.715759] omapdss DSS: save context
> [    2.716186] omapdss DISPC: onoff 0 rf 0 ieo 0 ipc 0 ihs 0 ivs 0 acbi
> 0 acb 0
> [    2.716217] omapdss DSS: dpll4_m4 = 864000000
> [    2.716247] omapdss DSS: fck = 48000000 (18)
> [    2.716278] omapdss DISPC: lck = 48000000 (1)
> [    2.716278] omapdss DISPC: pck = 24000000 (2)
> [    2.716339] omapdss DISPC: channel 0 xres 640 yres 480
> [    2.716339] omapdss DISPC: pck 24000
> [    2.716369] omapdss DISPC: hsw 32 hfp 48 hbp 80 vsw 4 vfp 7 vbp 3
> [    2.716369] omapdss DISPC: hsync 30000Hz, vsync 60Hz
> ---End OMAPDSS--
>
> ---Begin OMAPFB--
> [    2.684204] OMAPFB: omapfb_init
> [    2.684478] OMAPFB: omapfb_probe
> [    2.684570] fbcvt: 640x480@60: CVT Name - .307M3-R
> [    2.689849] OMAPFB: fb_infos allocated
> [    2.689880] OMAPFB: allocating 614400 bytes for fb 0
> [    2.693847] OMAPFB: fbmems allocated
> [    2.694030] OMAPFB: check_fb_var 0
> [    2.694091] OMAPFB: set_fb_fix
> [    2.694427] OMAPFB: fb_infos initialized
> [    2.698822] OMAPFB: set_fb_fix
> [    2.698822] OMAPFB: apply_changes, fb 0, ovl 0
> [    2.715209] OMAPFB: apply_changes, fb 0, ovl 0
> [    2.715270] OMAPFB: apply_changes, fb 1, ovl 1
> [    2.715301] OMAPFB: apply_changes, fb 2, ovl 2
> [    2.718109] OMAPFB: create sysfs for fbs
> [    2.718109] OMAPFB: create sysfs for fbs
> ---End OMAPFB--

Everything seems to be ok there as far as I see.

  Tomi
