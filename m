From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling
 hwmod
Date: Tue, 30 Oct 2012 03:11:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210300309190.12697@utopia.booyaka.com>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>  <alpine.DEB.2.00.1210230745160.32436@utopia.booyaka.com> <1350979419.2143.71.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47169 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab2J3DLG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 23:11:06 -0400
In-Reply-To: <1350979419.2143.71.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Venkatraman S <svenkatr@ti.com>, khilman@ti.com

Hi Tero,

On Tue, 23 Oct 2012, Tero Kristo wrote:

> Looks good to me. Only reason I pushed the reset wait to the end of the
> function was a minimal potential timing optimization. As the beginning
> of the function will write a register, it will consume a bit of time
> (especially if in 32k domain), so it can maybe save a single register
> read in the delay loop if ordered that way.

Ah, OK.

> Your way is probably safer, it might cause problems in some cases if the
> config is written before reset has completed (can it?)

Not sure, but seems to make sense to wait until the reset is done before 
doing anything to the IP block's registers.  Queuing for 3.7-rc fixes,


- Paul
