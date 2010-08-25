From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 broken with 36-rc1
Date: Wed, 25 Aug 2010 11:05:42 +0300
Message-ID: <1282723542.9299.87.camel@tubuntu.research.nokia.com>
References: <1281962906.1888.25.camel@chotu>
	 <4C72192A.9050801@compulab.co.il>  <4C721DFA.9010009@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57848 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab0HYIF7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 04:05:59 -0400
In-Reply-To: <4C721DFA.9010009@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Rapoport <mike@compulab.co.il>
Cc: "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Mon, 2010-08-23 at 09:06 +0200, ext Mike Rapoport wrote:
> Mike Rapoport wrote:

>  From 81e9278ad27bc91be42105321e0e26d0be9e883b Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <mike@compulab.co.il>
> Date: Mon, 23 Aug 2010 09:40:09 +0300
> Subject: [PATCH] OMAP: DSS2: OMAPFB: use phys_to_virt for RAM mappings
> 
> After commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8 (ARM: Prohibit
> ioremap() on kernel managed RAM) it is impossible to ioremap SDRAM for
> the framebuffer. Use phys_to_virt for kernel managed RAM mapping and
> ioremap for other memory types

Hmm. omapfb reserves/allocates the ram using memblock, and obviously
memory from memblock is "kernel managed RAM". What does it mean? The RAM
is already mapped? I guess so, if phys_to_virt() works. (I guess the
whole RAM is mapped automatically). With what caching? How can we get
writecombining for this memory?

Looking at the description of "ARM: Prohibit ioremap() on kernel managed
RAM" it sounds to me that we cannot have writecombining for framebuffer
memory, if it's "kernel managed RAM".

 Tomi


