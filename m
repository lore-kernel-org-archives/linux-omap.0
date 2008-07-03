From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2/3 PM: Add OMAP PM no-op layer
Date: Thu, 3 Jul 2008 09:09:00 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807030907320.17241@utopia.booyaka.com>
References: <20080617145905.20886.89236.stgit@localhost.localdomain> <20080617150122.20886.9290.stgit@localhost.localdomain> <0f2a01c8d153$8e39c2e0$11dfa8c0@ent.ti.com> <alpine.DEB.1.00.0806182351160.24288@utopia.booyaka.com>
 <003501c8dcfc$1b4e3a40$8cdfa8c0@ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49804 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbYGCPJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 11:09:01 -0400
In-Reply-To: <003501c8dcfc$1b4e3a40$8cdfa8c0@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ramesh Gupta G <x0023949@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, h-kanigeri2@ti.com, jouni.hogander@nokia.com, khilman@mvista.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, vpasam@ti.com

Hello Ramesh,

On Thu, 3 Jul 2008, Ramesh Gupta G wrote:

> > Perhaps something similar to an OMAP PM function
> > "omap_pm_dsp_get_opp_table()" that DSPBridge could call on startup?
> 
> Can you please provide tentative dates for the patches available with above
> function?

DSPBridge already has all of that OPP/frequency information inside its 
code, so that's what you should use until that function becomes available.


- Paul
