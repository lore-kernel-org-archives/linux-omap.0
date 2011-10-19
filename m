From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: Linux 3.0 DSS support
Date: Wed, 19 Oct 2011 09:27:38 -0400
Message-ID: <CANLagX8wKWW6Q9wQhM_Dm30LUWW9V=jPTwzPd654mKAQ=2oJ9g@mail.gmail.com>
References: <CANLagX8WaHGkqOZ2UnLR1ihOABbdDy1ZAyW19yO=f-JNUaLKfw@mail.gmail.com>
	<4E9BD71A.90703@ti.com>
	<CANLagX9R9DKi1MCa11t4REDFzRgXdJQWxNG4Q6mv46f8dACdSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61930 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab1JSN1j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Oct 2011 09:27:39 -0400
Received: by vws1 with SMTP id 1so1193861vws.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Oct 2011 06:27:38 -0700 (PDT)
In-Reply-To: <CANLagX9R9DKi1MCa11t4REDFzRgXdJQWxNG4Q6mv46f8dACdSQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Sending to the mailing list properly to see if anyone has any other
ideas for me to pursue..darn rich formatting prevented the previous
mails from getting to the list!

On Tue, Oct 18, 2011 at 12:59 PM, Ashwin Bihari <abihari@gmail.com> wro=
te:
> On Mon, Oct 17, 2011 at 3:19 AM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m>
> wrote:
>>
>> On 10/14/2011 07:52 PM, Ashwin Bihari wrote:
>>>
>>> Greetings,
>>>
>>> I'm trying to add support for our custom DM3730 based board to the =
Linux
>>> 3.0 Kernel and am having issues with the DSS support. I also have a
>>> AM3517 and BeagleBoard xM devkit as reference hardware. I've done s=
ome
>>> searching and have found that the AM3517 display support isn't full=
y
>>> functioning, so I tried to focus on the BeagleBoard xM which seems =
to be
>>> doing something but the LCD never comes to life.
>>
>> I don't have any of those boards, and I'm totally unfamiliar with DM=
3730
>> and AM3517, so I can't if the mainline works with them or not. But I=
 presume
>> DM3730 and AM3517 are using the same DSS hardware than OMAPs? From D=
SS
>> driver's perspective everything should be there, and if their board =
files
>> contain the definitions for the displays, then they should work.
>
> The DM3730 is essentially a die-shrink of the OMAP3530, so faster spe=
ed but
> same functionality. Heck, virtually all of the same OMAP3530 drivers =
just
> work on the DM3730, which is why I'm so darn confused as to why this =
isn't
> working.
>
>>>
>>> I'm currently using the following bootargs:
>>>
>>> console=3DttyO2,115200n8 mpurate=3Dauto buddy=3Dnone vram=3D12M
>>> omapfb.mode=3Ddvi:640x480MR-16@60 omapfb.debug=3Dy omapdss.def_disp=
=3Ddvi
>>> root=3D/dev/ram0 rw ramdisk_size=3D65536 initrd=3D0x81000000,64M
>>> rootfstype=3Dext2
>>>
>>> I have tried different resolutions which all yield the same blank s=
creen
>>> on the LCD with it going into power-save mode..
>>>
>>> I've looked at all the current board-* files that define displays a=
nd
>>> have done the same for my display, and the display portion itself s=
eems
>>> to run and my LCD gets powered-on and the backlight turned on, but =
I
>>> don't see a valid HSYNC or VSYNC signal out there..
>>
>> So are you using the DVI output or what? If so, is the DVI framer en=
abled?
>> Is pin muxing set up correctly?
>
> On the BeagleBoardXM, yes I was using the DVI for the output, on my c=
ustom
> DM3730 hardware, we're using the LCD as the output. The pin muxing is=
 setup
