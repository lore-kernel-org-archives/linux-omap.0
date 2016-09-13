From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Tue, 13 Sep 2016 06:45:14 -0700
Message-ID: <20160913134512.7cpq3nuosn7rcgwl@atomide.com>
References: <7d1c9a2f-60ae-2d83-f7dc-55fe476dbccb@ti.com>
 <20160906201649.fx4vhuqmnziwshoe@atomide.com>
 <1b82e33a-7db5-81ed-de4f-75847f840088@ti.com>
 <20160908035356.mkk35s5gpcemifcg@atomide.com>
 <ceb7854b-6cd4-fe3d-ede7-016c64f88dc0@ti.com>
 <9452a3c6-9bf9-818f-6e8d-455193839e94@ti.com>
 <20160908144834.i722j3afyztk6vhh@atomide.com>
 <8ec65c33-cc92-7737-ac7a-1338bcab7b90@ti.com>
 <20160909234528.qku3fugiwglkqa3q@atomide.com>
 <6f6c2c1c-5ca4-f821-0690-c6c726b1263e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <6f6c2c1c-5ca4-f821-0690-c6c726b1263e@ti.com>
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
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machel <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160913 04:45]:
> On 09/10/16 02:45, Tony Lindgren wrote:
> >> In any way, according to the numbers:
> >> C7 is (7505 + 15274) vs (10000 + 30000)
> >> C6 is (7580 + 4134) vs (3000 + 8500)
> >> C5 is (855 + 1146) vs (2500 + 7500)
> >> C4 is (121 + 3374) vs (1500 + 1800)
> >> C3 is (107 + 410) vs (50 + 50)
> >>
> >> with the 30ms QoS we set we will still hit OFF on OMAP3430, it should minimum
> >> 11.715ms for omap3430, but that will block C6 on omap36xx.
> > 
> > Yeah those don't seem to be correct. The Nokia N9(50) kernel seems to have
> > some measured numbers for 36xx.
> 
> True, probably we should give those numbers a try? It looks like they have
> C1...C8 compared to mainline which have C1...C7.

Well some of those numbers are based on OSWR (Open SWitch Retention), not
sure if that works properly with mainline. Worth trying though.

> >> If we could have the data for the struct cpuidle_state coming from DT and not
> >> wired in the cpuidle34xx/44xx files then the McBSP driver could look up the C7
> >> number and block that...
> > 
> > I'm now thinking that your fifo threshold calculation is what we should
> > do, then fix the cpuidle latencies and playback should hit retention idle.
> 
> Right. So the QoS should be set time(FIFOsize - FIFOthreshold) - margin?
> What margin we should use? The DMA does not need setup time as it will just
> continue where it stopped, so probably we can ignore the margin and use the
> number we got from the FIFO use?

Yeah seems safe assuming the mystery numbers are wrong C state latencies :)

> During hw_param we can calculate this, but we need to consider on more thing:
> we need to make sure that the QoS we place covers the capture and the playback
> as well, so we need to use the worst case number. the FIFO threshold can be
> different for capture and playback.

OK makes sense to me.

Regards,

Tony
