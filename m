From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ARM][OMAP] TWL4030 IRQ
Date: Mon, 29 Jun 2009 10:58:00 -0700
Message-ID: <87k52u9b2v.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com>
	<20090624075756.GA13052@n2100.arm.linux.org.uk>
	<20090629093004.GA2111@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02B53AC23F@dbde02.ent.ti.com>
	<87prcn7wtu.fsf@deeprootsystems.com>
	<20090629175250.GE9042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:37040 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbZF2R57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 13:57:59 -0400
Received: by pzk26 with SMTP id 26so368557pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 10:58:02 -0700 (PDT)
In-Reply-To: <20090629175250.GE9042@n2100.arm.linux.org.uk> (Russell King's message of "Mon\, 29 Jun 2009 18\:52\:50 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Jun 29, 2009 at 10:51:09AM -0700, Kevin Hilman wrote:
>> And if you look at the OMAP's MPU irq_chip implementation, these are 
>> not populated either.  We rely on the default lazy enable via unmask
>> and the lazy disable.
>
> There's no lazy enable - it's immediate.  There's only lazy disable.

Correct, that was a mis-edit.  It should've read: "We rely on the
default enable via unmask and the lazy disable."

Kevin


