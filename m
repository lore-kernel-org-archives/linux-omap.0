From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP: McBSP: Fix CLKR and FSR signal muxing
Date: Tue, 5 Oct 2010 10:41:45 -0700
Message-ID: <20101005174145.GK3117@atomide.com>
References: <1286281775-27692-1-git-send-email-jhnikula@gmail.com>
 <alpine.DEB.2.00.1010050911230.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52404 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0JERls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 13:41:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1010050911230.13816@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [101005 08:03]:
> On Tue, 5 Oct 2010, Jarkko Nikula wrote:
> 
> > Fix bit clear. Now it clears all other bits than mask bit where it should
> > clear only it.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> 
> Doh.  Thanks Jarkko.
> 
> Obviously this is an important patch and should go in ASAP.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Jarkko, please repost this one more time with linux-arm-kernel list
Cc'd so I don't need to repost it before applying.

Regards,

Tony
