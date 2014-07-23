From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ARM: OMAP: generic: add call to of_clk_init()
Date: Wed, 23 Jul 2014 11:17:52 +0200
Message-ID: <53CF7DC0.3000006@zonque.org>
References: <1405162508-9835-1-git-send-email-zonque@gmail.com> <20140723085444.GC22006@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:50156 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757395AbaGWJRz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jul 2014 05:17:55 -0400
In-Reply-To: <20140723085444.GC22006@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

Hi Tony,

On 07/23/2014 10:54 AM, Tony Lindgren wrote:
> * Daniel Mack <zonque@gmail.com> [140712 03:57]:
>> This is needed to instanciate fixed clocks in the DT.
> 
> Makes sense to me. Does this fix some regression or hang
> that's needed for the -rc series?

No, it's a feature addition. No need to hurry :)

> Also would like to get an ack from Tero on this as the other
> clocks are initialized elsewhere.

Ok, thanks. I'm open to alternative ways of course.


Thanks,
Daniel

