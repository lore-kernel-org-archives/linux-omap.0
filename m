From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Tue, 11 Aug 2009 07:14:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908110713410.17390@utopia.booyaka.com>
References: <1249907048-12163-1-git-send-email-rnayak@ti.com> <1249907048-12163-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.0908110632080.17390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58371 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbZHKNOA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 09:14:00 -0400
In-Reply-To: <alpine.DEB.2.00.0908110632080.17390@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, b-cousson@ti.com, sakari.poussa@nokia.com

On Tue, 11 Aug 2009, Paul Walmsley wrote:

> 2. It would be better to infix the module name in these, e.g., 
>    OMAP4430_CM2_INSTR_MOD (and add PRM, CM1 variants) rather than 
>    just OMAP4430_INSTR_MOD.  This will increase the number of defines but 
>    will decrease 

... confusion :-)


- Paul
