From: "Que, Simon" <sque@ti.com>
Subject: RE: [RFC] omap: hwspinlock: Added hwspinlock driver
Date: Fri, 25 Jun 2010 15:31:22 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E14728E5B3@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167E8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49760 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab0FYUbY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 16:31:24 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167E8@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Santosh,

> This reservation KCONFIG isn't necessary. HWSPINLOCK IP is not really for
> very generic use
> but specific usages where you need to protect the data between independent
> softwares
> running on different masters.
> For other Linux only side software even with dual core, kernel spinlock
> library
> is sufficient.

We will consider this.

> Are you building this for all OMAP's ?? 

> Move this base address to plat/omap44xx.h and use it from there

> " OMAP2_L4_IO_ADDRESS" this should not be used anymore. Rather, use
> "ioremap and readl/writel"

Good points, we'll implement these.

> Why do you have two files ? This IP is not part of OMAP1 and all the code
> can
> go in mach-omap and can be exported from there.

Are you suggesting we use a library approach instead of a driver approach?  We want to make this expandable in the future.  If something in the underlying hardware changes with OMAP5, OMAP6, etc, we only need to update the device initialization file.  The driver can remain unchanged.


Thank you,
Simon
