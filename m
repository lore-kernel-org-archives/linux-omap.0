From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: warnings/hwmod/clock fixes for
 pre-3.7-rc1
Date: Tue, 9 Oct 2012 12:02:52 -0700
Message-ID: <20121009190252.GD12552@atomide.com>
References: <alpine.DEB.2.00.1210091602390.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29469 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752871Ab2JITC4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 15:02:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210091602390.5736@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121009 09:05]:
> 
> N800 isn't booting; this is a problem present in the base commit and
> is due to serial driver breakage:
> 
>    http://www.spinics.net/lists/arm-kernel/msg196034.html

This might be related also to the n800 booting in sys mode
that causes issues with the recent hyp patches. A fix for
that has been queued, for more info see the thread
"v2 2/7] ARM: virt: allow the kernel to be entered in HYP mode".

Regards,

Tony
