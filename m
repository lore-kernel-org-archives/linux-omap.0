From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL enabled
 on UART3
Date: Wed, 21 Jan 2015 00:39:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501210039040.5450@utopia.booyaka.com>
References: <1420717924-3721-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1420717924-3721-1-git-send-email-lokeshvutla@ti.com>
Sender: stable-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, t-kristo@ti.com, nm@ti.com, nsekhar@ti.com, balbi@ti.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 8 Jan 2015, Lokesh Vutla wrote:

> With commit '7dedd34: ARM: OMAP2+: hwmod: Fix a crash in _setup_reset()
> with DEBUG_LL' we moved from parsing cmdline to identify uart used
> for earlycon to using the requsite hwmod CONFIG_DEBUG_OMAPxUARTy FLAGS.
> 
> On DRA7 UART3 hwmod doesn't have this flag enabled, and atleast on
> BeagleBoard-X15, where we use UART3 for console, boot fails with
> DEBUG_LL enabled. Enable DEBUG_OMAP4UART3_FLAGS for UART3 hwmod.
> 
> For using DEBUG_LL, enable CONFIG_DEBUG_OMAP4UART3 in menuconfig.
> 
> Fixes: 90020c7b2c5e ("ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data")
> Cc: <stable@vger.kernel.org> # v3.12+
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks, queued for v3.20.  Note that I don't have a DRA7xx board, so, 
cannot test.


- Paul
