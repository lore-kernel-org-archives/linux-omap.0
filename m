From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Wed, 31 Aug 2016 07:13:40 -0700
Message-ID: <20160831141340.h24szdqjnicmt2ew@atomide.com>
References: <20160829182746.53vrgbxadqodzzug@atomide.com>
 <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
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

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160831 04:38]:
> >  
> > +	/* Prevent omap hardware from hitting off between fifo fills */
> > +	pm_qos_add_request(&mcbsp->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
> > +			   30 * 1000);
> 
> The latency value depends on the McBSP FIFO size and the speed the DMA can
> transfer the data.
> OMAP3.McBSP2 have 1280 word as buffer. All other McBSP across SoCs have 128
> words or no FIFO.

Yeah this is with mcbsp2 using boards like the beaglebone variants.
Probably the same issue on 900 as reported by Pavel earlier.

> The DMA fill speed will depend on several factors, I guess it is faster on
> OMAP4/5 then on OMAP3/2/1.

Probably this is only issue with mcbsp2..

> If we have McBSP w/o FIFO there is no need for the qos AFAIK.
> I'm fine with the 30ms, if you have done the testing on OMAP3.McBSP2, probably
> setting 30ms for McBSP with 1280 FIFO, 3ms for 128 FIFO and no qos for McBSP
> w/o FIFO might be better. Or:
> 
> latency = mcbsp->pdata->buffer_size * 23; /* 29.44ms on omap3's mcbsp2 */
> 
> if (latency)
> 	pm_qos_add_request(&mcbsp->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
> 			   latency);

OK let me run some tests with that and mcbsp2 fifo set to 128. My guess
is that things already work for that case with no patches with the existing
fifo based  snd_pcm_hw_constraint_step() setting limits low enough so
we never enter deeper idle states, but let's see :)

Regards,

Tony
