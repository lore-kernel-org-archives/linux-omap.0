From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 2a/5 v2] ARM: OMAP1: select clock rate by CPU type
Date: Thu, 1 Dec 2011 19:54:18 +0100
Message-ID: <201112011954.18258.jkrzyszt@tis.icnet.pl>
References: <20111128174508.GO31337@atomide.com> <201112011110.11476.jkrzyszt@tis.icnet.pl> <20111201182254.GU31337@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111201182254.GU31337@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 01 of December 2011 at 19:22:54, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111201 01:35]:
> > On Wednesday 30 of November 2011 at 23:28:38, Tony Lindgren wrote:
> > > 
> > > We should also now be able to remove all the CONFIG_OMAP_ARM_XXXMHZ options
> > > too, right?
> > 
> > Right, but then, perhaps the initial version of patch 2a/5, which 
> > already started removing them, from omap1_defconfig for now, then going 
> > into the right direction while unblocking another regression fix (3/5), 
> > _is_ a good candidate for an rc fix?
> 
> But we did not allow dpll1 reprogramming earlier either,

Wrong. Without OMAP_CLOCKS_SET_BY_BOOTLOADER selected, we always did, 
but only once, early at boot, before ck_dpll1_p->rate was set first from 
omap1_clk_init(), and never retried later, that's why that check which I 
removed with 3/5 was never in the game until e9b7086b80c4d9e354f4edc9e280ae85a60df408.

> so we should
> not need to make all these changes during the -rc cycle. I'm suspecting
> that we've had this same behaviour for a really long time, and we just
> have not seen it as omap1_defconfig had OMAP_CLOCKS_SET_BY_BOOTLOADER
> option set.
> 
> So I'm baffled how your board would be booting at a different rate
> compared to v3.1, it seems that the logic has not changed there. Or
> else we have some simple bug somewhere.
> 
> Care to try to verify at what point your system started booting at
> 60MHz rate?

Since e9b7086b80c4d9e354f4edc9e280ae85a60df408, I guess, and it's hard 
to confirm wituout bisecting the issue with too early sram call, back 
until things still worked like before map_io related changes. I will do 
that if you decide we should try to revert.

Thanks,
Janusz
