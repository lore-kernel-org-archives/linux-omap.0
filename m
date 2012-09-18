From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: Fix compile for twl-core.c by removing
 cpu_is_omap usage
Date: Mon, 17 Sep 2012 19:30:12 -0700
Message-ID: <20120918023011.GO11762@atomide.com>
References: <20120917202943.GV4521@atomide.com>
 <alpine.DEB.2.00.1209172207480.16117@utopia.booyaka.com>
 <20120917221406.GG11762@atomide.com>
 <alpine.DEB.2.00.1209172222570.18885@utopia.booyaka.com>
 <20120917222635.GI11762@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:60859 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932106Ab2IRCaP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 22:30:15 -0400
Content-Disposition: inline
In-Reply-To: <20120917222635.GI11762@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Felipe Balbi <balbi@ti.com>

* Tony Lindgren <tony@atomide.com> [120917 15:27]:
> * Paul Walmsley <paul@pwsan.com> [120917 15:25]:
> > On Mon, 17 Sep 2012, Tony Lindgren wrote:
> > 
> > > We need to queue this ASAP and before other patches to fix the
> > > build breakage in linux next. Then you can merge in that commit
> > > too, does that work for you?
> > 
> > That's fine, we'll just need a stable commit then that the CCF patches can 
> > be based on.
> 
> OK cool, will let you know that once we hear from Samuel. Care to
> ack the clock related changes?
> 
> There's pm24xx.c at least using osc_ck naming, so I added a new
> alias to keep it generic for the driver instead of using omap
> specific names.

Pushed out now with the ack from Samuel and sent the pull request.

Regards,

Tony
