From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Tue, 6 Sep 2016 13:08:13 -0700
Message-ID: <20160906200813.x4x2irmzthlk5oex@atomide.com>
References: <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
 <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
 <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
 <20160902155437.GA4152@amd>
 <2ff0fe3b-d2a2-6186-1091-6aa802eb3596@ti.com>
 <20160902200922.getqf6xbiivvamj5@atomide.com>
 <20160903160836.yvyucnp5oefuherq@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20160903160836.yvyucnp5oefuherq@earth>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Kristo, Tero" <t-kristo@ti.com>, alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160903 09:08]:
> Hi,
> 
> On Fri, Sep 02, 2016 at 01:09:23PM -0700, Tony Lindgren wrote:
> > > So it must be possible to reproduce it on BeagleBoard-xm...
> > > I will try to get the PM working on it and let's see (hear).
> > 
> > Yeah you can do that quite easily with current mainline or next with
> > omap2plus_defconfig. Just use minimal modules and make sure *hci USB
> > kernel modules are not loaded. So root on MMC, not NFS. The same goes
> > for few other modules, at least hsi and isp used to block idle but I
> > have not checked the recent status for those.
> 
> hsi should be fixed since 9c99e5e51988, which is part of 4.8.

OK thanks good to hear.

Regards,

Tony
