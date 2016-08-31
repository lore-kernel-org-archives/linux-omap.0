From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Wed, 31 Aug 2016 12:41:07 -0700
Message-ID: <20160831194107.wijnbmdns2jjvzkv@atomide.com>
References: <20160829182746.53vrgbxadqodzzug@atomide.com>
 <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
 <20160831141340.h24szdqjnicmt2ew@atomide.com>
 <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
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
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machel <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160831 11:34]:
> On 08/31/16 19:59, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [160831 07:14]:
> >> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160831 04:38]:
> >>> If we have McBSP w/o FIFO there is no need for the qos AFAIK.
> >>> I'm fine with the 30ms, if you have done the testing on OMAP3.McBSP2, probably
> >>> setting 30ms for McBSP with 1280 FIFO, 3ms for 128 FIFO and no qos for McBSP
> >>> w/o FIFO might be better. Or:
> >>>
> >>> latency = mcbsp->pdata->buffer_size * 23; /* 29.44ms on omap3's mcbsp2 */
> >>>
> >>> if (latency)
> >>> 	pm_qos_add_request(&mcbsp->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
> >>> 			   latency);
> >>
> >> OK let me run some tests with that and mcbsp2 fifo set to 128. My guess
> >> is that things already work for that case with no patches with the existing
> >> fifo based  snd_pcm_hw_constraint_step() setting limits low enough so
> >> we never enter deeper idle states, but let's see :)
> > 
> > Well not quite so :) The fixed limit of 30 ms also works with fifo
> > set to 128, but we still have audio fail without any patches.
> 
> does it fail at start time or later?
> At start time we will have ~10 DMA bursts of 128 words to fill the FIFO on McBSP2.

The problems start only later on, about 10 seconds into playing of
course depending on things like console activity etc.

> > @@ -1064,6 +1072,16 @@ int omap_mcbsp_init(struct platform_device *pdev)
> >  		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
> >  		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
> >  
> > +		/*
> > +		 * Prevent device from hitting deeper idle states between
> > +		 * DMA fifo loads. On omap3 mcbsp2 we have a larger FIFO of
> > +		 * 1280 bytes instead of the usual 128 bytes, and the measured
> 
> not bytes, but words. The word size does not matter, it can be 8, 16 or
> 32bits, but we have 1280 or 128 of these words.

Oh OK, will fix.

> > +		 * max latency we can tolerate is somewhere below 40 ms. To be
> > +		 * safe, use a fixed value of 30 ms to block off idle on omap3
> > +		 * while still allowing retention idle.
> > +		 */
> > +		mcbsp->latency = 30 * 1000;
> 
> were there issue with calculating the latency like
> 		mcbsp->latency = max_thres(mcbsp) * 23;

Yes, we're not hitting retention idle at all during play with FIFO set
to 128 words.

Regards,

Tony
