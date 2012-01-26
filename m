From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Thu, 26 Jan 2012 17:48:15 +0100
Message-ID: <OF4651C12F.58F763E5-ONC1257991.005C0D05-C1257991.005C4F23@transmode.se>
References: <4F206213.9070704@flatfrog.com> <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com> <4F2127B8.9000005@flatfrog.com> <4F213ED8.2020500@flatfrog.com> <alpine.DEB.2.00.1201260801410.11174@utopia.booyaka.com> <OF645D734B.78418504-ONC1257991.005A101B-C1257991.005A7809@transmode.se> <alpine.DEB.2.00.1201260934190.11174@utopia.booyaka.com> <alpine.DEB.2.00.1201260936440.11174@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:33927 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180Ab2AZQsT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 11:48:19 -0500
In-Reply-To: <alpine.DEB.2.00.1201260936440.11174@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: David Woodhouse <dwmw2@infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Orjan Friberg <of@flatfrog.com>, Richard Purdie <rpurdie@openedhand.com>

Paul Walmsley <paul@pwsan.com> wrote on 2012/01/26 17:38:46:
>
> On Thu, 26 Jan 2012, Paul Walmsley wrote:
>
> > On Thu, 26 Jan 2012, Joakim Tjernlund wrote:
> >
> > > I think I found one bug by looking at the patch. You need 2 buffers, one
> > > that holds the latest compressed data and one working buffer.
> >
> > Thanks, I think you're right.  Here's an updated patch.
>
> ... which has another minor bug: it leaks memory if the first allocation
> fails.  Here's a version with that fixed.

Still leeks:
+		 		 		 		 best_slen = tdl;
+		 		 		 		 best_buf = tmp_buf;
+		 		 		 		 best = this;

You just throw away best_buf here, don't you?


