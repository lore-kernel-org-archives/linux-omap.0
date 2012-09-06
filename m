From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] musb: Kill __init from function that are called at other times as well.
Date: Thu, 6 Sep 2012 17:58:27 +0300
Message-ID: <B7BE7E99-90E8-4E54-B146-C09C6643BAFE@antoniou-consulting.com>
References: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com> <20120906130425.GF29202@arwen.pp.htv.fi>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:50960 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757369Ab2IFO6c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Sep 2012 10:58:32 -0400
In-Reply-To: <20120906130425.GF29202@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, Russ Dill <Russ.Dill@ti.com>

Hi Felipe,

A proper answer required some instrumentation printks().

So what I did is that I peppered each function marked with a removed
__init or __devinit with a 

> printk(KERN_INFO "%s:%d (%s) %s\n", __FILE__, __LINE__, KBUILD_MODNAME, __func__);
> 

Both omap2430 & musb_hdrc are compiled as module, and I issued the following 
commands on a beagleboard xm.

# modprobe omap2430
# modprobe g_mass_storage file=backing_file
# rmmod g_mass_storage
# rmmod omap2430
# modprobe omap2430

The problem is obvious when you see that functions marked as init or devinit are
called when re-loading the omap2430 module again. Those functions if marked as
much can (and will as I have witnessed) be removed from memory, leading to a 
crash.

What do you think?

Regards

-- Pantelis


On Sep 6, 2012, at 4:04 PM, Felipe Balbi wrote:

