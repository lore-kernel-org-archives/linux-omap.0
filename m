From: "York, Jeffrey-P56387" <Jeff.York@gdc4s.com>
Subject: RE: FSUSB Register access
Date: Tue, 4 Nov 2008 17:38:28 -0700
Message-ID: <9D31108D62FAE54AA21AEF899D69931E0385AADF@AZ25EXM04.gddsi.com>
References: <20081104160946.19071.44903.stgit@tubuntu> <20081104161038.19071.98198.stgit@tubuntu> <9D31108D62FAE54AA21AEF899D69931E0385A99E@AZ25EXM04.gddsi.com> <20081104222032.GD4010@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from az25ege01.gdc4s.com ([63.226.32.21]:39400 "EHLO
	az25ege01.gdc4s.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbYKEAi3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2008 19:38:29 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20081104222032.GD4010@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

Balbi,

Thanks for your reply.  My comments are below. 

- Jeff

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
Sent: Tuesday, November 04, 2008 3:21 PM
To: York, Jeffrey-P56387
Cc: linux-omap@vger.kernel.org
Subject: Re: FSUSB Register access

On Tue, Nov 04, 2008 at 02:35:50PM -0700, York, Jeffrey-P56387 wrote:
> I am using Montavista Mobilinux 5 on OMAP2430 and I am trying to
access

is it 2430sdp ? Which board are you using ??  
<JEFF SAYS: OMAP2430 SDP>

> the FSUSB register set and the kernel halts upon any attempt to access
> any of the registers in the FSUSB.
> 
> Note, under the Mobilinux distribution, the HSUSB controller is used
by
> default, not the FSUSB controller.  I am trying to access both so that
I
> can have USB port 0 controlled by the HSUSB and port 1 controlled by
the
> FSUSB controller.

in practice this shouldn't be needed actualy. upon attaching a FS device
to ehci port, ehci would handoff the port to ohci. I'm not sure if
that's working fine currently.
<JEFF SAYS:  Not sure what you mean here.  I will be using the HS
controller for port 0 and the FS controller for port 1.  The FS USB port
1 HW only support OHCI.>

> Per the TI spec, the host and device register sets within the FSUSB
> controller can only be accessed if the OTG register set is correctly
> configured.  However, the OTG register set should be accessible as
long
> as there is a 48MHz clock.
> 
> I have tried reading the OTG_REVISION register (0x4805e300) and the
> OTG_SYSCON_1_REG (0x4805e304) within arch/arm/plat-omap/usb.c. Upon
> either read, the kernel halts and I do not see any logs at startup
after
> the 
> "Uncompressing
> Linux.............................................................
> ........................................... done, booting the kernel."
> message.

enable CONFIG_DEBUG_LL and you might see something. I'm guessing you're
gonna get unhandled page fault request (or something similar, can't
remember the correct error message) which most likely means you have to
enable certain clocks before reading the registers.
<JEFF SAYS:  I did this and I do see logging now.  It shows as expected
an external abort on non-linefetch when it tries to read from an FSUSB
register.  As far as I can tell from the TI spec, I should only have to
enable the 48 MHz clock...  And I know it is enabled via a read from the
CM_IDLEST_CKGEN register.>

btw, this list is for the open linux-omap.git tree. If your montavista
distribution is not using the current git tree, you should probably
contact montavista's support.

> If I comment out the register accesses, I do see the startup log and I
> see the following log statements within arch/arm/plat-omap/usb.c
> "Timeout enabling clock usb_l4_ick" 
> "Timeout enabling clock usb_fck" 

what's the kernel version ?? This should be fixed a long time ago.
<JEFF SAYS:  2.6.21>

> In addition I have printed out various register values and they are as
> follows.
> 
> Various register values:
> 
> CM_FCLKEN2_CORE - Address:0x49006204 - value 0x001B07BF,bit 0 is 0x1,
> should be 1
> 
> CM_ICLKEN2_CORE - Address:0x49006214 - value 0x00000FFF,bit 0 is 0x1,
> should be 1
> 
> CM_IDLEST2_CORE - Address:0x49006224 - value 0x00000FFE,bit 0 is 0x0,
> should be 1  --- Possibly this is causing my problem but it is not
clear
> to me what I need to do to have this set to a '1'.
> 
> CM_AUTOIDLE2_CORE - Address:0x49006234 - value 0x00000000,bit 0 is
0x0,
> should be 0
> 
> CM_CLKSEL1_CORE - Address:0x49006240 - value 0x02102946,bits 27-25 is
> 0x1, should be 1 for L3_CLK/1 (boot mode only), 2 for L3_CLK/2, or 4
for
> L3_CLK/4
> 
> PM_WKEN2_CORE - Address:0x490062A4 - value 0x00000000,bit 0 is 0x0,
> should be 0 for disabled, 1 for enabled  -- Per TI, this does not need
> to be enabled...
> 
> PM_WKST2_CORE - Address:0x490062B4 - value 0x00000000,bit 0 is 0x0,
> should be 0 for not occurred, 1 for occurred
> 
> CM_IDLEST_CKGEN - Address:0x49006520 - value 0x00000336,bit 4 is 0x1,
> should be 0x1 for active 48M_CLK
> 
> 
> Any ideas as to what the register settings need to be to enable access
> to the FSUSB OTG registers?

I'm guessing you only need to enable some clock(s). But also, please,
reply with low level debug output and kernel version. Also, try
out the current omap git tree. There's a defconfig for 2430sdp
(omap_2430sdp_defconfig) that you might want to try.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
