From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: What's in omap git tree for 2.6.33
Date: Sun, 6 Dec 2009 09:07:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C863BE@dbde02.ent.ti.com>
References: <20091204182604.GC24013@atomide.com>,<4B1B21ED.30003@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53621 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758050AbZLFDkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Dec 2009 22:40:15 -0500
In-Reply-To: <4B1B21ED.30003@blueyonder.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "sboyce@blueyonder.co.uk" <sboyce@blueyonder.co.uk>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sid Boyce wrote:
> Still a few fragments missing on beagleboard - Very roughly:
> drivers/usb/Kconfig
> +       default y if ARCH_OMAP34X


This one's in Greg's queue for sure.

<http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usb-ehci-allow-ehci-to-be-built-on-omap3.patch>

And I did point out the other one. Olaf sent a patch too.
We can get that in during the merge window, or right after.

So, wait up for -rc1 to be tagged.

- Anand
