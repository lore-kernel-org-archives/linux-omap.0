From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
Date: Thu, 24 Jun 2010 11:24:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006241118070.1550@utopia.booyaka.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com> <1274994799-30297-4-git-send-email-khilman@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB032320719C@dbde02.ent.ti.com> <87mxvebrry.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.1006210911150.1550@utopia.booyaka.com> <87hbkw1idx.fsf@deeprootsystems.com> <alpine.DEB.2.00.1006211130120.1550@utopia.booyaka.com> <87fx0gos2j.fsf@deeprootsystems.com> <alpine.DEB.2.00.1006231832570.1550@utopia.booyaka.com>
 <alpine.DEB.2.00.1006240105010.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42713 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0FXRYZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 13:24:25 -0400
In-Reply-To: <alpine.DEB.2.00.1006240105010.1550@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nayak\\, Rajendra" <rnayak@ti.com>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 24 Jun 2010, Paul Walmsley wrote:

> Sorry, misread this also.  Indeed, something like this is necessary in 
> your platform bus override code - so please ignore this part of the 
> comments.

By the way, I owe you a more general apology, Kevin, that some of these 
comments have been erroneous and that you have had to spend time 
addressing the half-baked ones.  They haven't measured up to my personal 
technical standards for comments...


- Paul
