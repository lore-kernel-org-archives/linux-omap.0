From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCHv12 0/9] OMAP3+: PRCM chain handler
Date: Mon, 9 Jan 2012 05:31:02 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D1214304DF4E@DBDE01.ent.ti.com>
References: <20111215213358.26632.44165.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44201 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab2AIFbN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 00:31:13 -0500
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On Fri, Dec 16, 2011 at 03:06:09, Paul Walmsley wrote:
> Hi,
> 
> This is a repost of Tero's PRCM chain handler patch set with a few changes:
> 
> - A new mux patch has been added to place hwmod mux entries with
>   OMAP_DEVICE_PAD_WAKEUP set into the dynamic list
> 
> - Several OCP barriers have been added to PRM writes to try to protect
>   against races between PRM register writes and the MPU
> 
> - Kerneldoc documentation has been added
> 
> - The pending IRQ test functions have been split into per-SoC versions
> 
> - Some patches have been rearranged and merged to avoid churn
> 
> - The PRM IRQ handler is now installed on OMAP4
> 

I found a few (minor) issues with this patch series.

1. IO and wakeup events are not supported on AM33XX. Since cpu_is_34xx()
holds true for AM33XX I ended up adding a !cpu_is_am33xx() check in 
omap3xxx_prcm_init() to bypass the chain handler registration.

Without such a check we were seeing a crash in USB since USB_CLKCTRL on 
AM33XX just happens to be at the IRQENABLE_MPU_OFFSET of OMAP3.
Hope such cpu_is_*() checks are acceptable.

2. With the above check in place, there' a warning during boot

"mux: Failed to setup hwmod io irq -22"

This is coming due to request_irq() for the IO event without a PRCM chain
handler being registered. Maybe there should be check for *prcm_irq_setup
before request_irq()?

3. [PATCH 9/9] adds an entry for "wkup" event on OMAP4. Carried over from OMAP3?

Regards,
Vaibhav