> correctly as far as I can tell, and I will check on the DVI framer to
> confirm that it's working.
> The pin muxing for all of the DSS pins are set to be MODE0..
>
>>>
>>> On the BeagleBoard xM, I also see the following debug messages from
>>> OMAPDSS and OMAPFB
>>>
>>> ---Begin OMAPDSS--
>>> [ =A0 =A01.175659] omapdss DSS: clk ick, rate 50000000
>>> [ =A0 =A01.175689] omapdss DSS: clk fck, rate 96000000
>>> [ =A0 =A01.175720] omapdss DSS: clk sys_clk, rate 13000000
>>> [ =A0 =A01.175750] omapdss DSS: clk tv_clk, rate 54000000
>>> [ =A0 =A01.175781] omapdss DSS: clk video_clk, rate 96000000
>>> [ =A0 =A01.175842] omapdss DSS: initial ctx id 0
>>> [ =A0 =A01.264221] omapdss CORE: bus_match. dev display0/generic_dp=
i_panel,
>>> drv venc
>>> [ =A0 =A01.264953] omapdss CORE: bus_match. dev display1/venc, drv =
venc
>>> [ =A0 =A01.265045] omapdss CORE: driver_probe: dev display1/venc, d=
rv venc
>>> [ =A0 =A01.265045] omapdss VENC: init_display
>>> [ =A0 =A01.265533] omapdss CORE: probe done for device display1
>>> [ =A0 =A01.265594] omapdss DSS: save context
>>> [ =A0 =A01.266479] omapdss CORE: bus_match. dev display0/generic_dp=
i_panel,
>>> drv generic_dpi_panel
>>> [ =A0 =A01.266540] omapdss CORE: driver_probe: dev
>>> display0/generic_dpi_panel, drv generic_dpi_panel
>>> [ =A0 =A01.266571] omapdss DPI: init_display
>>> [ =A0 =A01.266815] omapdss DSS: save context
>>> [ =A0 =A01.266906] omapdss DSS: save context
>>> [ =A0 =A01.266967] omapdss DSS: save context
>>> [ =A0 =A01.267028] omapdss CORE: probe done for device display0
>>> [ =A0 =A01.267059] omapdss CORE: bus_match. dev display1/venc, drv
>>> generic_dpi_panel
>>> [ =A0 =A02.689788] omapdss DPI: dpi_set_timings
>>> [ =A0 =A02.698883] omapdss MANAGER: omap_dss_mgr_apply(lcd)
>>> [ =A0 =A02.699157] omapdss MANAGER: configure_manager(0)
>>> [ =A0 =A02.699218] omapdss MANAGER: configure_manager(1)
>>> [ =A0 =A02.699279] omapdss DSS: save context
>>> [ =A0 =A02.715332] omapdss OVERLAY: check_overlay 0: (0,0 640x480 -=
>
>>> 640x480) disp (640x480)
>>> [ =A0 =A02.715362] omapdss MANAGER: omap_dss_mgr_apply(lcd)
>>> [ =A0 =A02.715423] omapdss OVERLAY: check_overlay 0: (0,0 640x480 -=
>
>>> 640x480) disp (640x480)
>>> [ =A0 =A02.715484] omapdss MANAGER: configure_overlay(0)
>>> [ =A0 =A02.715515] omapdss DISPC: dispc_setup_plane 0, pa 8f400000,=
 sw 640,
>>> 0, 0, 640x480 -> 640x480, ilace 0, cmode 40, rot 0, mir 0 chan 0
>>> [ =A0 =A02.715545] omapdss DISPC: calc_rot(0): scrw 640, 640x480
>>> [ =A0 =A02.715576] omapdss DISPC: offset0 0, offset1 0, row_inc 1, =
pix_inc 1
>>> [ =A0 =A02.715576] omapdss DISPC: 0,0 640x480 -> 640x480
>>> [ =A0 =A02.715637] omapdss DISPC: fifo(0) low/high old 960/1023, ne=
w 960/1023
>>> [ =A0 =A02.715667] omapdss DISPC: dispc_enable_plane 0, 1
>>> [ =A0 =A02.715698] omapdss DSS: save context
>>> [ =A0 =A02.715728] omapdss MANAGER: omap_dss_mgr_apply(tv)
>>> [ =A0 =A02.715759] omapdss DSS: save context
>>> [ =A0 =A02.716186] omapdss DISPC: onoff 0 rf 0 ieo 0 ipc 0 ihs 0 iv=
s 0 acbi
>>> 0 acb 0
>>> [ =A0 =A02.716217] omapdss DSS: dpll4_m4 =3D 864000000
>>> [ =A0 =A02.716247] omapdss DSS: fck =3D 48000000 (18)
>>> [ =A0 =A02.716278] omapdss DISPC: lck =3D 48000000 (1)
>>> [ =A0 =A02.716278] omapdss DISPC: pck =3D 24000000 (2)
>>> [ =A0 =A02.716339] omapdss DISPC: channel 0 xres 640 yres 480
>>> [ =A0 =A02.716339] omapdss DISPC: pck 24000
>>> [ =A0 =A02.716369] omapdss DISPC: hsw 32 hfp 48 hbp 80 vsw 4 vfp 7 =
vbp 3
>>> [ =A0 =A02.716369] omapdss DISPC: hsync 30000Hz, vsync 60Hz
>>> ---End OMAPDSS--
>>>
>>> ---Begin OMAPFB--
>>> [ =A0 =A02.684204] OMAPFB: omapfb_init
>>> [ =A0 =A02.684478] OMAPFB: omapfb_probe
>>> [ =A0 =A02.684570] fbcvt: 640x480@60: CVT Name - .307M3-R
>>> [ =A0 =A02.689849] OMAPFB: fb_infos allocated
>>> [ =A0 =A02.689880] OMAPFB: allocating 614400 bytes for fb 0
>>> [ =A0 =A02.693847] OMAPFB: fbmems allocated
>>> [ =A0 =A02.694030] OMAPFB: check_fb_var 0
>>> [ =A0 =A02.694091] OMAPFB: set_fb_fix
>>> [ =A0 =A02.694427] OMAPFB: fb_infos initialized
>>> [ =A0 =A02.698822] OMAPFB: set_fb_fix
>>> [ =A0 =A02.698822] OMAPFB: apply_changes, fb 0, ovl 0
>>> [ =A0 =A02.715209] OMAPFB: apply_changes, fb 0, ovl 0
>>> [ =A0 =A02.715270] OMAPFB: apply_changes, fb 1, ovl 1
>>> [ =A0 =A02.715301] OMAPFB: apply_changes, fb 2, ovl 2
>>> [ =A0 =A02.718109] OMAPFB: create sysfs for fbs
>>> [ =A0 =A02.718109] OMAPFB: create sysfs for fbs
>>> ---End OMAPFB--
>>
>> Everything seems to be ok there as far as I see.
>>
>> =A0Tomi
>
>
> -- Ashwin
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
