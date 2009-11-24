From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Enabling HSUSB1 port on OMAP3430 labrador
Date: Tue, 24 Nov 2009 22:05:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309DAC237@dbde02.ent.ti.com>
References: <4B0BEED4.1060005@holografika.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53565 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758123AbZKXQfq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 11:35:46 -0500
In-Reply-To: <4B0BEED4.1060005@holografika.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kovacs Peter Tamas <p.kovacs@holografika.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kovacs Peter Tamas wrote:
> Sent: Tuesday, November 24, 2009 8:04 PM
> To: linux-omap@vger.kernel.org
> Subject: Enabling HSUSB1 port on OMAP3430 labrador
> 
> Dear All,
> 
> We are trying to make the HSUSB1 port on the OMAP3430 work as an USB host.
> To do that, an ISP1507A ULPI HighSpeed USB transceiver is connected to 
> the HSUSB1pins (HSUSB1_STP, CLK, D-0..D7, DIR, NXT).
> 
> I have all these USB related kernel config options enabled:
> USB_EHCI_HCD
> USB_OHCI_HCD
> USB_MUSB_HDRC
> TWL4030_USB
> 
> My guess was that either EHCI or the Inventra should be the one enabling 
> that USB port on the OMAP, but no luck.
> The external USB port on the MDK works fine with this configuration.
> 
> The pin multiplexing configuration in the board file omap3430-labrador.c 
> in u-boot also seems to be correct (although the config of USB1_STP 
> seems to be strange, but changing that didn't work either).
> 

HSUSB1 is not supposed to be used with the labrador (do you have a link
to the board schematics with the mods?). HSUSB1 is the EHCI port.

Not sure why the pad conf is done in u-boot for this board, but maybe
it was a copy-paste thing. That being said, if you've got the part
installed correctly, it ought to work.

> My assumption is that the ISP1507A does not need support from the 
> kernel, as it acts as an ULPI transceiver only, but please correct me on 
> this point if wrong.

No support is needed for this part - it's supposed to work transparently.
However there is an errata for this part for use with the input clocking
mode - you need to delay the STP signal a little (to avoid CRC errors).
See the errata doc from NXP.

> 
> What happens is that after connecting an USB mouse is that the LED is on 
> for a sec, but nothing is written in the kernel log.

If it's EHCI, you won't be able to use a USB mouse (it's a low-speed device).
EHCI on OMAP3 supports high-speed only. You'll need to plug in a high-speed
device, or a hub with a built-in transaction translator.

> We can see that the transceiver is generating a clock signal, but for 
> some reason, the STP is constantly high.
> 
> I've also tried setting the port to PHY or TLL, but didn't help. I guess 
> PHY is the correct setting in this situation, right? 

PHY mode is the correct setting for this, yes.

> 
> Note, the ISP1507A is connected to the following pins of the BGA:
> HSUSB1_STP (AF10)
> HSUSB1_CLK (AE10)
> HSUSB1_DIR (AF9)
> HSUSB1_NXP (AG9)
> HSUSB1_D0 (AF11)
> HSUSB1_D1 (AG12)
> HSUSB1_D2 (AH12)
> HSUSB1_D3 (AH14)
> HSUSB1_D4 (AE11)
> HSUSB1_D5 (AH9)
> HSUSB1_D6 (AF13)
> HSUSB1_D7 (AE13)

These are the pads for EHCI. So I suppose that's what you're trying to use.

Note that EHCI on the OMAP3 supports only the input clocking mode. This
might mean you need to check if you've configured the PHY correctly for
this mode. (No XTAL required, OMAP provides the clock to the PHY).
NXP seems to have removed all mention of this mode from their
data sheets, so you might want to check with them.

Also, do you see a 60MHz clock when you probe the HSUSB1_CLK line?


On the 3430 SDP, we use the ISP1504C PHY (same family - very similar
behavior as the 1507). To make it work, we need to hold the PHY in
reset until after the EHCI controller was configured. This could be
done by using the PHY's reset line (early boards had this) or by
using the CHIP_SEL_n line (newer boards).



> 
> Any suggestion on making this work is greatly appreciated.
> 
> Thanks for your help,
> Peter

Regards,
Anand