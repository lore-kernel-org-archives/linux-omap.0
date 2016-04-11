From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix imprecise external abort for off mode on
 36xx
Date: Mon, 11 Apr 2016 14:13:39 -0700
Message-ID: <20160411211339.GI5995@atomide.com>
References: <1455140107-3328-1-git-send-email-tony@atomide.com>
 <5706C062.4040803@ti.com> <20160407231604.GP16484@atomide.com>
 <570BEAFB.6000409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <570BEAFB.6000409@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tero Kristo <t-kristo@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [160411 11:21]:
> Tony,
> On 04/07/2016 06:16 PM, Tony Lindgren wrote:
> >* Dave Gerlach <d-gerlach@ti.com> [160407 13:18]:
> >>
> >>I have a series to convert omap3 PM code to using generic SRAM driver but
> >>when testing I see an external abort on BBXM off mode resume very similar to
> >>this that seems to be timing related caused by using generic SRAM driver to
> >>re-copy PM code rather than omap3_sram_restore_context.
> >>
> >>By tracing the resume path I believe the abort is caused by
> >>omap3_intc_resume_idle in pm34xx.c, which writes to two registers in the
> >>INTC. Removing this call makes the abort unreproducible in my experiments
> >>and changing the writes to reads causes a bus lock, so I'm pretty confident
> >>it's coming from this call attempting to write to an idled INTC.
> >>
> >>Advisory 1.106 in DM3730 Silicon Errata Document [1] describes an issue with
> >>"MPU Leaves MSTANDBY State Before IDLEREQ of Interrupt Controller is
> >>Released" which sounds like a very similar failure situation to what we are
> >>seeing even though the timing of INTC access is a bit further from WFI exit
> >>than it describes. Perhaps there are more conditions where it can occur.
> >>Pushed my WIP branch for SRAM series that shows the same failure here [2].
> >
> >Interesting, I think you may have something with the errata 1.106.. And
> >looks like we also need still errata 1.62 handled also on 36xx in the
> >same pdf. And need to disable intc autoidle early at least for HS omaps
> >as save_secure_ram context supposedly also can do WFI.
> >
> >Maybe something like the following would make sense? It seems to work
> >here without external aborts with your test branch on dm3730, and boots
> >fine on omap3430 hs (n900).
> >
> >Or do you have some better ideas for a fix?
> 
> I can also confirm that this fixes the external abort, I can not cause it
> with your attached patch.

OK. I still can't quite see why exactly this patch fixes things. So
I'm afraid it might be just hiding the problem..

> I would be ok with the solution you have proposed and I was unable to come
> up with anything better while trying to debug the issue originally.
> 
> We still need the call to omap3_intc_resume_idle because the intc restore
> context only gets called on resume from off mode. Perhaps we only need to
> call omap3_intc_resume_idle when coming back from non-off modes, otherwise
> let the context restore handle the reconfig of the INTC idle/sysconfig
> registers?

OK. Did you actually test by commenting out omap3_intc_resume_idle()?

Yeah sounds like we can optimize out the restore there for non-off
modes.

Tony
