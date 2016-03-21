From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Enable/disable
 sidetone block auto clock gating for omap3
Date: Mon, 21 Mar 2016 10:44:38 +0200
Message-ID: <56EFB476.70709@ti.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
 <1458296929-718-4-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191932240.6629@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <alpine.DEB.2.02.1603191932240.6629@utopia.booyaka.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Paul,

On 03/19/16 21:37, Paul Walmsley wrote:
> On Fri, 18 Mar 2016, Peter Ujfalusi wrote:
> =

>> OMAP3's McBSP2 and McBSP3 module have integrated sidetone block with
>> dedicated SYSCONFIG register. The sidetone is operating from the maain
>> McBSP module's ICLK. For normal operation the sidetone clock auto idle
>> support needs to be disabled when it is activated.
>> Note: This is not enough to avoid choppy sidetone because this AUTOIDLE
>> bit is controlling only the clock auto idle from the McBSP to the sideto=
ne
>> block. If the McBSP_ICLK is idling, the sidetone clock is going to do the
>> same.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> =

> Mark, please drop this patch for the time being, until the SoC integratio=
n =

> issues can be sorted out first.  It's best to wait a little while before =

> applying patches like these so folks have a chance to comment on their =

> correctness first.
> =

> We used to handle this problem in the OMAP hwmod SoC integration layer =

> with a flag that forced the interface clock to stay active as long as the =

> underlying IP blocks were active.  However I can't find that flag right =

> now in the current data, so maybe it got accidentally or inadvertently =

> removed at some point in time in the past.  The right way to fix this =

> would be to add that flag back in, rather than messing with the SoC =

> integration registers from the McBSP drivers.

I can not recall such a flag. We had both hwmods attached to the given McBSP
mkodule via dev_attr and we dealt with the McBSP_ICLK autoidle enable/disab=
le
via callbacks provided to the driver via platform data.
arch/arm/mach-omap2/mcbsp.c: omap3_enable_st_clock() In there we use
omap2_clk_deny_idle()/omap2_clk_allow_idle() to make sure that the ICLK is =
not
gated when the ST is enabled in the given McBSP module.
But this only works when we boot in legacy mode. The DT boot is broken in t=
his
regards as long we have first booted OMAP3 with DT.

-- =

P=E9ter
