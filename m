From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Mon, 21 Feb 2011 23:28:12 +0000
Message-ID: <20110221232812.GB15494@n2100.arm.linux.org.uk>
References: <20110217173711.GF14574@legolas.emea.dhcp.ti.com> <4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com> <4D5E7DFF.7020609@ti.com> <20110218154135.GF11151@legolas.emea.dhcp.ti.com> <4D5EA36A.4000903@ti.com> <20110221182213.GD15225@atomide.com> <4D62DAF0.9050301@ti.com> <20110221220815.GG15225@atomide.com> <4D62ECCC.3040208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44676 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab1BUX2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 18:28:33 -0500
Content-Disposition: inline
In-Reply-To: <4D62ECCC.3040208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Kalliguddi, Hema" <hemahk@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Balbi, Felipe" <balbi@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 21, 2011 at 11:53:00PM +0100, Cousson, Benoit wrote:
> I still didn't fully understand the rational behind that early_init for  
> timer BTW.

To ensure that sched_clock() is setup and running before its first use.
