From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: linux-next: manual merge of the omap_dss2 tree with the omap
 tree
Date: Mon, 08 Feb 2010 11:29:06 +0200
Message-ID: <1265621346.2433.27.camel@tubuntu.research.nokia.com>
References: <20100208172521.abb500b4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100208172521.abb500b4.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: ext Stephen Rothwell <sfr@canb.auug.org.au>, Tony Lindgren <tony@atomide.com>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vaibhav Hiremath <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 2010-02-08 at 07:25 +0100, ext Stephen Rothwell wrote:
> Hi Tomi,
> 
> Today's linux-next merge of the omap_dss2 tree got a conflict in
> arch/arm/mach-omap2/board-am3517evm.c between commit
> 13560d875d67c06239c82a6148c1b87075701fe9 ("AM3517: Enable basic I2C
> Support") from the omap tree and commit
> 56a3d0235cd50d14d7bd4d45e55d192aa0e78cac ("OMAP: AM3517: Enable DSS2 for
> AM3517EVM board") from the omap_dss2 tree.
> 
> Juts overlapping additions.   I fixed it up (see below) and can carry the
> fix as necessary.

Thanks. I guess we can't properly fix this until the patch from omap
tree goes into mainline.

Tony, do you think this current way, in which we have board file changes
in both linux-omap and the dss tree, is best we can do? Or should all
the board file changes go through linux-omap? I fear that we will have
conflicts with every new board.

> P.S. Tomi, this omap_dss2 commit only has your Acked-by not Signed-off-by.

Hmm, do you mean there's something wrong with that, or "jfyi"? Aren't I,
as a subsys maintainer, supposed to ack the patches?

 Tomi
