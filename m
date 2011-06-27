From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
Date: Mon, 27 Jun 2011 17:42:36 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
	<20110627111556.GM23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110627111556.GM23145@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Weber <weber@corscience.de>, Gregoire Gentil <gregoire@gentil.com>, "Bhandiwad, Hrishikesh" <hrishikesh.b@ti.com>, Jason Lam <lzg@ema-tech.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Monday, June 27, 2011 4:46 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Gregoire Gentil; 
> Bhandiwad, Hrishikesh; Jason Lam; Thomas Weber
> Subject: Re: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
> 
> * Sanjeev Premi <premi@ti.com> [110627 03:33]:
> > From: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
> > 
> > Present current selection of the GPTIMER on Beagleboard
> > was result of a hardware issue in early versions of the
> > Beagleboards (Ax and B1 thru B4). [1][2]
> > 
> > Its been long since the hardware issue has been fixed.
> > This patch uses GPTIMER 1 for all newer board revisions
> > incl. Beagleboard XM.
> > 
> > Also, the clock source for GPTIMER12 is much less frequency
> > stable than clock sources for GPTIMER1. Using GPTIMER12 can
> > result in major time skew over a fairly short interval.
> 
> I don't think omap3_beagle_init_rev is even called when
> the timer is set?

[sp] I verified the patch based on the print indicating that
     GPTIMER1 being used as clockevent source.
     http://marc.info/?l=linux-omap&m=130893319726456&w=2

> 
> But even if it was, this is not a good fix because of the
> dependency issues it causes to mux and gpio framework in
> omap3_beagle_rev_init.
> 
> The best way to fix this is to set a separate machine ID
> for the working beagle boards like I commented earlier.
> It allows just setting the .timer based on that, the rest
> of the code can be shared.

[sp] Sorry missed reading your comment. I wasn't checking
     mails while sending the updated patch.

> 
> Regards,
> 
> Tony
> 
