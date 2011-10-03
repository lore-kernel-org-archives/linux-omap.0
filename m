From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 25/30] ARM: OMAP depends on MMU
Date: Mon, 3 Oct 2011 11:22:05 -0700
Message-ID: <20111003182204.GB6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-26-git-send-email-arnd@arndb.de>
 <4E894664.5090609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E894664.5090609@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111002 21:47]:
> On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> > There is no way to build OMAP kernels without an MMU
> > at this point because of dependencies on MMU-only functions.
> > 
> > As long as nobody is interested in fixing this, let's just disable
> > this platforms for nommu kernels.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

This should be fine for now:

Acked-by: Tony Lindgren <tony@atomide.com>
