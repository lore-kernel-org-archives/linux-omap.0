From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Fri, 13 Aug 2010 13:53:57 +0400
Message-ID: <4C651635.8000201@ru.mvista.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com> <20100813080200.18750.37791.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50449 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761392Ab0HMJzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 05:55:31 -0400
Received: by eyg5 with SMTP id 5so47113eyg.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 02:55:30 -0700 (PDT)
In-Reply-To: <20100813080200.18750.37791.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

Hello.

Tony Lindgren wrote:

> From: Kevin Hilman <khilman@ti.com>

> Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
> mistakenly removed the check for PER when disabling the IO chain.
> 
> During idle, if the PER powerdomain transitions and CORE does not (as

   Does not what?

> is the case with the lower C-states when using CPUidle) the IO pad
> wakeups are not being disabled in the idle path after they are
> enabled.

WBR, Sergei
