From: "Reddy, Teerth" <teerth@ti.com>
Subject: RE: [PATCH] ZOOM2: PM: Add T2 keypad as wakeup source for Zoom2
Date: Wed, 18 Nov 2009 15:06:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA9E8@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA9A9@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94025429A237@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56292 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbZKRJgi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 04:36:38 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94025429A237@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Will move the wakeup source to arch/arm/mach-omap2/board-zoom-peripherals.c and send the patch.

Regards
Teerth

-----Original Message-----
From: G, Manjunath Kondaiah 
Sent: Wednesday, November 18, 2009 2:26 PM
To: Reddy, Teerth; linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com
Subject: RE: [PATCH] ZOOM2: PM: Add T2 keypad as wakeup source for Zoom2


This patch should be generated for "arch/arm/mach-omap2/board-zoom-peripherals.c", 
since it is common for zoom2 and zoom3 boards. Am I right?

-Manjunath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Reddy, Teerth
> Sent: Wednesday, November 18, 2009 2:23 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com
> Subject: [PATCH] ZOOM2: PM: Add T2 keypad as wakeup source for Zoom2
> 
> From: Lesly A M <x0080970@ti.com>
> 
> Zoom2: Add T2 Keypad as a wakeup source
>     
> Changes for setting the padconf value for sys_nirq line which is
> connected to T2 INTR1. This will fix the T2 keypad wakeup.
>     
> Signed-off-by: Lesly A M <x0080970@ti.com>
> Signed-off-by: Teerth Reddy <teerth@ti.com>
> 
