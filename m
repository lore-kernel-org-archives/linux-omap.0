From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH] musb: Kill __init from function that are called at other times as well.
Date: Thu, 6 Sep 2012 21:58:56 +0300
Message-ID: <2D55E1E8-928C-4D68-97C3-D89097A9191C@antoniou-consulting.com>
References: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com> <20120906130425.GF29202@arwen.pp.htv.fi> <B7BE7E99-90E8-4E54-B146-C09C6643BAFE@antoniou-consulting.com> <20120906170740.GB17754@arwen.pp.htv.fi> <7CED20FA-3501-40ED-B289-28FDC04FCF20@antoniou-consulting.com> <20120906173724.GE30717@arwen.pp.htv.fi> <5607ED12-1C7D-4455-A716-F611B747BADF@antoniou-consulting.com> <20120906174139.GF30717@arwen.pp.htv.fi>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120906174139.GF30717-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Sep 6, 2012, at 8:41 PM, Felipe Balbi wrote:

> Hi,
> 
> On Thu, Sep 06, 2012 at 08:42:56PM +0300, Pantelis Antoniou wrote:
>> 
>> On Sep 6, 2012, at 8:37 PM, Felipe Balbi wrote:
>> 
>>> Hi,
>>> 
>>> On Thu, Sep 06, 2012 at 08:36:39PM +0300, Pantelis Antoniou wrote:
>>>> Hi Felipe
>>>> 
>>>> I see about __devinit.
>>>> There's no crash because in those logs the __init modifiers are gone.
>>> 
>>> it'd be cool to see the crash, though ;-)
>>> 
>>> -- 
>>> balbi
>> 
>> Heh, OK,
>> 
>> My word is not enough? :)
>> 
>> Gimme a few minutes...
> 
> Didn't say that, but I don't know what issue you're talking about since
> __devinit is supposed to keep .devinit.text intact unless !HOTPLUG.
> 
> This could be a bug on some linker script (though unlikely) just trying
> to get understand the issue before I apply the patch, that's all.
> 
> -- 
> balbi

With my init removal patch reverted, but with the instrumentation printk still in
Board hanged this time. It is not certain you will crash, you might get a hang or
anything else. It all depends on what kind of garbage is there in memory when you
start calling into the void.

The results are boundedly undefined :)

Regards

