From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 2/7] ARM: dts: am33xx: Fix GPMC dma properties
Date: Wed, 13 Apr 2016 12:45:46 -0700
Message-ID: <20160413194546.GA5995@atomide.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
 <1457654203-20856-3-git-send-email-fcooper@ti.com>
 <56E2CF04.4020806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56E2CF04.4020806@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, rogerq@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160311 06:01]:
> On 03/11/2016 01:56 AM, Franklin S Cooper Jr wrote:
> > This patch updates the GPMC's DT DMA property to reflect the updated eDMA
> > bindings.
> > 
> > Fixes: b5e509066074 ("ARM: DTS: am33xx: Use the new DT bindings for the eDMA3")
> 
> I have double checked the switch over to the new eDMA bindings when I sent it
> and there were no gpmc node existed back then afaik.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applying patches 2 & 3 into omap-for-v4.6/fixes thanks.

Tony
