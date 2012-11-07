From: Tony Lindgren <tony@atomide.com>
Subject: Lapdock with Panda ES using USB adapter with super caps on VBUS
 for power
Date: Wed, 7 Nov 2012 13:17:21 -0800
Message-ID: <20121107211720.GJ6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34278 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751727Ab2KGVRX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 16:17:23 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Hi all,                                                                                                                                                                  
                                                                                                                                                                         
FYI, here are few photos of what I ended up doing over the weekend                                                                                                       
with my lapdock to be able to use MUSB both for power and HID. This                                                                                                      
allows not having to waste the USB hub ports for the power:                                                                                                              
                                                                                                                                                                         
http://muru.com/linux/panda-lapdock/                                                                                                                                     
                                                                                                                                                                         
Those USB connector boards and super caps are from sparkfun. The caps                                                                                                    
are 2.5V each, so need to be in series. They allow running panda es                                                                                                      
for a few seconds which is enough to compensate for the 1 second glitch                                                                                                  
in the lapdock VBUS when closing the lid :)                                                                                                                              
                                                                                                                                                                         
The holes on the sparkfun USB breakout boards align nicely for easy                                                                                                      
soldering and the whole thing is hotglued together. Then the Panda ES                                                                                                    
is just attached to the lid with some velcro.. Thanks Paul on the                                                                                                        
suggestion for using super caps for the VBUS glitch!                                                                                                                     
                                                                                                                                                                         
Still need to find a 1 foot mini-A to mini-B USB OTG cable if anybody                                                                                                    
has seen those.                                                                                                                                                          
                                                                                                                                                                         
One minor issue still remains.. MUSB does not switch to host mode                                                                                                        
automatically without replugging the USB cable, so after booting                                                                                                         
I need to plug in regular power cable, replug USB then, unplug                                                                                                           
the regular power cable to get the HID devices going. Sounds like                                                                                                        
a bug somewhere in the transceiver driver.                                                                                                                               
                                                                                                                                                                         
Cheers,                                                                                                                                                                  
                                                                                                                                                                         
Tony
