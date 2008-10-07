From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] MUSB: Fixes endpoint allocation logic
Date: Tue, 7 Oct 2008 23:05:27 +0300
Message-ID: <20081007200526.GH8273@frodo>
References: <1223372190-8050-1-git-send-email-ajay.gupta@ti.com> <e5e6ade50810071121l60623de6r20848a8028b22f38@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35792 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbYJGUFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 16:05:36 -0400
Content-Disposition: inline
In-Reply-To: <e5e6ade50810071121l60623de6r20848a8028b22f38@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-omap@vger.kernel.org

On Tue, Oct 07, 2008 at 11:21:43AM -0700, Nathan Monson wrote:
> On Tue, Oct 7, 2008 at 2:36 AM, Ajay Kumar Gupta <ajay.gupta@ti.com> wrote:
> > musb->periodic[] flag was getting set for an endpoint even when only rx
> > or tx is used.This patch adds two field musb->in[16] and musb->out[16]
> > in place of musb->periodic[32] which will enable endpoint allocation
> > flag setting on rx/tx basis of an endpoint.
> 
> To apply this I had to make some changes to an older patch, since it
> used ->periodic:
> http://marc.info/?l=linux-omap&m=122284678326859&w=2
> 
> It seems to be working fine.  But, is there a way to get the latest
> versions of the pending MUSB patches?

I applied for a kernel.org account. If everything is fine, I'll be able
to put a musb queue there so you guys will be able to follow.

-- 
balbi
