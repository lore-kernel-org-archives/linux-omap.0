From: Paul Walmsley <paul@pwsan.com>
Subject: RE: Low level debugging using CONFIG_EARLY_PRINTK=y, omap-debug
 branch removed
Date: Thu, 17 Dec 2009 16:04:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912171603040.12561@utopia.booyaka.com>
References: <20091216005337.GR4575@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BFB58018@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46222 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbZLQXES (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 18:04:18 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BFB58018@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 16 Dec 2009, Shilimkar, Santosh wrote:

> I tried this on couple of boards and at least it doesn't work with the 
> options and mentioned bootargs. The low level debug prints are still not 
> coming on console.
> 
> I haven't debugged it though.

It works on Beagle, at least.  That's the only one that I've tested so 
far.

If you're using the kernel commandline from u-boot, don't forget to update 
it.


- Paul
