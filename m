From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: Fix compile for twl-core.c by removing
 cpu_is_omap usage
Date: Mon, 17 Sep 2012 15:26:36 -0700
Message-ID: <20120917222635.GI11762@atomide.com>
References: <20120917202943.GV4521@atomide.com>
 <alpine.DEB.2.00.1209172207480.16117@utopia.booyaka.com>
 <20120917221406.GG11762@atomide.com>
 <alpine.DEB.2.00.1209172222570.18885@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209172222570.18885@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [120917 15:25]:
> On Mon, 17 Sep 2012, Tony Lindgren wrote:
> 
> > We need to queue this ASAP and before other patches to fix the
> > build breakage in linux next. Then you can merge in that commit
> > too, does that work for you?
> 
> That's fine, we'll just need a stable commit then that the CCF patches can 
> be based on.

OK cool, will let you know that once we hear from Samuel. Care to
ack the clock related changes?

There's pm24xx.c at least using osc_ck naming, so I added a new
alias to keep it generic for the driver instead of using omap
specific names.

Regards,

Tony 
