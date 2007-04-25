From: "Hades Liu" <lcc0917@msn.com>
Subject: RE: TV-out problem
Date: Wed, 25 Apr 2007 20:24:18 +0900
Message-ID: <BAY111-F2834F47ABBF2631D0C2EA3A6490@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_7000_6840_586a"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: x0khasim@ti.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_7000_6840_586a
Content-Type: text/plain; format=flowed

Hi Khasim,
I have a new problem now.

When my board outputs image to tv-out, the output image is not completed. 
The partials of top and left are cut. Please reference to the attached file, 
ori_pic.jpg, for my original output on LCD, and file, out_pic.jpg, for my 
tv-out result.

I had tried to set several different video mode parameters such pixclock, 
left_margin, hsync_len, and so on in data structure h4_tv_var, file 
omap2_disp_out.c. But it doesn't improve anything. :(

What can I do to solve this problem? Or it is NTSC's constraints and I 
should reserve 16 pixes from top and left while writting data to frame 
buffer for tv-out?


Thank you.

Best Regards
Hades


>From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
>To: "Hades Liu" <lcc0917@msn.com>, <linux-omap-open-source@linux.omap.com>
>Subject: RE: TV-out problem
>Date: Mon, 23 Apr 2007 18:24:54 -0500
>
>
> >My code base is the newest version, 2.6.14, on linux.omap.com. But my 
>LCD's
> >resulution is 800x480 and the  frame buffer is the same, too.
>
>The VENC registers are configured for 640x480 only. If you need 800x480 
>then you might have to play around with VENC configuration a bit :(.
>I don't know where exactly you are configuring this, may be by default its 
>getting set to 640x480 just double check.
>
> >I found that the problem is caused by wrong frame buffer settings. I had
> >changed the default output device from LCD to TV, and the initialling
> >function will initialize frame buffer for default output device. The 
>tv-out
> >will work when set as default output device.
> >
> >However, when I change output device in kernel console via command,
> >echo tv > /sys/class/display_control/omap_disp_control/graphics,
> >the frame buffer seems not be reset for tv-out. The output result is not
> >correct and showen as descripted in before e-mail.Therefore, the frame
> >buffer should be reset for tv-out while changing the output device
> >dynamically.
> >
> >Is my absorbing correct?
>Partially correct. The console command just provides a way to switch the 
>pipeline to TV or LCD, its user's responsibility to do the corresponding 
>setting to FBDEV layer by changing the default var structure.
>After switching the console, I do something like shown below from app 
>layer.
>
>/* h4_tv_var can be found in drivers/video/omap/omap2_disp_out.c */
>if (output_dev == OMAP2_OUTPUT_TV)
>		vp = &h4_tv_var;
>else
>		vp = &h4_lcd_var;
>
>if(ret = ioctl(fd, FBIOPUT_VSCREENINFO, vp))
>		printf("setvar ioctl error\n");
>
> >If it is correct, willTI modify the code for this
> >issue in future version?
> >
>I don't consider this as an issue, its just a different approach of 
>handling the switching, there are other better ways like using IOCTL 
>instead of console command which we can be added - don't know when :( - 
>sorry
>
> >Another question: Is it possible to output to LCD and tv-out concurrently
> >with a single frame buffer?
> >
>Hardware doesn't allow us to connect a single pipeline to two output 
>devices, like we cannot connect GFX pipeline to both LCD and TV at same 
>time.
>
>However in our Video driver for Video pipelines we did a work around by 
>passing same framebuffer address (as in Video1) to Video2 and connecting 
>Video1 to LCD / Video 2 to TV. It will look like same data is being 
>displayed on LCD and TV simultaneously but internally we will be using 
>another pipeline to do the same. This is a good one, basically you can 
>scale or mirror or crop one of them and keep the other same.
>
>If it's needed for your product, you can actually do some kind of hack in 
>Framebuffer driver to use video1/video2 pipeline and pass same buffer 
>address to one of them and connect them to TV/LCD.
>
>Regards,
>Khasim

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

------=_NextPart_000_7000_6840_586a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_7000_6840_586a--
