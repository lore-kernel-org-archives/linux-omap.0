From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [ARM][OMAP] TWL4030 IRQ
Date: Mon, 29 Jun 2009 18:52:50 +0100
Message-ID: <20090629175250.GE9042@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com> <20090624075756.GA13052@n2100.arm.linux.org.uk> <20090629093004.GA2111@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02B53AC23F@dbde02.ent.ti.com> <87prcn7wtu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60575 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbZF2Rw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 13:52:59 -0400
Content-Disposition: inline
In-Reply-To: <87prcn7wtu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jun 29, 2009 at 10:51:09AM -0700, Kevin Hilman wrote:
> And if you look at the OMAP's MPU irq_chip implementation, these are 
> not populated either.  We rely on the default lazy enable via unmask
> and the lazy disable.

There's no lazy enable - it's immediate.  There's only lazy disable.
