From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: am437x/am33xx/omap/dm816x: Add gpmc dma
 channel
Date: Mon, 30 Nov 2015 11:06:16 -0800
Message-ID: <20151130190616.GN2517@atomide.com>
References: <1444930648-19313-1-git-send-email-fcooper@ti.com>
 <1444930648-19313-5-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444930648-19313-5-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-kernel@vger.kernel.org, rogerq@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, computersforpeace@gmail.com, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

* Franklin S Cooper Jr <fcooper@ti.com> [151015 10:42]:
> Add dma channel information to the gpmc. Although not enabled by
> default this will allow prefetch-dma to be used.

Picking up this patch only out of the series into omap-for-v4.5/dt.
The documentation patch does not apply as it has a dependency to
another series for adding the documentation. Please resend that
one separately once the documentation hits the mainline kernel.

The others patches in this series should get merged via the MTD tree.

Regards,

Tony
