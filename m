From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV4] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Tue, 18 May 2010 18:32:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005181816380.27473@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03229868BA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33905 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab0ESAcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 20:32:50 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03229868BA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Hello Teerth,

On Fri, 23 Apr 2010, Reddy, Teerth wrote:

> From: Teerth Reddy <teerth@ti.com>
> 
> This patch has the workaround for errata 1.176.
> In some cases, user is not able to access DDR memory after
> warm-reset.This situation occurs while the warm-reset
> happens during a read access to DDR memory. In that
> particular conditions, DDR memory does not respond to a
> corrupted read command due to the warm reset occurence but
> SDRC is waiting for read completion.SDRC is not sensitive to
> the warm reset, but the interconect is reset on the fly,
> thus causing a misalignment between SDRC logic, interconect
> logic and DDR memory state.
> 
> Root cause description: A corrupted read transaction is
> issued to a closed row: (address0, bank0) instead of the
> expected read access, violating protocol.
> 
> Failure signature: Once the failure occurs and system has
> restarted, memory content is not accessible.SDRC registers
> can be accessed successfully, until 1st access to memory
> location is performed. After 1st access to memory is done,
> SDRC is stuck.
> 
> WORKAROUND
> Steps to perform before a SW reset is trigged, if user needs
> to generate a SW reset and keep DDR memory content:
> 1. Enable self-refresh on idle request
> 2. Put SDRC in idle
> 3. Wait until SDRC goes to idle
> 4. Generate SW reset
> 
> Steps to perform after warm reset occurs:
> If HW warm reset is the source, apply below steps before
> any accesses to SDRAM:
> 1. Reset SMS and SDRC
> 2. Re-initialize SMS, SDRC and memory
> 
> This would need the u-boot/x-loader workaround changes
> as well for the reboot to work correctly.
> 
> Thanks to Paul Walmsley <paul@pwsan.com> for suggesting
> usefull changes.
> 
> Signed-off-by: Teerth Reddy <teerth@ti.com>

This patch doesn't work on the BeagleBoard Rev C2 here.  After running 
'init 6' to reboot the system, the kernel hangs after:

Rebooting... Restarting system.

Could you please doublecheck this patch?

This patch also adds a sparse warning - please fix 
that too,


- Paul
