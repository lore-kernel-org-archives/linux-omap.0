From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCHv3 1/7] OMAP4: PMIC: Add support for twl6030
 codec
Date: Wed, 7 Oct 2009 20:30:29 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90CBD922@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90C2F648@dlee04.ent.ti.com>
	<200910061146.05080.peter.ujfalusi@nokia.com>
	<19F8576C6E063C45BE387C64729E73940436CF92F8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436CF92F8@dbde02.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Krishnamoorthy, Balaji T wrote:

> CONFIG_TWL6030_CORE and CONFIG_TWL4030_CORE is merged to
> CONFIG_TWL_CORE As two different build config was not encouraged. 
> Now switch twl_class_is_6030() will be used to decide at runtime time
> to support for 6030 related drivers, Similarly twl_class_is_4030()
> for 4030 drivers 

In patch "[PATCH v3 01/04] OMAP4: PMIC: Add support for twl6030 irq
framework" [1], TWL4030_CORE is redefined as TWL_CORE as you mentioned.
Then I guess that audio drivers should depend on TWL_CORE as well, if so
then we have to update all its dependencies:

1. TWL4030 codec driver: SND_SOC_TWL4030
2. All machine drivers using twl4030 codec driver: overo, omap2evm,
   omap3evm, sdp3430, omap3_pandora, omap3_beagle and zoom2

And I should do the same for twl6030 codec driver.

Regards,
-Misa

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17066.html
