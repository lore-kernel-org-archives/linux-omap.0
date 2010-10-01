From: Tony Lindgren <tony@atomide.com>
Subject: Re: multiple linux-next OMAP3 build errors
Date: Fri, 1 Oct 2010 09:57:37 -0700
Message-ID: <20101001165737.GT3117@atomide.com>
References: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49602 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab0JAQ5l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 12:57:41 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

* Grazvydas Ignotas <notasas@gmail.com> [101001 08:49]:
> hi,
> 
> I've been building linux-next for a while now and keep getting these
> build errors, just posting them here in case not all are known. Not
> familiar enough with that code to send patches unfortunately.
> 
>   AS      arch/arm/mm/proc-v7.o
> arch/arm/mm/proc-v7.S: Assembler messages:
> arch/arm/mm/proc-v7.S:363: Error: undefined symbol `PMD_FLAGS' in operation

This I've already fixed in omap-testing branch. Should get merged into
for-next soonish.

Regards,

Tony 
