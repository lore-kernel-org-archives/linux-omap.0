From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 0/4] Patches to make multi-soc handling in entry-armv.S
 easier
Date: Sat, 04 Dec 2010 00:49:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012040040590.10437@xanadu.home>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:40253 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab0LDFto (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 00:49:44 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LCW00KRY2UIA3B0@vl-mo-mrz24.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Sat, 04 Dec 2010 00:49:30 -0500 (EST)
In-reply-to: <20101204001435.28853.29616.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, 3 Dec 2010, Tony Lindgren wrote:

> Hi all,
> 
> I've got some patches almost ready to go to merge the omap1
> configs into a single omap1_defconfig. While working on getting
> that done, I had to come up with a better solution for entry-armv.S
> macros to detect the soc we're running on.
> 
> I suggest we add asm_irq_base and asm_irq_flags as in the first
> patch in this series does. This way we can do the soc based detection
> in init_irq or similar place. This might help also the multi-arm
> work too.

Did you see Eric Miao's patch series that introduces runtime IRQ demux 
handler support?

http://www.spinics.net/linux/lists/arm-kernel/msg92836.html

That is likely to be a better solution.


Nicolas
