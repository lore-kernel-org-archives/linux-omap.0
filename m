From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/29] ARM: omap: clk: use clk_prepare_enable and
 clk_disable_unprepare
Date: Wed, 20 Jun 2012 23:43:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206202342360.10198@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com> <1339678038-23082-5-git-send-email-rnayak@ti.com> <20120614191147.GP19410@gmail.com> <4FDAC07A.7020702@ti.com> <20120620114149.GG12766@atomide.com> <4FE2B2C6.4010904@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57253 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab2FUFnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 01:43:17 -0400
In-Reply-To: <4FE2B2C6.4010904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 21 Jun 2012, Rajendra Nayak wrote:

> Paul, are you ok to look at them as preparatory patches for CCF
> conversion too?

Yes.  Also it looks like some of these patches should go through Mike 
since they add features to the CCF, so it's probably best to break those 
out into a separate series too.

- Paul
