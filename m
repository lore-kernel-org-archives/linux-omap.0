From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Thu, 20 Oct 2016 21:36:12 +0200
Message-ID: <20161020193612.GA29736@localhost.localdomain>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com>
 <20161020082318.GA2903@localhost.localdomain>
 <20161020123524.oepmqvlhzzu7elgj@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161020123524.oepmqvlhzzu7elgj-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 20, 2016 at 05:35:24AM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161020 01:24]:
> > On Wed, Oct 19, 2016 at 12:03:38PM -0500, Bin Liu wrote:
> > > Hi Greg,
> > > 
> > > Here are musb pm fixes for v4.9-rc2.  Please let me know if any change is
> > > needed.
> > 
> > Hi Bin, Tony,
> > 
> > just moved away from 4.6 where musb worked (well, not quite reliably, but...)
> > in host only mode with dma on dm3730. Later kernels do not work at all,
> > devices get enumerated, but after a while I get:
> > [   23.750061] musb_host_rx 1970: Rx interrupt with no errors or packet!
> > [   23.757232] musb_host_rx 1970: Rx interrupt with no errors or packet!
> > [   23.764739] musb_host_rx 1970: Rx interrupt with no errors or packet!
> > [   23.771850] musb_host_rx 1970: Rx interrupt with no errors or packet!
> > [   23.778900] musb_host_rx 1970: Rx interrupt with no errors or packet!
> > [   23.785980] musb_host_rx 1970: Rx interrupt with no errors or packet!
> > [   23.793151] musb_host_rx 1970: Rx interrupt with no errors or packet!
> > [   29.281494] udlfb: wait for urb interrupted: ffffffc2 available: 0

Also saw this now after hub unplug:
[   94.283813] musb_stage0_irq 883: unhandled DISCONNECT transition (a_idle)

> > Last line is printed repeatedly even after I disconnect udlfb device, so
> > driver is unnoticed about disconnect.
> 
> I don't think I've seen that error..

Comment in code reads: 'FIXME this is another "SHOULD NEVER HAPPEN"'

