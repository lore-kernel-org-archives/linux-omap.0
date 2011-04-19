From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Tue, 19 Apr 2011 09:27:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104190924030.24613@xanadu.home>
References: <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com> <4D80CA2F.8060300@ti.com> <alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com> <20110329233243.GR4016@atomide.com> <87lizwskcc.fsf@ti.com>
 <alpine.DEB.1.10.1103311722520.2634@esdhcp041196.research.nokia.com> <alpine.LFD.2.00.1104012241230.28032@xanadu.home> <20110413140429.GF12665@atomide.com> <alpine.LFD.2.00.1104131041590.24613@xanadu.home> <20110413150948.GB13345@atomide.com>
 <20110419101302.GF477@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59237 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab1DSN1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 09:27:45 -0400
Received: by vws1 with SMTP id 1so4232293vws.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 06:27:44 -0700 (PDT)
In-Reply-To: <20110419101302.GF477@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 19 Apr 2011, Tony Lindgren wrote:

> Aaro and I speculated that boards using u-boot with uImage work,
> while n900 is using zImage and fails with the same kernel probably
> because of the different placement of compressed image in the
> memory.

Could you try the following (by changing the argument to mkimage 
accordingly).
Try to load the kernel at the following offsets:

- 0x8000 from start of memory

- 0x100000 from start of memory

- 0x3000000 from start of memory

and tell me if any of those behaves differently?


Nicolas
