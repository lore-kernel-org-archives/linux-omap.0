From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm, omap2, sram: On HS/EMU devices, only 64K internal
 SRAM is available.
Date: Wed, 14 Oct 2015 15:20:23 -0700
Message-ID: <20151014222022.GL10113@atomide.com>
References: <1444715655-30077-1-git-send-email-hs@denx.de>
 <20151014174920.GE10113@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151014174920.GE10113@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Georg.Soffel@bosch-si.com, Ayoub Zaki <Ayoub.Zaki@bosch-si.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [151014 10:56]:
> * Heiko Schocher <hs@denx.de> [151012 22:58]:
> > Of this, secure content (including PPA) uses initial
> > portion of the SRAM. This chunk is not (and shouldn't
> > be) accessible from the public code.
> > 
> > The minimum size of this chunk (0x350) is used in this
> > patch. Available size is rounded off to 63K.
> > 
> > Both values would require a change if size of secure
> > content grows beyond 0x350.
> 
> Makes sense to me. And something similar is needed at least for
> dm814x to get rid of the imprecise abort during boot with
> commit bbeb92095159 ("ARM: 8422/1: enable imprecise aborts during
> early kernel startup") applied.
>
> Is this needed as a fix to the -rc cycle, or can this wait for
> v4.4?

Actually I think we may have a regression somwhere. If you look
at commit 8b9a2810b02e ("ARM: OMAP4+: Move SRAM data to DT")
this should all be handled by drivers/misc/sram.c nowadays.

So for most SoCs, we should completely skip the plat-omap/sram.c
code.

Regards,

Tony
