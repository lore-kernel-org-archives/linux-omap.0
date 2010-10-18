From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] Add OMAP hardware spinlock misc driver
Date: Mon, 18 Oct 2010 14:46:55 +0200
Message-ID: <1287406015.29097.1579.camel@twins>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from canuck.infradead.org ([134.117.69.58]:55149 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab0JRMrT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 08:47:19 -0400
In-Reply-To: <1287387875-14168-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>

On Mon, 2010-10-18 at 09:44 +0200, Ohad Ben-Cohen wrote:
> OMAP4 introduces a Spinlock hardware module, which provides hardware
> assistance for synchronization and mutual exclusion between heterogeneous
> processors and those not operating under a single, shared operating system
> (e.g. OMAP4 has dual Cortex-A9, dual Cortex-M3 and a C64x+ DSP). 

I just have to ask... was it really easier to build silicon than to
agree on a spinlock ABI?
