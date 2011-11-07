From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] arm: omap2+: hwmod: fix breakage introduced by
 d6504acd
Date: Mon, 7 Nov 2011 14:30:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111071429530.12394@utopia.booyaka.com>
References: <1320688617-4543-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320688617-4543-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Nov 2011, Felipe Balbi wrote:

> commit d6504acd (OMAP2+: hwmod: remove OMAP_CHIP*) has
> mistakenly added MUSB as a hwmod available only on ES2.0
> of OMAP3430.
> 
> MUSB hwmod has always be available on all OMAP revisions
> since OMAP2430.

Are you sure about this?  I don't see it in my 3430ES1 TRM text.


- Paul
