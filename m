From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Fwd: [PATCH 0/3] Allow late mdesc detection, v3
Date: Sat, 31 Jul 2010 10:25:22 +0100
Message-ID: <20100731092522.GD23886@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44749 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0GaJZd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jul 2010 05:25:33 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Forwarding for OMAP people - as there's outstanding questions about this
change for their platforms.

----- Forwarded message from Jeremy Kerr <jeremy.kerr@canonical.com> -----

Date: Fri, 30 Jul 2010 17:22:11 +0800
From: Jeremy Kerr <jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Allow late mdesc detection, v3
Delivery-date: Sat, 31 Jul 2010 01:25:58 +0100

Hi all,

Currently, we probe for a mdesc early in boot. At this early stage, the
only thing we use the mdesc for is to determine the debug page mapping.

However, the debug addresses (phys and virt) need to be coded into the
addruart macro anyway; the dynamic probing is only going to tell us what
we already know.

These changes allow us to use the addruart macros to find the debug
mapping addresses, rather than pulling them out of the mdesc. This means
that the addresses are only kept in the one place, and that we don't
need the mdesc nearly as early.

The first change updates all of the addruart macros to return both
physical and virtual addresses. I've used 'rp' and 'rv' as the macro
arguments to indicate which address goes where

The second change updates the debug setup routine to use the addruart
macro to establish the debug mapping, now that we can invoke the macro
to find the phyical and virtual addresses.

This allows us to delay the requirement to have a mdesc available until
much later. For example, we can parse one from the device tree once
we've reached C code.

May break OMAP1/2, as the addruart macros are more complex on these
platforms. I'd appreciate input from OMAP folks who may well tell me
that this isn't possible.

Cheers,


Jeremy

v3:
 * only establish page mapping if !DEBUG_ICEDCC

v2:
 * return both phys and virt addresses from addruart
 * mask unneeded bits from uart physical address in mapping setup
 * remove io_pg_offst and phys_io, in a separate patch

---
Jeremy Kerr (3):
      arm/debug: consolidate addruart macros for CONFIG_DEBUG_ICEDCC
      arm: return both physical and virtual addresses from addruart
      arm: use addruart macro to establish debug mappings
