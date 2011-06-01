From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/4] arm: omap: usb: device name change for the clk names of usbhs
Date: Wed, 01 Jun 2011 13:05:07 -0700
Message-ID: <87hb89fhcc.fsf@ti.com>
References: <1306934847-6098-1-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-2-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-3-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-4-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1306934847-6098-4-git-send-email-keshava_mgowda@ti.com> (Keshava
	Munegowda's message of "Wed, 1 Jun 2011 18:57:26 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, Keshava Munegowda <Keshava_mgowda@ti.com>
List-Id: linux-omap@vger.kernel.org

Keshava Munegowda <keshava_mgowda@ti.com> writes:

> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>
> device name usbhs clocks are changed from
> usbhs-omap.0 to usbhs_omap; this is because
> in the hwmod registration the device name is set
> as usbhs_omap

..and because the identifier is changed to -1 in the previous patch
without being documented.

Kevin
