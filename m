From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv4 0/7] TWL6030 audio codec initial support
Date: Wed, 24 Feb 2010 11:40:18 +0000
Message-ID: <1267011618.3274.202.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B12@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD1B12@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2010-02-23 at 18:10 -0600, Olaya, Margarita wrote:
> Following patch series add initial support for TWL6030 codec driver.
> The patch set is based on the series sent from Misael Lopez in October 2009.
> 
> Changes from v3:
> - Remove snd_soc_init_card function
> - Adapt to latest twl core changes based on Balaji's comment
> 
> Regards,
> Margarita
> 
> ---
> Misael Lopez Cruz (7):
>   OMAP4: PMIC: Add support for twl6030 codec
>   ASoC: TWL6030: Add twl6030 codec driver
>   ASoC: TWL6030: Manual power-up/down sequences
>   ASoC: TWL6030: Add support for low-power PLL
>   ASoC: TWL6030: Add restrictions for low-power playback mode
>   ASoC: TWL6030: Enable audio interrupt
>   ASoC: TWL6030: Detect power-up sequence completion

Btw, since this is a new driver can you rebase the 6 codec patches into
a single patch.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
