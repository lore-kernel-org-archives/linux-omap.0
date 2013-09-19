From: "Sarha, Jyri" <jsarha@ti.com>
Subject: RE: [PATCH v3 01/11] ASoC: davinci-evm: Move sysclk logic away from
 evm_hw_params
Date: Thu, 19 Sep 2013 13:43:50 +0000
Message-ID: <0EB243F40EB34A418EAED8001C4B3AD019E84280@DNCE05.ent.ti.com>
References: <cover.1379590035.git.jsarha@ti.com>
 <dad0f7eb787d3f65848425a67d668e3935033195.1379590036.git.jsarha@ti.com>,<20130919132316.GR21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42832 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab3ISNn7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Sep 2013 09:43:59 -0400
In-Reply-To: <20130919132316.GR21013@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Fernandes, Joel" <joelf@ti.com>

As I described in cover letter on these patches did change:

  [PATCH v2 05/11] ASoC: davinci-mcasp: Remove interrupt property from DT bindin
   - restore binding but make it optional and add interrupt-names property
  [PATCH v2 06/11] ASoC: davinci: Add support for AM33xx SoC Audio
   - SND_DAVINCI_SOC help "Machine driver for ..." -> "Platform driver for ..."
   - SND_AM33XX_SOC_EVM depends on SND_DAVINCI_SOC && SOC_AM33XX
   - SND_AM33XX_SOC_EVM does not selcet SND_DAVINCI_SOC
  [PATCH v2 09/11] ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries
   - restore interrupt property and add interrupt-names property----

Best regards,
Jyri

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

________________________________________
From: Mark Brown [broonie@kernel.org]
Sent: Thursday, September 19, 2013 4:23 PM
To: Sarha, Jyri
Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-omap@vger.kernel.org; Ujfalusi, Peter; liam.r.girdwood@linux.intel.com; grant.likely@linaro.org; rob.herring@calxeda.com; Fernandes, Joel
Subject: Re: [PATCH v3 01/11] ASoC: davinci-evm: Move sysclk logic away from evm_hw_params

On Thu, Sep 19, 2013 at 02:29:34PM +0300, Jyri Sarha wrote:
> The sysclk rate does not change runtime so it should be initialized at
> init time.

Are there any updates from the version already applied (I only dropped
the patch to allow the extra builds, not this one).

