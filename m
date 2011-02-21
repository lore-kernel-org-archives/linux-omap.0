From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: linux-next: manual merge of the omap_dss2 tree with the omap
 tree
Date: Mon, 21 Feb 2011 10:47:42 +0200
Message-ID: <1298278062.4931.19.camel@deskari>
References: <20110221141650.71b433b7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110221141650.71b433b7.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Tony Lindgren <tony@atomide.com>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Stephen and Tony,

On Sun, 2011-02-20 at 21:16 -0600, Stephen Rothwell wrote:
> Hi Tomi,
> 
> Today's linux-next merge of the omap_dss2 tree got a conflict in
> arch/arm/mach-omap2/board-3430sdp.c between commits
> e109f171e2f4128e867b3445c369c18830c73751 ("omap3sdp: Fix regulator
> mapping for ads7846 TS controller") and
> 6b272c098f64f0451d2b19bb911d65c6cd11cfc7 ("omap3sdp: clean regulator
> supply mapping in board file") from the omap tree and various commits
> from the omap_dss2 tree.
> 
> So, I have no idea how to fix this up ... Can you guys come to some
> argreement about who does what, please?  I have ended up with the merge
> fix below, but I have no idea if it will even build, much less be
> semantically correct, sorry.
> 
> Do these trees get merged separately by Linus?  If not, then maybe I
> should just be merging the one tree that combines all the omap work and
> let you guys figure out the merge mess.

No, linux-omap tree is merged directly by Linus, and my display
subsystem tree goes through Paul Mundt's fbdev tree.

In theory the DSS tree should be just a driver, and there shouldn't be
conflicts with any other tree. In practice it seems that there are quite
often arch/arm/mach-omap2/ changes, which then conflict with linux-omap
tree. And especially in this and the next merge windows, as there are
lots of new OMAP4 code going in.

It would be nice to get all arch omap changes through Tony's tree, and
DSS changes through my tree. But more often than not the changes depend
on each other, and applying just the other would break the kernel.

I see the following options to fix this:

1) DSS tree would go through Tony, not through Paul. I think Tony is not
in favor of this.
2) I would keep DSS tree based on top of some (semi-)stable branch from
linux-omap (which?), and rebase/merge quite often to keep the tree
conflict free. I would also need to wait until Tony's tree is merged
into Linus' tree before sending a pull request for DSS tree.
3) Remove DSS tree from linux-next to prevent this conflict mess. I
would wait until Tony's tree is pulled, rebase/merge and fix the
conflicts, and send a pull request.

None of these is perfect, but perhaps the second one could be the best.
We would still get the benefit of linux-next, without putting any more
burden on Tony.

Tony, do you have such a semi-stable branch I could use as a base? Or
any other ideas?

 Tomi
