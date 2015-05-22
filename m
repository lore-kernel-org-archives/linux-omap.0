From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: AM3517 usb host issue
Date: Fri, 22 May 2015 11:04:33 +0300
Message-ID: <555EE311.3030507@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

I am trying to get the full-speed USB host working on an custom AM3517
device with the 3.18.12 kernel. The hardware works (a 2.6.37 kernel has
been used for testing).

Does anyone have any experience of 3.18 (or similarly recent kernel on
an AM3517 system) or have any pointers as where to start debugging? The
ti-linux-3.14.y does not have any patches that aren't applied to the
usb on 3.18.13.

The cpu port 1 is connected by a TI TUSB1106 usb transceiver that is
directly connected to a full-speed hub (TI USB2046) hub so the OHCI
driver is the only one in use.

Note, the ohci-omap3 is loaded as a module as this is how their user
application expects to be able to shut down usb when it does not need
it.

The device tree configuration for the usb host:

> &usbhshost {
> 	status = "okay";	/* just in case it is started disabled */
> 
> 	port1-mode = "ohci-phy-6pin-dpdm";
> };
> 
> &usbhsohci {
> 	status = "okay";
> };
> 
> &usbhsehci {
> 	status = "disabled";	/* no ehci on board */
> };


The usb from the logs is as follows. Some extra debugging has been
added to verify the device-tree settings:

> [    0.000000] AM3517 ES1.1 (l2cache sgx neon)                                 
> 
> [    0.869706] usbcore: registered new interface driver usbfs                   
> [    0.874270] usbcore: registered new interface driver hub                     
> [    0.878592] usbcore: registered new device driver usb                        
> [    1.223199] usbhs_tll 48062000.usbhstll: starting TI HSUSB TLL Controller    
> [    1.273000] usbhs_omap 48064000.usbhshost: ports 0                           
> [    1.278291] usbhs_omap 48064000.usbhshost: port 0: ohci-phy-6pin-dpdm        
> [    1.284476] usbhs_omap 48064000.usbhshost: port0-mode: ohci-phy-6pin-dpdm ->5
> [    1.288689] usbhs_tll 48062000.usbhstll: omap_tll_init()                     
> [    1.293628] usbhs_omap 48064000.usbhshost: usbhs_runtime_resume              
> [    1.298434] usbhs_omap 48064000.usbhshost: sysconfig 0x00001009              
> [    1.302730] usbhs_tll 48062000.usbhstll: omap_tll_enable()                   
> [    1.307668] usbhs_omap 48064000.usbhshost: usbhs_runtime_suspend             
> [    1.310142] stopping usb controller                                          
> [    1.419910] usbhs_tll 48062000.usbhstll: omap_tll_disable()                  
> [    1.423547] usbhs_omap 48064000.usbhshost: 3 ports                           
> [    1.429065] usbhs_omap 48064000.usbhshost: starting TI HSUSB Controller      
> [    1.433831] usbhs_omap 48064000.usbhshost: usbhs_runtime_resume              
> [    1.438625] usbhs_omap 48064000.usbhshost: sysconfig 0x00001009              
> [    1.442921] usbhs_tll 48062000.usbhstll: omap_tll_enable()                   
> [    1.448548] usbhs_omap 48064000.usbhshost: omap_usbhs_rev1_hostconfig =>     
> [    1.455034] usbhs_omap 48064000.usbhshost: UHH setup done, uhh_hostconfig=80d
> [    1.459918] usbhs_omap 48064000.usbhshost: usbhs_runtime_suspend             
> [    1.462337] stopping usb controller                                          
> [    1.569905] usbhs_tll 48062000.usbhstll: omap_tll_disable()                  
> [    1.575408] usbhs_omap 48064000.usbhshost: populating usb sub nodes....      
> 
> [   77.609168] usbhs_omap 48064000.usbhshost: usbhs_runtime_resume              
> [   77.613927] usbhs_omap 48064000.usbhshost: sysconfig 0x00001009              
> [   77.618374] usbhs_tll 48062000.usbhstll: omap_tll_enable()                   
> [   77.802694] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001    
> [   77.816003] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber1
> [   77.827391] usb usb1: Product: OHCI Host Controller                          
> [   77.838674] usb usb1: Manufacturer: Linux 3.18.13-00203-ga3c52be-dirty ohci_d
> [   77.849913] usb usb1: SerialNumber: 48064400.ohci                            

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
