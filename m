From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC][PATCH 0/2] OMAP3:PM:SR Refactor
Date: Thu, 1 Oct 2009 19:40:10 -0500
Message-ID: <4AC54BEA.8080307@ti.com>
References: <1254443465-13006-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbZJBAkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 20:40:14 -0400
In-Reply-To: <1254443465-13006-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-omap <linux-omap@vger.kernel.org>
Cc: Rajendra Nayak <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, Teerth Reddy <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>

Menon, Nishanth had written, on 10/01/2009 07:31 PM, the following:
> Hi,
> Smart Reflex sequencing recommendation has improved
> in recent times and presents an opportunity to refactor
> the code to add in understanding that we have of the
> system. The patch set replaces smartreflex.c with a
> new revision.
> 
> This revision is meant to be RFC due to the nature of
> intrusive changes done
> 
> Nishanth Menon (2):
>   OMAP3:PM:SR: prepare: remove old SR code
>   OMAP3:PM:SR: SmartReflex Refactor Rev2.0
> 
>  arch/arm/mach-omap2/resource34xx.c |    8 +-
>  arch/arm/mach-omap2/smartreflex.c  | 1899 +++++++++++++++++++++---------------
>  arch/arm/mach-omap2/smartreflex.h  |  241 +++---
>  arch/arm/plat-omap/Kconfig         |   18 +-
>  4 files changed, 1249 insertions(+), 917 deletions(-)
Should have added that the patches are against commit ID 
f3ba1f772ebf69fa8765aa2e4b2fbcd3e78c1081 on [1] pm branch

-- 
Regards,
Nishanth Menon
Ref:
[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