-- Pantelis
  
 
> root@beagleboard:~# modprobe omap2430
> [  119.741851] drivers/usb/musb/omap2430.c:584 (omap2430) omap2430_init
> [  119.748870] drivers/usb/musb/omap2430.c:445 (omap2430) omap2430_probe
> root@beagleboard:~# [  119.797760] drivers/usb/musb/musb_core.c:2409 (musb_hdrc) musb_init
> [  119.804504] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> [  119.811004] drivers/usb/musb/musb_core.c:2118 (musb_hdrc) musb_probe
> [  119.817962] drivers/usb/musb/musb_core.c:1888 (musb_hdrc) musb_init_controller
> [  119.825622] drivers/usb/musb/musb_core.c:1813 (musb_hdrc) allocate_instance
> [  119.841735] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  119.847290] drivers/usb/musb/musbhsdma.c:391 (musb_hdrc) dma_controller_create
> [  119.855041] drivers/usb/musb/musb_core.c:1388 (musb_hdrc) musb_core_init
> [  119.862121] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
> [  119.873229] musb-hdrc: MHDRC RTL version 1.800 
> [  119.877990] drivers/usb/musb/musb_core.c:1246 (musb_hdrc) ep_config_from_table
> [  119.885620] musb-hdrc: setup fifo_mode 4
> [  119.889801] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.896514] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.903228] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.909912] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.916625] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.923339] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.930084] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.936798] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.943542] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.950256] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.956939] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.963653] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.970367] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.977081] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.983825] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.990539] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  119.997253] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.003936] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.010650] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.017364] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.024078] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.030792] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.037536] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.044250] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.050933] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.057678] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.064392] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.071105] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  120.077819] musb-hdrc: 28/31 max ep, 16384/16384 memory
> [  120.083587] drivers/usb/musb/musb_gadget.c:1879 (musb_hdrc) musb_gadget_setup
> [  120.091156] drivers/usb/musb/musb_gadget.c:1842 (musb_hdrc) musb_g_init_endpoints
> [  120.099060] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.106689] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.114318] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.121948] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.129608] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.137237] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.144866] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.152465] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.160095] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.167724] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.175354] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.182983] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.190612] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.198272] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.205902] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.213531] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.221160] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.228790] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.236419] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.244049] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.251678] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.259338] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.266967] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.274597] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.282196] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.289855] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.297485] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.305114] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  120.315155] musb-hdrc musb-hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92
> [  120.415344] twl4030_usb twl4030_usb: twl4030_phy_suspend
> 
> INIT: Id "S" respawning too fast: disabled for 5 minutes
> ing_file
> [  132.275848] udc musb-hdrc: registering UDC driver [g_mass_storage]
> [  132.282501]  gadget: adding config #1 'Linux File-Backed Storage'/bf0207e8
> [  132.291137]  lun0: open backing file: backing_file
> [  132.304260]  gadget: Mass Storage Function, version: 2009/09/11
> [  132.310638]  gadget: Number of LUNs=1
> [  132.314758]  lun0: LUN: file: /home/root/backing_file
> [  132.320129]  gadget: I/O thread pid: 1979
> [  132.324371]  gadget: adding 'Mass Storage Function'/d7d6b740 to config 'Linux File-Backed Storage'/bf0207e8
> [  132.334686]  gadget: cfg 1/bf0207e8 speeds: high full
> [  132.339996]  gadget:   interface 0 = Mass Storage Function/d7d6b740
> [  132.346649]  gadget: Mass Storage Gadget, version: 2009/09/11
> [  132.352752]  gadget: userspace failed to provide iSerialNumber
> [  132.358978]  gadget: g_mass_storage ready
> [  132.375366] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  132.375549] musb-hdrc musb-hdrc: MUSB HDRC host driver
> [  132.377777] musb-hdrc musb-hdrc: new USB bus registered, assigned bus number 2
> [  132.378295] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
> [  132.378326] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [  132.378326] usb usb2: Product: MUSB HDRC host driver
> [  132.378356] usb usb2: Manufacturer: Linux 3.6.0-rc4-01179-g83ccc22-dirty musb-hcd
> [  132.378356] usb usb2: SerialNumber: musb-hdrc
> [  132.381072] hub 2-0:1.0: USB hub found
> [  132.381256] hub 2-0:1.0: 1 port detected
> root@beagleboard:~# [  132.471069] twl4030_usb twl4030_usb: HW_CONDITIONS 0xc0/192; link 3
> [  132.797393] twl4030_usb twl4030_usb: HW_CONDITIONS 0x40/64; link 4
> [  132.806701] twl4030_usb twl4030_usb: twl4030_phy_suspend
> 
> root@beagleboard:~# rmmod g_mass_storage
> [  139.405426] g_mass_storage musb-hdrc: unregistering UDC driver [musb-hdrc]
> [  139.424591] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  139.430450]  gadget: unbind function 'Mass Storage Function'/d7d6b740
> [  139.437316]  gadget: unbind
> [  139.445831] twl4030_usb twl4030_usb: twl4030_phy_suspend
> [  139.453552]  lun0: close backing file
> [  139.464691] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  139.470336] musb-hdrc musb-hdrc: remove, state 4
> [  139.475921] usb usb2: USB disconnect, device number 1
> [  139.493743] musb-hdrc musb-hdrc: USB bus 2 deregistered
> [  139.534484] twl4030_usb twl4030_usb: twl4030_phy_suspend
> root@beagleboard:~# rmmod omap2430 
> [  144.525634] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  144.534027] twl4030_usb twl4030_usb: twl4030_phy_suspend
> [  144.545501] udc musb-hdrc: releasing 'musb-hdrc'
> root@beagleboard:~# modprobe omap2430
> [  147.650756] drivers/usb/musb/omap2430.c:584 (omap2430) omap2430_init
> [  147.657806] drivers/usb/musb/omap2430.c:445 (omap2430) omap2430_probe
> [  147.664703] musb-omap2430 musb-omap2430: Unbalanced pm_runtime_enable!
> [  147.672119] drivers/usb/musb/musb_core.c:2118 (musb_hdrc) musb_probe
> [  147.678833] drivers/usb/musb/musb_core.c:1888 (musb_hdrc) musb_init_controller
> [  147.686523] drivers/usb/musb/musb_core.c:1813 (musb_hdrc) allocate_instance
> 

<HANG>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
