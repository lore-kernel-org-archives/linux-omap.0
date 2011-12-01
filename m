From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2a/5 v2] ARM: OMAP1: select clock rate by CPU type
Date: Thu, 1 Dec 2011 10:22:54 -0800
Message-ID: <20111201182254.GU31337@atomide.com>
References: <20111128174508.GO31337@atomide.com>
 <1322686675-26855-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <20111130222837.GR31337@atomide.com>
 <201112011110.11476.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201112011110.11476.jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111201 01:35]:
> On Wednesday 30 of November 2011 at 23:28:38, Tony Lindgren wrote:
> > 
> > We should also now be able to remove all the CONFIG_OMAP_ARM_XXXMHZ options
> > too, right?
> 
> Right, but then, perhaps the initial version of patch 2a/5, which 
> already started removing them, from omap1_defconfig for now, then going 
> into the right direction while unblocking another regression fix (3/5), 
> _is_ a good candidate for an rc fix?

But we did not allow dpll1 reprogramming earlier either, so we should
not need to make all these changes during the -rc cycle. I'm suspecting
that we've had this same behaviour for a really long time, and we just
have not seen it as omap1_defconfig had OMAP_CLOCKS_SET_BY_BOOTLOADER
option set.

So I'm baffled how your board would be booting at a different rate
compared to v3.1, it seems that the logic has not changed there. Or
else we have some simple bug somewhere.

Care to try to verify at what point your system started booting at
60MHz rate?

Regards,

Tony
