From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: am4372: Remove obsolete properties from
 edma node
Date: Wed, 14 May 2014 16:18:07 -0700
Message-ID: <20140514231807.GD13427@atomide.com>
References: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com>
 <1399977032-26469-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399977032-26469-6-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, joelf@ti.com, linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140513 03:31]:
> dma-channels, ti,edma-regions and ti,edma-slots no longer needed in DT since
> the the same information is available in the IP's CCCFG register.

This too:

Acked-by: Tony Lindgren <tony@atomide.com>
