From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Hang in usb_musb_init() with 2.6.32-rc5?
Date: Wed, 4 Nov 2009 00:31:09 +0200
Message-ID: <20091103223109.GA31165@nokia.com>
References: <4AF0AE74.6000901@billgatliff.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42802 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbZKCWcE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 17:32:04 -0500
Content-Disposition: inline
In-Reply-To: <4AF0AE74.6000901@billgatliff.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bill Gatliff <bgat@billgatliff.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Nov 03, 2009 at 11:28:04PM +0100, ext Bill Gatliff wrote:
> I'm back!  :)  This time, it's because my Beagleboard-like platform
> hangs hard during boot if I call usb_musb_init().
> 
> There are more differences between my platform and Beagleboard in this
> area, namely that I'm using a different USB transceiver and I'm on hs0. 
> But why would the platform hang hard during boot?
> 
> Here are what I think are the relevant parts of my config:
> 
> CONFIG_SND_USB=y                                     
> # CONFIG_SND_USB_AUDIO is not set                    
> # CONFIG_SND_USB_CAIAQ is not set                    
> CONFIG_USB_SUPPORT=y                                 
> CONFIG_USB_ARCH_HAS_HCD=y                            
> CONFIG_USB_ARCH_HAS_OHCI=y                           
> CONFIG_USB_ARCH_HAS_EHCI=y                           
> CONFIG_USB=y                                         
> CONFIG_USB_DEBUG=y                                   
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y                    
> CONFIG_USB_EHCI_HCD=y                                
> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set             
> # CONFIG_USB_EHCI_TT_NEWSCHED is not set             
> # CONFIG_USB_OXU210HP_HCD is not set                 
> # CONFIG_USB_ISP116X_HCD is not set                  
> # CONFIG_USB_ISP1760_HCD is not set                  
> # CONFIG_USB_ISP1362_HCD is not set                  
> CONFIG_USB_OHCI_HCD=y                                
> # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set         
> # CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set         
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y                      
> CONFIG_USB_MUSB_HDRC=y                               
> CONFIG_USB_MUSB_SOC=y                                
> # OMAP 343x high speed USB support                   
> CONFIG_USB_MUSB_HOST=y                               
> # CONFIG_USB_MUSB_PERIPHERAL is not set              
> # CONFIG_USB_MUSB_OTG is not set                     
> CONFIG_USB_MUSB_HDRC_HCD=y                           
> # CONFIG_MUSB_PIO_ONLY is not set                    
> CONFIG_USB_INVENTRA_DMA=y                            
> CONFIG_USB_MUSB_DEBUG=y                              
> CONFIG_NOP_USB_XCEIV=y
> 
> I also created some new mux entries that I need:
> 
>     omap_cfg_reg(R21_3430_USB0HS_PHY_CLK);
>     omap_cfg_reg(R23_3430_USB0HS_PHY_STP);
>     omap_cfg_reg(P23_3430_USB0HS_PHY_DIR);
>     omap_cfg_reg(R22_3430_USB0HS_PHY_NXT);
>     omap_cfg_reg(T24_3430_USB0HS_PHY_D0);
>     omap_cfg_reg(T23_3430_USB0HS_PHY_D1);
>     omap_cfg_reg(U24_3430_USB0HS_PHY_D2);
>     omap_cfg_reg(U23_3430_USB0HS_PHY_D3);
>     omap_cfg_reg(W24_3430_USB0HS_PHY_D4);
>     omap_cfg_reg(V23_3430_USB0HS_PHY_D5);
>     omap_cfg_reg(W23_3430_USB0HS_PHY_D6);
>     omap_cfg_reg(T22_3430_USB0HS_PHY_D7);
> 
> I'm even doing this, which I'm not sure is necessary:
> 
>     ick = clk_get(NULL, "ick");
>     if (ick) clk_enable(ick);
> ...
>    usb_musb_init();
> ...
> 
> 
> Any ideas?  Thanks!!

test with omap-debug branch, enable CONFIG_LL_DEBUG and see what's going
on. I'm guessing you didn't enable any transceiver driver and you're
getting an oops.

-- 
balbi
