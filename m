From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3
Date: Tue, 31 Mar 2009 19:48:02 +0100
Message-ID: <20090331184802.GA27745@n2100.arm.linux.org.uk>
References: <20090316182257.GK19229@atomide.com> <5A47E75E594F054BAF48C5E4FC4B92AB02FB085D68@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51268 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107AbZCaSsQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 14:48:16 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB085D68@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 31, 2009 at 05:12:18PM +0530, Gadiyar, Anand wrote:
> I could not run the 3430 SDP defconfig from mainline. The image hangs at
> "Starting kernel ...". Enabling CONFIG_DEBUG_LL does not help.

Did you add the necessary patch to kernel/printk.c ?
