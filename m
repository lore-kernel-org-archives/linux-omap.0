From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
Date: Mon, 27 Jun 2011 04:15:57 -0700
Message-ID: <20110627111556.GM23145@atomide.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1309171009-8075-1-git-send-email-premi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sanjeev Premi <premi@ti.com>
Cc: Thomas Weber <weber@corscience.de>, Gregoire Gentil <gregoire@gentil.com>, Hrishikesh Bhandiwad <hrishikesh.b@ti.com>, Jason Lam <lzg@ema-tech.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [110627 03:33]:
> From: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
> 
> Present current selection of the GPTIMER on Beagleboard
> was result of a hardware issue in early versions of the
> Beagleboards (Ax and B1 thru B4). [1][2]
> 
> Its been long since the hardware issue has been fixed.
> This patch uses GPTIMER 1 for all newer board revisions
> incl. Beagleboard XM.
> 
> Also, the clock source for GPTIMER12 is much less frequency
> stable than clock sources for GPTIMER1. Using GPTIMER12 can
> result in major time skew over a fairly short interval.

I don't think omap3_beagle_init_rev is even called when
the timer is set?

But even if it was, this is not a good fix because of the
dependency issues it causes to mux and gpio framework in
omap3_beagle_rev_init.

The best way to fix this is to set a separate machine ID
for the working beagle boards like I commented earlier.
It allows just setting the .timer based on that, the rest
of the code can be shared.

Regards,

Tony
