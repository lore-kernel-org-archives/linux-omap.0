From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 2 Feb 2012 13:29:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com> <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35031 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2BBU3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 15:29:53 -0500
In-Reply-To: <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, santosh.shilimkar@ti.com, rnayak@ti.com

On Thu, 2 Feb 2012, Paul Walmsley wrote:

> Great.  Do you know what the deal is with suspend on 34xx?  I enabled 
> ttyO2 wakeup and entered suspend, but serial traffic doesn't bring it out?

Just a quick followup; Kevin tracked this down.  v3.3-rc needs the MTD 
suspend patch that Artem posted recently to suspend correctly on OMAP35xx 
BeagleBoard with omap2plus_defconfig.  Thanks Kevin.


- Paul
