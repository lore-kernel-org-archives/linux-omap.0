From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
Date: Mon, 27 Jun 2011 18:58:54 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D793464@dbde02.ent.ti.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
	<20110627111556.GM23145@atomide.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
	<20110627123140.GP23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110627123140.GP23145@atomide.com>
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
> Sent: Monday, June 27, 2011 6:02 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Gregoire Gentil; 
> Bhandiwad, Hrishikesh; Jason Lam; Thomas Weber
> Subject: Re: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
> 
> * Premi, Sanjeev <premi@ti.com> [110627 05:08]:
> > > From: Tony Lindgren [mailto:tony@atomide.com] 
> > > 
> > > I don't think omap3_beagle_init_rev is even called when
> > > the timer is set?
> > 
> > [sp] I verified the patch based on the print indicating that
> >      GPTIMER1 being used as clockevent source.
> >      http://marc.info/?l=linux-omap&m=130893319726456&w=2
> 
> I suspect the test always fails though, so it probably never
> gets set to gptimer12 on any board :)
>

[sp] While I take my time understanding things on devel-timer;
     I had a quick question - at risk of being flamed.

     Adding a new machine ID would trickle to u-boot and same
     uImage (default) may not work across board revisions.

     How does this scheme look like:
     - GPTIMER1 is used as default - as it works for most boards.
     - GPTIMER12 is used based on a static config option OR a
       board specific bootarg

     I know both these options aren't general practice. Still
     wanted to know your views in the current context.

~sanjeev

> Tony
>
