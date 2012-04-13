From: Paul Walmsley <paul@pwsan.com>
Subject: Re: query about _setup() in omap_hwmod.c
Date: Fri, 13 Apr 2012 02:39:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204130234220.25832@utopia.booyaka.com>
References: <4F8550C6.9050402@ti.com> <alpine.DEB.2.00.1204130205200.25832@utopia.booyaka.com> <4F87E1F8.6000403@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39657 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab2DMIj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 04:39:29 -0400
In-Reply-To: <4F87E1F8.6000403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

Hi Archit,

On Fri, 13 Apr 2012, Archit Taneja wrote:

> There were still some issues related to this, particularly on OMAP4, I have
> posted a patch set to fix this just a while back.

Was looking at those.  The first one, removing the OCPIF_SWSUP_IDLE flags, 
makes sense to me.  But as far as the second one goes, it would be nice if 
we could use interface clocks again for interfaces, rather than functional 
clocks.  That's the root cause of the problem... Looks like this was added 
in commit da7cdfac1b0c58d6863532dd3b432c3fbc034978.  Maybe this is needed 
because we don't properly enable parent hwmods before the dependent child 
hwmods?


- Paul
