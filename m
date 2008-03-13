From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: fix McBSP clock definitions
Date: Thu, 13 Mar 2008 13:32:34 +0200
Message-ID: <20080313113233.GF11653@atomide.com>
References: <1204844005-22683-1-git-send-email-khilman@mvista.com> <alpine.DEB.1.00.0803061728410.16759@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52746 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbYCMLcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 07:32:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0803061728410.16759@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080307 02:31]:
> On Thu, 6 Mar 2008, Kevin Hilman wrote:
> 
> > McBSP[234] clocks are in PER_MOD, not CORE_MOD.
> > 
> > Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> Thanks for the fix, Kevin.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing today.

Tony
