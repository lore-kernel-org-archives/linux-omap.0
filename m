From: Paul Walmsley <paul@pwsan.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Wed, 25 Jan 2012 14:18:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251418310.5324@utopia.booyaka.com>
References: <4F206213.9070704@flatfrog.com> <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38847 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab2AYVSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 16:18:55 -0500
In-Reply-To: <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Orjan Friberg <of@flatfrog.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 25 Jan 2012, Paul Walmsley wrote:

> - Try changing all the spin_lock() calls to spin_lock_irqsave() and all 
>   the spin_unlock() calls to spin_unlock_irqrestore() to see if the 
>   preemption count is being prematurely decremented

Just to clarify, I mean in the jffs2 code, not the entire kernel.


- Paul