> On Thu, Sep 06, 2012 at 05:01:46PM +0300, Pantelis Antoniou wrote:
>> Marking functions as __init or __devinit and calling them at other times
>> leads to predictable crashes (if you're lucky).
>> 
>> Remove them for now.
>> 
>> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>> ---
>> drivers/usb/musb/musb_core.c    | 16 ++++++++--------
>> drivers/usb/musb/musb_debugfs.c |  2 +-
>> drivers/usb/musb/musb_dma.h     |  2 +-
>> drivers/usb/musb/musb_gadget.c  |  6 +++---
>> drivers/usb/musb/musbhsdma.c    |  2 +-
>> drivers/usb/musb/omap2430.c     |  2 +-
>> 6 files changed, 15 insertions(+), 15 deletions(-)
>> 
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>> index 26f1bef..215d2d5 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -1160,7 +1160,7 @@ static struct musb_fifo_cfg __devinitdata mode_5_cfg[] = {
>>  *
>>  * returns negative errno or offset for next fifo.
>>  */
>> -static int __devinit
>> +static int
>> fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
>> 		const struct musb_fifo_cfg *cfg, u16 offset)
> 
> Are you sure all these functions are called from outside .init.text ? At
> least fifo_setup(), ep_config_from_table() and musb_core_init() are only
> during probe(), which sits in .init.text too.
> 
> -- 
> balbi


Log...

> root@beagleboard:~# modprobe omap2430 
> [  114.643920] drivers/usb/musb/omap2430.c:584 (omap2430) omap2430_init
> [  114.650939] drivers/usb/musb/omap2430.c:445 (omap2430) omap2430_probe
> [  114.792205] drivers/usb/musb/musb_core.c:2409 (musb_hdrc) musb_init
> [  114.798889] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> [  114.805358] drivers/usb/musb/musb_core.c:2118 (musb_hdrc) musb_probe
> [  114.812225] drivers/usb/musb/musb_core.c:1888 (musb_hdrc) musb_init_controller
> [  114.819824] drivers/usb/musb/musb_core.c:1813 (musb_hdrc) allocate_instance
> [  114.835723] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  114.841339] drivers/usb/musb/musbhsdma.c:391 (musb_hdrc) dma_controller_create
> [  114.848999] drivers/usb/musb/musb_core.c:1388 (musb_hdrc) musb_core_init
> [  114.856079] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
> [  114.867095] musb-hdrc: MHDRC RTL version 1.800 
> [  114.871887] drivers/usb/musb/musb_core.c:1246 (musb_hdrc) ep_config_from_table
> [  114.879486] musb-hdrc: setup fifo_mode 4
> [  114.883666] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.890319] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.897033] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.903686] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.910369] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.917083] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.923767] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.930480] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.937133] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.943817] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.950500] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.957183] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.963867] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.970550] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.977264] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.983947] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.990631] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  114.997314] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.003997] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.010711] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.017395] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.024078] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.030761] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.037475] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.044158] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.050842] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.057556] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.064239] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  115.070922] musb-hdrc: 28/31 max ep, 16384/16384 memory
> [  115.076599] drivers/usb/musb/musb_gadget.c:1879 (musb_hdrc) musb_gadget_setup
> [  115.084136] drivers/usb/musb/musb_gadget.c:1842 (musb_hdrc) musb_g_init_endpoints
> [  115.092010] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.099609] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.107238] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.114837] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.122406] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.130035] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.137634] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.145233] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.152832] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.160461] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.168060] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.175689] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.183288] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.190948] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.198516] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.206146] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.213775] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.221374] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.229003] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.236633] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.244232] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.251861] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.259460] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.267089] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.274688] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.282287] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.289916] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.297546] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  115.307617] musb-hdrc musb-hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92
> [  115.324279] twl4030_usb twl4030_usb: twl4030_phy_suspend
> 
> root@beagleboard:~# lsmod
> Module                  Size  Used by
> musb_hdrc              53393  0 
> omap2430                5518  0 
> root@beagleboard:~# modprobe g_mass_storage file=backing_file
> [  138.156799] udc musb-hdrc: registering UDC driver [g_mass_storage]
> [  138.163330]  gadget: adding config #1 'Linux File-Backed Storage'/bf0217e8
> [  138.171966]  lun0: open backing file: backing_file
> [  138.182464]  gadget: Mass Storage Function, version: 2009/09/11
> [  138.188812]  gadget: Number of LUNs=1
> [  138.192901]  lun0: LUN: file: /home/root/backing_file
> [  138.198272]  gadget: I/O thread pid: 1976
> [  138.202484]  gadget: adding 'Mass Storage Function'/ddda81c0 to config 'Linux File-Backed Storage'/bf0217e8
> [  138.212799]  gadget: cfg 1/bf0217e8 speeds: high full
> [  138.218109]  gadget:   interface 0 = Mass Storage Function/ddda81c0
> [  138.224731]  gadget: Mass Storage Gadget, version: 2009/09/11
> [  138.230804]  gadget: userspace failed to provide iSerialNumber
> [  138.236968]  gadget: g_mass_storage ready[  138.252227] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  138.252441] musb-hdrc musb-hdrc: MUSB HDRC host driver
> [  138.254364] musb-hdrc musb-hdrc: new USB bus registered, assigned bus number 2
> [  138.254821] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
> [  138.254852] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [  138.254852] usb usb2: Product: MUSB HDRC host driver
> [  138.254852] usb usb2: Manufacturer: Linux 3.6.0-rc4-01179-g83ccc22-dirty musb-hcd
> [  138.254882] usb usb2: SerialNumber: musb-hdrc
> [  138.257629] hub 2-0:1.0: USB hub found
> [  138.257843] hub 2-0:1.0: 1 port detected
> [  138.347778] twl4030_usb twl4030_usb: HW_CONDITIONS 0xc0/192; link 3
> [  138.670959] twl4030_usb twl4030_usb: HW_CONDITIONS 0x40/64; link 4
> [  138.680175] twl4030_usb twl4030_usb: twl4030_phy_suspend
> 
> root@beagleboard:~# rmmod g_mass_storage
> [  144.341522] g_mass_storage musb-hdrc: unregistering UDC driver [musb-hdrc]
> [  144.360473] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  144.366333]  gadget: unbind function 'Mass Storage Function'/ddda81c0
> [  144.373199]  gadget: unbind
> [  144.381652] twl4030_usb twl4030_usb: twl4030_phy_suspend
> [  144.389312]  lun0: close backing file
> [  144.400421] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  144.406036] musb-hdrc musb-hdrc: remove, state 4
> [  144.411590] usb usb2: USB disconnect, device number 1
> [  144.429382] musb-hdrc musb-hdrc: USB bus 2 deregistered
> [  144.464599] twl4030_usb twl4030_usb: twl4030_phy_suspend
> root@beagleboard:~# rmmod omap2430 
> [  148.530517] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  148.540649] twl4030_usb twl4030_usb: twl4030_phy_suspend
> [  148.552124] udc musb-hdrc: releasing 'musb-hdrc'
> root@beagleboard:~# modprobe omap2430 
> [  154.626739] drivers/usb/musb/omap2430.c:584 (omap2430) omap2430_init
> [  154.633728] drivers/usb/musb/omap2430.c:445 (omap2430) omap2430_probe
> [  154.640533] musb-omap2430 musb-omap2430: Unbalanced pm_runtime_enable!
> [  154.647918] drivers/usb/musb/musb_core.c:2118 (musb_hdrc) musb_probe
> [  154.654663] drivers/usb/musb/musb_core.c:1888 (musb_hdrc) musb_init_controller
> [  154.662292] drivers/usb/musb/musb_core.c:1813 (musb_hdrc) allocate_instance
> [  154.698333] twl4030_usb twl4030_usb: twl4030_phy_resume
> [  154.704010] drivers/usb/musb/musbhsdma.c:391 (musb_hdrc) dma_controller_create
> [  154.711761] drivers/usb/musb/musb_core.c:1388 (musb_hdrc) musb_core_init
> [  154.718811] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
> [  154.729888] musb-hdrc: MHDRC RTL version 1.800 
> [  154.734680] drivers/usb/musb/musb_core.c:1246 (musb_hdrc) ep_config_from_table
> [  154.742279] musb-hdrc: setup fifo_mode 4
> [  154.746398] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.753082] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.759765] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.766479] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.773162] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.779846] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.786529] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.793212] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.799926] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.806640] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.813323] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.819976] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.826660] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.833343] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.840026] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.846710] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.853393] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.860107] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.866760] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.873443] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.880126] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.886840] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.893524] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.900207] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.906860] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.913513] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.920196] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.926879] drivers/usb/musb/musb_core.c:1173 (musb_hdrc) fifo_setup
> [  154.933593] musb-hdrc: 28/31 max ep, 16384/16384 memory
> [  154.939331] drivers/usb/musb/musb_gadget.c:1879 (musb_hdrc) musb_gadget_setup
> [  154.946838] drivers/usb/musb/musb_gadget.c:1842 (musb_hdrc) musb_g_init_endpoints
> [  154.954742] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  154.962341] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  154.969909] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  154.977539] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  154.985137] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  154.992736] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.000305] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.007904] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.015472] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.023071] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.030700] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.038269] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.045898] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.053497] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.061096] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.068695] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.076293] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.083923] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.091522] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.099090] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.106689] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.114318] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.121917] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.129486] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.137084] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.144683] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.152282] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.159881] drivers/usb/musb/musb_gadget.c:1803 (musb_hdrc) init_peripheral_ep
> [  155.169403] musb-hdrc musb-hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92
> [  155.198974] twl4030_usb twl4030_usb: twl4030_phy_suspend
> 

