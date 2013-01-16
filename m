From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: Does USB isochronous mode work on EHCI port?
Date: Wed, 16 Jan 2013 13:34:31 +0200
Message-ID: <50F69047.6060904@ti.com>
References: <32bbff70-2fcd-4993-92ea-385ab02f735a@googlegroups.com> <eb7a9da0-7556-4d8f-b7b4-bf29768082df@googlegroups.com> <6ffddeae-3f7b-4972-a485-c62ecc7e2cdb@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6ffddeae-3f7b-4972-a485-c62ecc7e2cdb-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gary Thomas <samoht.yrag-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Boudet, Xavier" <x-boudet-l0cyMroinI0@public.gmane.org>, "Dechesne, Nicolas" <n-dechesne-l0cyMroinI0@public.gmane.org>, "Fache, Herve" <h-fache-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/04/2013 02:20 PM, Gary Thomas wrote:
> 
> 
> On Thursday, January 3, 2013 9:21:19 AM UTC-7, Felipe Balbi wrote:
> 
>     Hi,
> 
>     On Wednesday, January 2, 2013 10:44:50 PM UTC+2, Gary Thomas wrote:
> 
>         I have a video adapter attached to my EHCI port which runs full
>         speed (480Mb/s) isochronous mode.  Sadly, I never get any data
>         from the device (it uses the EM28xx driver).
>         This same device + driver works fine on my laptop and from what
>         I can tell looking at the module debug, it's failing when
>         waiting for the ISOC frame data to arrive.
> 
>         Should this work?  I recall lots of discussion in the past about
>         ISOC transfers not working on certain OMAP devices...
> 
> 
>     which kernel are you using ? Have you tested mainline kernel ?
> 
> 
> I'm using the TI/Ubuntu kernel ( ti-ubuntu-3.4.0-1489.17)
> 
> Using the mainline would be hard as there is a lot in this kernel that
> isn't in the mainline.
> 

+Xavier, Nicolas, Herve

Finally got a chance to try this out. I used uvccapture and luvcview for
my tests.

There is a problem with the TI/Ubuntu kernel. uvccapture works but
luvcview segfaults after a few VIDEOC_QBUF operations (see log in the
end). I don't see anything wrong with the USB traces though.

After disabling all CONFIG_VIDEOBUF options in kernel config (except
CONFIG_VIDEOBUF2_CORE=m, CONFIG_VIDEOBUF2_MEMOPS=m,
CONFIG_VIDEOBUF2_VMALLOC=m) and recompiling the kernel, I could get
luvcview to work.

So the problem is not in USB EHCI but in the DMA/DMAbuf implementation
of VIDEOBUF.

cheers,
-roger

--log--
> luvcview 
> luvcview 0.2.6
> 
> init kbd.
> SDL information:[   37.955749] uvcvideo: uvc_v4l2_open
> 
>   Video driver: fbcon
>   Hardware surfaces are available (3072k video memory)
> Device information:
>   Device path:  /dev/video0
> [   38.105346] usb 1-1.3: reset high-speed USB device number 4 using ehci-omap
> [   38.439178] uvcvideo: Resuming interface 0
> [   38.443542] uvcvideo: Resuming interface 1
> [   38.456970] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QUERYCAP)
> [   38.462310] uvcvideo: uvc_v4l2_ioctl(VIDIOC_G_FMT)
> [   38.467407] uvcvideo: uvc_v4l2_ioctl(VIDIOC_G_PARM)
> [   38.472717] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FMT)
> [   38.478057] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.484100] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.490112] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.496124] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.502075] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.508117] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.514129] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.520141] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.526092] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.532135] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.538146] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.544158] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.550140] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.556152] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.562164] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.568328] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.574340] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.580291] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.586334] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.592346] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.598358] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FMT)
> [   38.603698] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.609710] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.615753] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.621765] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.627716] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.633758] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.639770] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.645782] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.651763] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.657806] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.663940] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.669952] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.675964] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.681915] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.687927] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.693939] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.699951] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.705932] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.711975] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.717987] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FRAMESIZES)
> [   38.723999] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FMT)
> [   38.729309] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QUERYCAP)
> [   38.734741] uvcvideo: uvc_v4l2_ioctl(VIDIOC_G_INPUT)
> [   38.740051] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUMINPUT)
> [   38.746154] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QUERYCTRL)
> [   38.751617] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QUERYCAP)
> Stream settings:[   38.757171] uvcvideo: uvc_v4l2_ioctl(
> VIDIOC_ENUM_FMT)
> [   38.764068] uvcvideo: uvc_v4l2_ioctl(VIDIOC_ENUM_FMT)
>   Frame format: [   38.769500] uvcvideo: uvc_v4l2_ioctl(MJPG
> VIDIOC_TRY_FMT)
> [   38.776641] uvcvideo: Trying format 0x47504a4d (MJPG): 640x480.
> [   38.782928] uvcvideo: Using default frame interval 33333.3 us (30.0 fps).
> [   38.813446] uvcvideo: uvc_v4l2_ioctl(VIDIOC_S_FMT)
> [   38.818542] uvcvideo: Trying format 0x47504a4d (MJPG): 640x480.
> [   38.824859] uvcvideo: Using default frame interval 33333.3 us (30.0 fps).
> [   38.855560] uvcvideo: uvc_v4l2_ioctl(VIDIOC_G_PARM)
>   Frame size:   [   38.860748] uvcvideo: uvc_v4l2_ioctl(640x480
> VIDIOC_S_PARM)
> [   38.868072] uvcvideo: Setting frame interval to 1/30 (333333).
> [   38.897796] uvcvideo: uvc_v4l2_ioctl(VIDIOC_G_PARM)
>   Frame rate:   [   38.903045] uvcvideo: uvc_v4l2_ioctl(30 fps
> VIDIOC_REQBUFS)
> [   38.911071] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QUERYBUF)
> [   38.916442] uvcvideo: uvc_v4l2_mmap
> [   38.920501] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QUERYBUF)
> [   38.925903] uvcvideo: uvc_v4l2_mmap
> [   38.930023] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QUERYBUF)
> [   38.935424] uvcvideo: uvc_v4l2_mmap
> [   38.939514] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QUERYBUF)
> [   38.944915] uvcvideo: uvc_v4l2_mmap
> [   38.949005] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QBUF)
> [   38.953979] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QBUF)
> [   38.958984] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QBUF)
> [   38.963958] uvcvideo: uvc_v4l2_ioctl(VIDIOC_QBUF)
> [   39.029357] uvcvideo: uvc_v4l2_release
> Segmentation fault


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
