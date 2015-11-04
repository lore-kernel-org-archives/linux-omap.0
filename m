From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
Date: Wed, 4 Nov 2015 14:07:11 +0530
Message-ID: <20151104083710.GK12910@localhost>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
 <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
 <CAOesGMg0KsHnbF8hEYPZ8bY8wz9fC0_m7-KS4A6kB__nUi9kAw@mail.gmail.com>
 <20151102100405.GJ21326@localhost>
 <5637534D.2020304@ti.com>
 <20151102154057.GQ21326@localhost>
 <5637853D.8040306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5637853D.8040306@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Olof Johansson <olof@lixom.net>, Sekhar Nori <nsekhar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Robert Schwebel <r.schwebel@pengutronix.de>, "arm@kernel.org" <arm@kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 02, 2015 at 05:46:05PM +0200, Peter Ujfalusi wrote:
> > Okay I have reverted the two and applied the edma patch sent, can you please
> > verify topic/edma_fix before I merge it and send my PULL request.
> 
> The branch looks good. Thank you!
> It would have been great if the DTS changes for am335x/am437x would have been
> in 4.4, but I will send them for 4.5 after rc1 is out.

Any confirmation that this fixes the reported issue before I send pull
request?

-- 
~Vinod