> > Diffing linux-4.7 (not working) against 4.6 didn't show anything suspicious
> > and 4.8 adds only some tracepoints over 4.7, so the above is with 4.8.2.
> > 
> > Any pointers how to best do my homework and find what's wrong?
> 
> There are few patches that we seem to need for v4.7 and v4.8 stable.
> At least these two fixes that should be merged for v4.9 should be
> in:
> 
> [PATCH 0/2] Fixes for two more musb regressions
> 
> Then two patches for phy-twl4030-usb.c:
> 
> b78ea84a7d45 ("phy-twl4030-usb: initialize charging-related stuff via
> pm_runtime")
> 78489c7c48d4 ("phy-twl4030-usb: better handle musb_mailbox() failure")
> 
> Are you using the twl4030 phy or something else? Also, care to try

twl4030.

> with v4.9-rc + [PATCH 0/2] Fixes for two more musb regressions?

Compiled recent Linus' git tree with those two patches on top of it.
It doesn't work either, but I found that when I unplug hub from musb
during bootup and connect is again after musb gets initialized, it works
normally. Well, almost... It does survive only few reconnects, then
ends with:
<connect>
[  135.150878] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_host (90, <VBusValid), retry #3, port1 0009010d
[  139.793579] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[  144.133575] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[  148.463653] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[  152.793609] usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
[  152.809936] usb usb2-port1: unable to enumerate USB device
[  153.063568] usb usb2-port1: over-current condition
<disconnect>
<connect>
[  159.343444] usb 2-1: new high-speed USB device number 12 using musb-hdrc
[  159.526763] usb 2-1: New USB device found, idVendor=05e3, idProduct=0608
[  159.533935] usb 2-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  159.541473] usb 2-1: Product: USB2.0 Hub
etc... working normaly...
<disconnect>
[  161.743743] udlfb: released /dev/fb0 user=1 count=1
[  167.515075] usb 2-1: USB disconnect, device number 12
[  167.520507] usb 2-1.4: USB disconnect, device number 13
[  167.526153] usb 2-1.4.2: USB disconnect, device number 14
[  167.532989] udlfb: USB disconnect starting
[  167.537414] udlfb: Freeing all render urbs
[  167.604949] udlfb: released /dev/fb0 user=1 count=0
[  167.611602] usb 2-1.4.4: USB disconnect, device number 15
[  167.618560] cdc_acm 2-1.4.4:1.0: failed to set dtr/rts
[  167.624237] cdc_acm 2-1.4.4:1.1: urb 5 failed submission with -19
[  167.630737] cdc_acm 2-1.4.4:1.1: urb 6 failed submission with -19
[  167.637329] cdc_acm 2-1.4.4:1.1: urb 7 failed submission with -19
[  167.643859] cdc_acm 2-1.4.4:1.1: urb 8 failed submission with -19
[  167.650299] cdc_acm 2-1.4.4:1.1: urb 9 failed submission with -19
[  167.656860] cdc_acm 2-1.4.4:1.1: urb 10 failed submission with -19
[  167.663482] cdc_acm 2-1.4.4:1.1: urb 11 failed submission with -19
[  167.670043] cdc_acm 2-1.4.4:1.1: urb 12 failed submission with -19
[  167.676696] cdc_acm 2-1.4.4:1.1: urb 13 failed submission with -19
[  167.683319] cdc_acm 2-1.4.4:1.1: urb 14 failed submission with -19
[  167.689880] cdc_acm 2-1.4.4:1.1: urb 15 failed submission with -19
[  168.643890] udlfb: fb_info for /dev/fb0 has been freed
[  168.649810] udlfb: freeing dlfb_data ce247800
<disconnect>
<connect>
[  171.763488] usb 2-1: new high-speed USB device number 16 using musb-hdrc
[  171.956817] usb 2-1: New USB device found, idVendor=05e3, idProduct=0608
[  171.964019] usb 2-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  171.971557] usb 2-1: Product: USB2.0 Hub
[  172.088592] hub 2-1:1.0: USB hub found
[  172.122711] hub 2-1:1.0: 4 ports detected
[  172.473419] usb 2-1.4: new high-speed USB device number 17 using musb-hdrc
[  172.626312] usb 2-1.4: New USB device found, idVendor=05e3, idProduct=0608
[  172.633697] usb 2-1.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  172.641418] usb 2-1.4: Product: USB2.0 Hub
[  172.714416] hub 2-1.4:1.0: USB hub found
[  172.749389] hub 2-1.4:1.0: 4 ports detected
[  173.103851] usb 2-1.4.2: new high-speed USB device number 18 using musb-hdrc
[  173.278533] usb 2-1.4.2: New USB device found, idVendor=17e9, idProduct=0335
[  173.286102] usb 2-1.4.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  173.294067] usb 2-1.4.2: Product: MIMO
[  173.298034] usb 2-1.4.2: Manufacturer: DisplayLink
[  173.303070] usb 2-1.4.2: SerialNumber: 1071007195
[  173.406311] udlfb: DisplayLink MIMO - serial #1071007195
[  173.411987] udlfb: vid_17e9&pid_0335&rev_0120 driver's dlfb_data struct at ce247800
[  173.420135] udlfb: console enable=1
[  173.423889] udlfb: fb_defio enable=1
[  173.427642] udlfb: shadow enable=1
[  173.515655] udlfb: vendor descriptor length:23 data:23 5f 01 00 21 00 04 04 07 00 01
[  173.523925] udlfb: DL chip limited to 1500000 pixel modes
[  173.563720] alloc_contig_range: [8ecd0, 8ece0) PFNs busy
[  173.583740] udlfb: allocated 4 65024 byte urbs
[  173.713562] usb 2-1.4.4: new full-speed USB device number 19 using musb-hdrc
[  173.745849] udlfb: 800x480 @ 59 Hz valid mode
[  173.750518] udlfb: Reallocating framebuffer. Addresses will change!
[  173.807769] udlfb: 800x480 @ 59 Hz valid mode
[  173.812438] udlfb: set_par mode 800x480
[  173.904418] udlfb: DisplayLink USB device /dev/fb0 attached. 800x480 resolution. Using 1504K framebuffer memory
[  173.927825] usb 2-1.4.4: New USB device found, idVendor=0483, idProduct=5740
[  173.935363] usb 2-1.4.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  173.943328] usb 2-1.4.4: Product: Virtual COM Port
[  173.948364] usb 2-1.4.4: Manufacturer: MEDIARESEARCH
[  173.953613] usb 2-1.4.4: SerialNumber: VCPB7FE64A63136
[  173.961181] udlfb: sysfs edid copy cd068f00 to ce2e5000, 128 bytes
[  174.020141] udlfb: open /dev/fb0 user=1 fb_info=cd0a2c00 count=1
[  174.182250] cdc_acm 2-1.4.4:1.0: ttyACM2: USB ACM device
[  174.401397] udlfb: open /dev/fb0 user=1 fb_info=cd0a2c00 count=2
<disconnect>
[  174.567047] udlfb: released /dev/fb0 user=1 count=1
[  179.981414] usb 2-1: USB disconnect, device number 16
[  179.986938] usb 2-1.4: USB disconnect, device number 17
[  179.992462] usb 2-1.4.2: USB disconnect, device number 18
[  179.999420] udlfb: USB disconnect starting
[  180.003784] udlfb: Freeing all render urbs
[  180.087982] udlfb: released /dev/fb0 user=1 count=0
[  180.112548] usb 2-1.4.4: USB disconnect, device number 19
[  180.119415] cdc_acm 2-1.4.4:1.0: failed to set dtr/rts
[  180.125183] cdc_acm 2-1.4.4:1.1: urb 15 failed submission with -19
[  181.123931] udlfb: fb_info for /dev/fb0 has been freed
[  181.129882] udlfb: freeing dlfb_data ce247800
[  186.457519] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_wait_bcon (90, <VBusValid), retry #3, port1 0008010c

And that's the end, since now it does not react on hub plug/unplug.

Also all that VBUS_ERROR conditions are strange as hub is powered separately
and power lines from phy are not used.

> Regards,
> 
> Tony
> 
> > $ lsusb -t
> > /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=ehci-omap/3p, 480M
> > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> >         |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=udlfb, 480M
> >         |__ Port 4: Dev 4, If 0, Class=Hub, Driver=hub/4p, 480M
> >             |__ Port 4: Dev 5, If 1, Class=CDC Data, Driver=cdc_acm, 12M
> >             |__ Port 4: Dev 5, If 0, Class=Communications, Driver=cdc_acm, 12M
> > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ohci-omap3/3p, 12M

Best regards,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
