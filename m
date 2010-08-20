From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH 3/7] usb: ehci-omap: omap: Add OMAP4 support
Date: Fri, 20 Aug 2010 08:52:04 +0300
Message-ID: <20100820055204.GF15196@nokia.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <20100820053844.GB15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222B50@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29637 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab0HTFw1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 01:52:27 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324222B50@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, "Munegowda, Keshava" <keshava_mgowda@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, Aug 20, 2010 at 07:47:07AM +0200, ext Gadiyar, Anand wrote:
>The differences between OMAP3 and OMAP4 are:
>- The OMAP4 has a different set of clocks which do not exist on OMAP3.
>- The register bits for configuring port modes is different

is it a different ip core or just a modification of the previous ?

>For the clock handling:
>One approach: On OMAP3, have a set of dummy clocks corresponding to the
>per-port clocks on OMAP4. Then the driver wouldn't need to know which
>SoC it is running on.
>
>Another approach:
>Have a different glue layer driver for OMAP4.
>
>For the register bit differences, we do need to know which SoC we are
>running on to be able to use the correct register bits. For this,

isn't the ehci ip revision different ? Why don't you use that instead of 
cpu_is_omap* 

>One approach:
>At the very minimum, we need a set of clocks to be enabled to be able to
>read the UHH_REVISION register, and we could use that to figure out which
>bits we need to use.

exactly

>The other approach I can think of is to have platform data tell us (I'm
>guessing this is a bad idea).

yeah, that would be bad...

>What do you think?

another approach:

make ohci and ehci play well together have an omap3-specific and one 
omap4-specific MFD-like driver that will instantiate ehci and ohci 
platform_drivers and handle clock + locking to shared address space.

then you define a set of accessor functions for registers with different 
offset that act differently depending on revision of the ip core.

Does that work ?

-- 
balbi

DefectiveByDesign.org
