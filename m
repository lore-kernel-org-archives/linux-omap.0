From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v5 01/12] ASoC: davinci: Fix AM33xx SoC Audio support
Date: Tue, 22 Oct 2013 16:02:54 +0300
Message-ID: <5266777E.5050202@ti.com>
References: <cover.1382110089.git.jsarha@ti.com> <7289635e982532bb1a53865ae09cb7b17d866525.1382110089.git.jsarha@ti.com> <20131022122408.GE9388@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55615 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab3JVNDH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Oct 2013 09:03:07 -0400
In-Reply-To: <20131022122408.GE9388@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, joelf@ti.com

On 10/22/2013 03:24 PM, Mark Brown wrote:
> On Fri, Oct 18, 2013 at 06:37:40PM +0300, Jyri Sarha wrote:
>> SND_DAVINCI_SOC is a platform driver for Davinci and AM33XX SoCs, not
>> a machine driver. Make SND_AM33XX_SOC_EVM dependent of SND_DAVINCI_SOC
>> instead of selecting it and add dependecy to SOC_AM33XX.
>
> This doesn't apply against topic/davinci or -next - can you please
> check?
>

It seems the "ASoC: davinci: Add support for AM33xx SoC Audio"-patch is 
missing from the tree. I dropped it from the set because I tought you 
merged it earlier.

I'll restore the "ASoC: davinci: Add support for AM33xx SoC Audio" 
-patch to next version of the set and squash this one in to it.

Best regards,
Jyri

