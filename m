From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap: Check regulator enable for DAC
	on Pandora
Date: Sun, 03 Mar 2013 11:11:50 +0200
Message-ID: <1362301910.2226.4.camel@puukko.homenet-68>
References: <1362210594-17633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <5132146E.602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5132146E.602@ti.com>
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
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 2013-03-02 at 16:02 +0100, Peter Ujfalusi wrote:
> > diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
> > index 805512f..953483e 100644
> > --- a/sound/soc/omap/omap3pandora.c
> > +++ b/sound/soc/omap/omap3pandora.c
> > @@ -85,7 +85,11 @@ static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
> >  	 * VCC power on/off and /PD pin high/low
> >  	 */
> >  	if (SND_SOC_DAPM_EVENT_ON(event)) {
> > -		regulator_enable(omap3pandora_dac_reg);
> > +		ret = regulator_enable(omap3pandora_dac_reg);
> > +		if (ret != 0) {
> 
> The rest of this machine driver uses "if (ret < 0)" or "if (ret)". I would use:
>  +		if (ret) {
> 
...
> Otherwise:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
To whatever version of (ret != 0), (ret) or (ret < 0) is used :-)

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
