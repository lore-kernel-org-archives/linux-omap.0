From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: introduce omap3_map_io
Date: Wed, 7 Jul 2010 13:42:19 +0300
Message-ID: <20100707104218.GI1920@atomide.com>
References: <20100630063646.GS2822@atomide.com>
 <1277887672-9457-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63486 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706Ab0GGKmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 06:42:24 -0400
Content-Disposition: inline
In-Reply-To: <1277887672-9457-1-git-send-email-mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

* Mike Rapoport <mike@compulab.co.il> [100630 11:46]:
> Hi Tony,
> Here's the patch. It applies on top of Sergio's patch "Unify 
> omap2_set_globals_3[43,6x]x functions".

Thanks. I'll queue this one. However, it conflicts with the
"ARM: OMAP: Convert to use ->reserve method to reserve boot time memory"
patch, so I need to get a static commit from Russell to apply
this on.

Regards,

Tony
