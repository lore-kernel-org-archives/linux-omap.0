From: Kevin Hilman <khilman@mvista.com>
Subject: Re: MUSB: unreliable OTG detection in host mode
Date: Fri, 31 Aug 2007 21:55:28 -0700
Message-ID: <46D8F0C0.7060608@mvista.com>
References: <46D8ACD1.8030101@mvista.com>
	<20070901002025.B8E79235120@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<46D8B24F.3010409@mvista.com>
	<20070901021439.D617B235164@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090100000704080809010209"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070901021439.D617B235164@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090100000704080809010209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David Brownell wrote:
>>> Unreliable in what way(s)?
>> Meaning it sometimes detects connected devices and sometimes not.
>> Sometimes a reboot and another try helps.  But with recent git it seems
>> to never detect devices.
> 
> What do you mean "detect" though?  Does it not see anything
> hooked up to the root hub?  Or once it sees something, is there
> some difficulty talking to it?  The specifics will say just where
> the problem lies...

Well it depends...

First, for comparison sake,  attached is the output from when the driver
is built in host-mode (host.txt)  The rest of the test are done with no
changes in cables. devices connected etc...

When I switch to building the driver in OTG mode, either the devices are
detected the same as in host.txt (after the additional 'modprobe
g_zero'), or not even the root hub is detected (see otg1.txt).  And
sometimes only the root hub is detected (otg2.txt)

The working OTG case is much more rare than the non-working ones, but I
haven't done enough tests to have a good feel for how often etc.

Kevin

--------------090100000704080809010209
Content-Type: text/plain;
 name="host.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="host.txt"

# uname -a
Linux omap2430sdp-v4 2.6.23-rc4-omap1-arm-omap2430-default-g8a52303e-dirty #13 PREEMPT Fri Aug 31 21:33:42 PDT 2007 armv6l GNU/Linux

# modprobe musb_hdrc
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
musb_hdrc: version 6.0, musb-dma, host, debug=0
musb_hdrc: ConfigData=0x55 (UTMI-16, dyn FIFOs, bulk split (X), HB-ISO Rx (X))
musb_hdrc: MHDRC RTL version 1.400 
musb_hdrc: setup fifo_mode 2
musb_hdrc: 7/15 max ep, 2624/16384 memory
musb_hdrc: hw_ep 0shared, max 64
musb_hdrc: hw_ep 1tx, max 512
musb_hdrc: hw_ep 1rx, max 512
musb_hdrc: hw_ep 2tx, max 512
musb_hdrc: hw_ep 2rx, max 512
musb_hdrc: hw_ep 3shared, max 256
musb_hdrc: hw_ep 4shared, max 256
musb_hdrc: USB Host mode controller at c8854000 using DMA, IRQ 92
musb_hdrc musb_hdrc.0: MUSB HDRC host driver
musb_hdrc musb_hdrc.0: new USB bus registered, assigned bus number 1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb 1-1: new high speed USB device using musb_hdrc and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 7 ports detected
usb 1-1.7: new high speed USB device using musb_hdrc and address 3
usb 1-1.7: configuration #1 chosen from 1 choice
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
scsi 0:0:0:0: Direct-Access     Flash    Drive AL_USB20   1.00 PQ: 0 ANSI: 2
usb-storage: device scan complete
sd 0:0:0:0: [sda] 1018624 512-byte hardware sectors (522 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 03 00 00 00
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] 1018624 512-byte hardware sectors (522 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 03 00 00 00
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk


--------------090100000704080809010209
Content-Type: text/plain;
 name="otg1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="otg1.txt"

# uname -a
Linux omap2430sdp-v4 2.6.23-rc4-omap1-arm-omap2430-default-g8a52303e-dirty #12 PREEMPT Fri Aug 31 17:11:46 PDT 2007 armv6l GNU/Linux

# modprobe musb_hdrc
musb_hdrc: version 6.0, musb-dma, peripheral, debug=0
musb_hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine (X), bulk split (X), HB-ISO Rx (X), HB-ISO Tx (X), SoftConn)
musb_hdrc: MHDRC RTL version 1.400 
musb_hdrc: setup fifo_mode 2
musb_hdrc: 7/15 max ep, 2624/16384 memory
musb_hdrc: hw_ep 0shared, max 64
musb_hdrc: hw_ep 1tx, max 512
musb_hdrc: hw_ep 1rx, max 512
musb_hdrc: hw_ep 2tx, max 512
musb_hdrc: hw_ep 2rx, max 512
musb_hdrc: hw_ep 3shared, max 256
musb_hdrc: hw_ep 4shared, max 256
musb_hdrc: USB Peripheral mode controller at c8854000 using DMA, IRQ 92

# modprobe g_zero
zero gadget: Gadget Zero, version: St Patrick's Day 2004
zero gadget: using musb_hdrc, OUT ep1out IN ep1in

#

--------------090100000704080809010209
Content-Type: text/plain;
 name="otg2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="otg2.txt"

# modprobe musb_hdrc                                       
usbcore: registered new interface driver usbfs                                  
usbcore: registered new interface driver hub                                    
usbcore: registered new device driver usb                                       
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0                
musb_hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine (X), bulk split (X))
musb_hdrc: MHDRC RTL version 1.400                                              
musb_hdrc: setup fifo_mode 2                                                    
musb_hdrc: 7/15 max ep, 2624/16384 memory                                       
musb_hdrc: hw_ep 0shared, max 64                                                
musb_hdrc: hw_ep 1tx, max 512                                                   
musb_hdrc: hw_ep 1rx, max 512                                                   
musb_hdrc: hw_ep 2tx, max 512                                                   
musb_hdrc: hw_ep 2rx, max 512                                                   
musb_hdrc: hw_ep 3shared, max 256                                               
musb_hdrc: hw_ep 4shared, max 256                                               
musb_hdrc: USB OTG mode controller at c8854000 using DMA, IRQ 92                

# modprobe g_zero                                          
zero gadget: Gadget Zero, version: St Patrick's Day 2004                        
zero gadget: using musb_hdrc, OUT ep1out IN ep1in                               
musb_hdrc musb_hdrc.0: MUSB HDRC host driver                                    
musb_hdrc musb_hdrc.0: new USB bus registered, assigned bus number 1            
usb usb1: configuration #1 chosen from 1 choice                                 
hub 1-0:1.0: USB hub found                                                      
hub 1-0:1.0: 1 port detected                                                    
# 

--------------090100000704080809010209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090100000704080809010209--
