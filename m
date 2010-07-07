From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH] omap3: Unify omap2_set_globals_3[43,6x]x functions
Date: Wed, 7 Jul 2010 13:34:30 +0300
Message-ID: <20100707103429.GH1920@atomide.com>
References: <1277843427-25596-1-git-send-email-saaguirre@ti.com>
 <87mxudlbo2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55706 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab0GGKee (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 06:34:34 -0400
Content-Disposition: inline
In-Reply-To: <87mxudlbo2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Sergio Aguirre <saaguirre@ti.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100630 01:18]:
> Sergio Aguirre <saaguirre@ti.com> writes:
> 
> > The only difference between them is the physical address of the
> > uart4 port, which is only present in 36xx chips.
> >
> > We don't really need to care about keeping these 2 functions, since
> > the decision to use uart4 is more cleanly done later when we do have
> > access to omap_revision variable.
> 
> Also, with the converion of UART to hwmod, there is no longer any need
> for UART base addresses in the globals struct (they've been removed in
> the work-in-progress conversion of UART.
> 
> > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 

I've applied this and added a comment for the uart4 only being on omap3630.

Tony
