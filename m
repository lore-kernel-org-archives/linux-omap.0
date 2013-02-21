From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Wed, 20 Feb 2013 21:26:38 -0700
Message-ID: <5125A1FE.5000604@wwwdotorg.org>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:56679 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab3BUE0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 23:26:39 -0500
In-Reply-To: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel A Fernandes <agnel.joel@gmail.com>
Cc: u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, "Fernandes, Joel A" <joelagnel@ti.com>, "Rini, Tom" <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>

On 02/20/2013 06:37 PM, Joel A Fernandes wrote:
> Hello,
> I've been spinning some work-in-progress patches for FIT build support
> in the kernel.
> With the move to multiplatform support on OMAP, I feel it is a good
> time to add  FIT support, also looking at the proliferating number of
> dtbs, as it is a nice way

To my mind, FIT is pointless. And forcing the kernel build process to
create bootloader-specific files doesn't seem like a good idea. Doing so
would require pulling in even more outside tools into the kernel build flow.

All you need is to copy the zImage and any relevant .dtb files into
/boot, and have U-Boot load the relevant .dtb file by constructing the
filename as roughly ${soc}-${board}.dtb, then use the bootz command to
boot it. You can have a completely generic boot.scr (or built-in script).

Note: Not all (many?) U-Boot support FIT anyway, so you'd need to flash
a new U-Boot to support FIT, so you may as well just flash a new U-Boot
that implements the ${soc} and ${board} variables instead. IIRC, there
may also be a ${boardname} or similar that's like ${board}, but
represents the runtime-detected board for when one U-Boot build actually
supports multiple different boards.
