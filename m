From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/4] arm: omap: usb: ehci and ohci hwmod structures for omap3 and omap4
Date: Wed, 01 Jun 2011 12:56:44 -0700
Message-ID: <87hb89gwar.fsf@ti.com>
References: <1306934847-6098-1-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-2-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1306934847-6098-2-git-send-email-keshava_mgowda@ti.com> (Keshava
	Munegowda's message of "Wed, 1 Jun 2011 18:57:24 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, b-cousson@ti.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

Keshava Munegowda <keshava_mgowda@ti.com> writes:

> Following 2 hwmod strcuture are added:
> UHH hwmod of usbhs with uhh base address and
> EHCI , OHCI irq and base addresses.
> TLL hwmod of usbhs with the TLL base address and irq.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>

I believe the OMAP4 data came from Benoit, so should be in a patch with
his authorship and signoff.  OMAP3 can be a separate patch with your
authorship.

Kevin
