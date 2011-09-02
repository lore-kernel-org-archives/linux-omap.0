From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: testing-board branch: rebase to RMK's devel-stable?
Date: Fri, 2 Sep 2011 14:47:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1109021446300.20358@xanadu.home>
References: <87vcta7r9f.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44862 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab1IBSrU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 14:47:20 -0400
Received: by qyk34 with SMTP id 34so1967457qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 11:47:20 -0700 (PDT)
In-Reply-To: <87vcta7r9f.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, 2 Sep 2011, Kevin Hilman wrote:

> Hi Tony,
> 
> Your testing-board branch currently has a couple new boards that are
> missing the boot_params to atag_offset conversion (patch below.)
> 
> There's a patch below to fix this, but maybe it's better to just rebase
> your testing-board branch onto Russell's devel-stable branch (where he's
> merged the seris from Nico) so any board stuff we add is sure to do it
> correctly.

I would suggest that too.


Nicolas
