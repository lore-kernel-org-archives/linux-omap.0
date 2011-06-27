From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
Date: Mon, 27 Jun 2011 05:31:40 -0700
Message-ID: <20110627123140.GP23145@atomide.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
	<20110627111556.GM23145@atomide.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Thomas Weber <weber@corscience.de>, Gregoire Gentil <gregoire@gentil.com>, "Bhandiwad, Hrishikesh" <hrishikesh.b@ti.com>, Jason Lam <lzg@ema-tech.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Premi, Sanjeev <premi@ti.com> [110627 05:08]:
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > 
> > I don't think omap3_beagle_init_rev is even called when
> > the timer is set?
> 
> [sp] I verified the patch based on the print indicating that
>      GPTIMER1 being used as clockevent source.
>      http://marc.info/?l=linux-omap&m=130893319726456&w=2

I suspect the test always fails though, so it probably never
gets set to gptimer12 on any board :)

Tony
