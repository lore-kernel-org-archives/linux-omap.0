From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/4] arm: omap: usb: register hwmods of usbhs
Date: Wed, 01 Jun 2011 13:04:38 -0700
Message-ID: <87k4d5fhd5.fsf@ti.com>
References: <1306934847-6098-1-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-2-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-3-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1306934847-6098-3-git-send-email-keshava_mgowda@ti.com> (Keshava
	Munegowda's message of "Wed, 1 Jun 2011 18:57:25 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, b-cousson@ti.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

Keshava Munegowda <keshava_mgowda@ti.com> writes:

> The hwmod structure of uhh and tll are retrived
> and registered with omap device

And the name strings are changed as well as the device identifier
changed from zero to -1.  Please comment and justify.

Kevin
