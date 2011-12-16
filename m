From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
Date: Fri, 16 Dec 2011 04:23:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160422150.12660@utopia.booyaka.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com> <1320317665-6381-4-git-send-email-rnayak@ti.com> <4ED52007.8010804@ti.com> <4ED85835.7080108@ti.com> <alpine.DEB.2.00.1112160414530.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53411 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab1LPLXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 06:23:24 -0500
In-Reply-To: <alpine.DEB.2.00.1112160414530.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi

On Fri, 16 Dec 2011, Paul Walmsley wrote:

> + * XXX Will not work correctly if the RM_*_CONTEXT register
> + * offset is 0 -- probably a flag should be used to avoid this
> + * situation, rather than testing @oh->prcm.omap4.context_offs.  No
> + * return value.

By the way, I'm also worried about this case.  Am wondering if we should 
add a flag here just to be sure, rather than testing the offset.  
Thoughts?


- Paul
