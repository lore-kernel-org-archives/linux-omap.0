From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2/3: DSS HWMOD fixes
Date: Wed, 27 Jun 2012 14:18:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271416420.27496@utopia.booyaka.com>
References: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54130 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab2F0USe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 16:18:34 -0400
In-Reply-To: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, archit@ti.com

Hi Tomi

On Thu, 10 May 2012, Tomi Valkeinen wrote:

> These patches fix DSS hwmod data related to sysc flags. I haven't seen any
> problem produced by these missing bits, but by looking at the TRM it's clear
> that they should be defined.
> 
> However, applying these will cause additional warnings to show during boot:
> 
> omap_hwmod: dss_dispc: softreset failed (waited 10000 usec)
> omap_hwmod: dss_rfbi: softreset failed (waited 10000 usec)
> 
> Most likely the softreset fails even now, but as there's no check to verify it,
> no warnings are visible.
> 
> I think the reason for the failing softreset is the same problem as we have on
> OMAP4: dss_core hwmod should be enabled before other dss hwmods can be enabled
> (and reset).

Thanks, queued for 3.6.

Not sure what to do about the softreset issues at the moment, due to 
competing priorities.  But for sure the data should match the hardware.


- Paul
