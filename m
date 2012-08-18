From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use
	for OMAP2430
Date: Fri, 17 Aug 2012 23:08:10 -0700
Message-ID: <20120818060810.GH11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
 <20120817130723.GZ11011@atomide.com> <502E43BC.30708@bitmer.com>
 <502E4F2B.6060403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <502E4F2B.6060403@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120817 07:03]:
> On 08/17/2012 04:14 PM, Jarkko Nikula wrote:
> > On 08/17/2012 04:07 PM, Tony Lindgren wrote:
> >> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> >>> On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
> >>> the FIFO for the audio stack.
> >> Is this the case also for 2420? I thought some only had a FIFO at
> >> one port?
> >>
> > IRCC (I don't have specs), nope. Only 2430 (as noted by Peter) and
> > onwards have FIFO.
> > 
> > But that's true that FIFO sizes differ between the ports. E.g. only
> > ports 2 and 3 have 1024+128 deep FIFOs in OMAP3.
> > 
> 
> OMAP2420 McBSP does not have FIFO (the IP is closer to OMAP1 McBSP).
> OMAP2430, OMAP4, OMAP5 has 128 word long FIFO on all McBSP ports.
> On OMAP3: McBSP2 have 1024+256 (1280) word FIFO the rest of the ports have 128
> long FIFO.

Thanks, is this patch still correct so it does not try to enable FIFO
for 2420?

Regards,

Tony
