From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Thu, 26 Jan 2012 18:33:37 +0100
Message-ID: <OFDD72D713.95FC023B-ONC1257991.005F7988-C1257991.00607681@transmode.se>
References: <4F206213.9070704@flatfrog.com> <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com> <4F2127B8.9000005@flatfrog.com> <4F213ED8.2020500@flatfrog.com> <alpine.DEB.2.00.1201260801410.11174@utopia.booyaka.com> <OF645D734B.78418504-ONC1257991.005A101B-C1257991.005A7809@transmode.se> <alpine.DEB.2.00.1201260934190.11174@utopia.booyaka.com> <alpine.DEB.2.00.1201260936440.11174@utopia.booyaka.com> <OF4651C12F.58F763E5-ONC1257991.005C0D05-C1257991.005C4F23@transmode.se> <alpine.DEB.2.00.1201260953550.32667@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:34356 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445Ab2AZRdk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 12:33:40 -0500
In-Reply-To: <alpine.DEB.2.00.1201260953550.32667@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: David Woodhouse <dwmw2@infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-mtd-bounces@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Orjan Friberg <of@flatfrog.com>, Richard Purdie <rpurdie@openedhand.com>

> From: Paul Walmsley <paul@pwsan.com>
> To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Richard Purdie <rpurdie@openedhand.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Orjan Friberg <of@flatfrog.com>
> Date: 2012/01/26 18:00
> Subject: Re: CONFIG_PREEMPT and JFFS2 oops
> Sent by: linux-mtd-bounces@lists.infradead.org
>
> On Thu, 26 Jan 2012, Joakim Tjernlund wrote:
>
> > Still leeks:
> > +                            best_slen = tdl;
> > +                            best_buf = tmp_buf;
> > +                            best = this;
> >
> > You just throw away best_buf here, don't you?
>
> You're right.  It's even worse than that.  best_buf will contain the data
> from the last compressor used.  And it will be prematurely freed.  Here's
> a fixed version.
>
> Time for breakfast.

hmm, that memcpy is costly. Just swap tmp_buf and best_buf instead?

Time to go home :)

 Jocke

