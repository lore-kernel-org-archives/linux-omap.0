From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/2] OMAP2+: PANDA: Provide unique-ish MAC addresses for Ethernet and WLAN interfaces
Date: Thu, 28 Jun 2012 14:18:15 +0000
Message-ID: <201206281418.16854.arnd@arndb.de>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57173 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab2F1OSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 10:18:34 -0400
In-Reply-To: <20110324211451.14936.39750.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, x0132446@ti.com, s-jan@ti.com, tony@atomide.com, Steven Rostedt <rostedt@goodmis.org>

On Thursday 24 March 2011, Andy Green wrote:
> The following series solves a problem Panda suffers from where
> because there is no local MAC address storage on the board, a
> new random MAC address is applied to the onboard Ethernet
> interface each time, and the wl12xx module's wlan0 interface is
> always found with an unworkable 00:00:00:00:00:00 MAC.
> 
> The series adds an omap id-related API to generate a
> 6-byte Ethernet MAC address from "hashing" a little the CPU ID
> registers.  It is understood from TI that these contain data
> that at least in a subset of the 128 bits of the ID are unique per-CPU.
> 
> It then introduces code in the Panda board definition file to
> watch network interface creation and if the device's path is on
> a list, set its MAC address to the CPU ID-generated one, plus
> two bits which differ according to which interface in the list
> is being changed.  (This scheme was suggested by Alan Cox).
> 
> The device paths for the onboard Ethernet smsc95xx, and the
> onboard WLAN wl12xx are listed, so both of these will get
> assigned a consistent, unique-ish locally administered MAC
> address with these patches.
> 
> It's beleived the current scheme for MAC generation from ID
> data captures most of the entropy, but if there is a better scheme
> more closely mapped to what the unique factory areas are advice
> is welcome.
> 
> The patches are against linux-omap which already has a prerequisite
> patch that fixes a problem with device ID capture on OMAP4.

It's been a while since we discussed these patches, but Steven Rostedt
just tripped over the same problem and the patches work for
him, so he says "Tested-by: Steven Rostedt <rostedt@goodmis.org>".

Can we get the patches into linux-3.6 please?

	Arnd
