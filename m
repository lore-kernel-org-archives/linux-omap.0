From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 2/7] capebus: Add beaglebone board support
Date: Tue, 30 Oct 2012 12:36:34 -0700
Message-ID: <20121030193633.GQ11908@atomide.com>
References: <1351702333-8456-1-git-send-email-panto@antoniou-consulting.com>
 <1351702333-8456-3-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351702333-8456-3-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [121030 12:00]:
> +#include <plat/clock.h>
> +#include <plat/omap_device.h>

We already have queued patches to make omap_device.h
private to arch/arm/mach-omap2. Then plat/clock.h will
be gone with the common clock framework patches.

Regards,

Tony
