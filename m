From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Wed, 7 Sep 2016 20:53:56 -0700
Message-ID: <20160908035356.mkk35s5gpcemifcg@atomide.com>
References: <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
 <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
 <20160902145604.nlixopwza76kfgbz@atomide.com>
 <c8f293f6-db2e-e518-7566-2cd92eb06ec0@ti.com>
 <20160902204049.uhp4oosu3oc4k5v6@atomide.com>
 <7d1c9a2f-60ae-2d83-f7dc-55fe476dbccb@ti.com>
 <20160906201649.fx4vhuqmnziwshoe@atomide.com>
 <1b82e33a-7db5-81ed-de4f-75847f840088@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1b82e33a-7db5-81ed-de4f-75847f840088@ti.com>
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

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160907 07:32]:
> On 09/06/2016 11:16 PM, Tony Lindgren wrote:
> > Makes sense. Do you have a formula or updated patch I can test here?
> > Then we can add comments about the possible unaccounted latencies that
> > can be worked out as needed.
> 
> Not yet, but I'll try to come up with something in the coming days.

OK

> btw: I have tried the idle off on beagbeboard-xm with audio, but even w/o the
> qos it is not triggering. w/o audio I hit off but if audio is running, not.

OK yeah figured it out you need to comment out the watch -n5 command
as that keeps the serial console busy :) I was doing it over ssh earlier
on the torpedo board.

> btw2: if you set the qos to 30ms and set the mcbsp2 threshold to 1024 (or
> leave it as default) do you have audio glitches? I think if we hit C6 we
> should not be able to wake up in time...

Not that I've noticed at least with the default fifo size. How can
I force the threshold to 1024? I tried changing pkt_size for
omap_mcbsp_set_threshold but not getting any audio.

Regards,

Tony
