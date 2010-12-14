From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/12] OMAP4: PRCM: Add SCRM header file
Date: Tue, 14 Dec 2010 11:13:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012141105570.15971@utopia.booyaka.com>
References: <20101214063308.21555.76050.stgit@twilight.localdomain> <20101214063447.21555.64470.stgit@twilight.localdomain> <4D07782E.5050000@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40859 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755608Ab0LNSNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 13:13:23 -0500
In-Reply-To: <4D07782E.5050000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

On Tue, 14 Dec 2010, Cousson, Benoit wrote:

> This patch will conflict with your power prcm series, because you are creating
> an empty scrm44xx.h in it.
> 
> So I did rebased this series on top on your prcm to fix that.
> 
> Don't you want to use the already rebased version instead?

I would rather have patches and branches based on mainline commits where 
possible.  If a series has some explicit dependency on a non-mainline 
patch or branch then I'd like to know about it in the messages if 
possible.

As far as the empty scrm44xx.h goes, I will probably go back and rebuild 
that branch with your patch that creates SCRM from my patch set inserted 
earlier, so I can drop the part of my patch that creates the empty file.


- Paul
