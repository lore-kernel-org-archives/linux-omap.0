From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v7.1 09/19] ASoC: omap-hdmi-audio: Add platform device
 for OMAP HDMI audio support
Date: Mon, 1 Dec 2014 09:15:36 +0200
Message-ID: <547C1598.1000509@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <9a528990bbe116d9bb073f690b835c847b3fa0bf.1415803065.git.jsarha@ti.com> <20141129113230.GC7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51697 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471AbaLAHPo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Dec 2014 02:15:44 -0500
In-Reply-To: <20141129113230.GC7712@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com

On 11/29/2014 01:32 PM, Mark Brown wrote:
> On Wed, Nov 12, 2014 at 04:41:00PM +0200, Jyri Sarha wrote:
>> The platform device should only be registered from OMAPDSS HDMI
>> driver. The platform driver registers and unregisters all ASoC
>> components needed for OMAP HDMI audio.
>
> So, this basically seems fine but I'm looking at this code and I'm not
> really seeing a huge amount of OMAP specificness here.  Why is this an
> OMAP driver and not something more generic - can't we have other HDMI
> controllers offering the same interface?  There's a few serial numbers
> that would need filing off but since the ASoC driver is basically just
> interface matching and not talking to the hardware it looks like it
> ought to be usable by more than just OMAP.
>

The only reason is that I have not encountered any other audio capable 
HDMI device falling in this category (cpu-dai integrated within HDMI 
device block). Without at least two devices utilizing this code it 
remains questionable whether the code is really generic. At least the 
dss_version should be replaced with some explicit data to fill struct 
snd_soc_dai_driver. Also struct omap_dss_audio is coming directly from 
omap dss code, its contents is generic but I am not sure if the 
information within struct snd_aes_iec958 and struct snd_cea_861_aud_if 
is enough to configure the HDMI IP in all possible cases.

I can work on making this API look more generic, but before there is 
another candidate to use this API it is questionable if the code will 
ever be used by any other device.

Best regards,
Jyri



