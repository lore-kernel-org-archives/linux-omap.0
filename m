From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC/PATCH 02/13] serial: omap: always return IRQ_HANDLED
Date: Tue, 21 Aug 2012 12:50:05 +0100
Message-ID: <20120821125005.235926e0@bob.linux.org.uk>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
	<1345540555-24359-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26790 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185Ab2HULc6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 07:32:58 -0400
In-Reply-To: <1345540555-24359-3-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>

On Tue, 21 Aug 2012 12:15:44 +0300
Felipe Balbi <balbi@ti.com> wrote:

> Even if we enter our IRQ handler just to notice
> that the our device didn't generate the IRQ,
> that still means "handling" and IRQ, so let's
> return IRQ_HANDLED.

That looks wrong - you'll defeat the stuck IRQ protection. If we didn't
cause the IRQ then we are IRQ_NONE ?

