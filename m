From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Mon, 27 Jun 2011 03:14:28 -0700
Message-ID: <20110627101427.GH23145@atomide.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
	<86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1106251635340.30205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1106251635340.30205@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, "Premi, Sanjeev" <premi@ti.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [110625 15:42]:
> On Sun, 26 Jun 2011, Premi, Sanjeev wrote:
> 
> > [sp] I didn't include a reason - because the problem may not
> >      be reproducible on the public trees.
> > 
> >      During tests performed in internal development trees, the
> >      BogoMIPS calculations @ 1GHz wouldn't go beyond "830-850"
> >      range. While there was no such inconsistency on OMAP3EVM.
> 
> There are some other reasons to avoid GPTIMER12 when possible, which you 
> should probably put in the patch description.  The most important, in my 
> view, is that the clock source for GPTIMER12 is much less frequency-stable 
> than the clock sources for GPTIMER1.  So using GPTIMER12 can result in 
> major time skew over a fairly short interval.
> 
> I've been meaning to send a patch like this for some time, so I'm happy to 
> see this fixed.

This fix will cause bad dependency issues with sys_timer.

This patch has a dependency to omap3_beagle_init_rev, which depends on
the mux framework and gpio framework. Not cool for init_early. We just
want to initialize sys_timer early without any complicated dependencies.

The best way to fix this is to set a separate machine ID for the properly
working beagle boards like xm, then just set the .timer entry to omap3_timer
for working beagle boards and omap3_secure_timer for non-working beagle
boards. The rest of the board-*.c file can be shared.

The above assumes the patches in devel-timer branch where we no longer
have the non-standard timer interface, but use the sys_timer entries
instead like we should.

Regards,

Tony
