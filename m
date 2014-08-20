From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2 3/8] ASoC: davinci-evm: HDMI audio
 support for TDA998x trough McASP I2S bus
Date: Wed, 20 Aug 2014 16:03:46 +0300
Message-ID: <53F49CB2.5020801@ti.com>
References: <cover.1408397864.git.jsarha@ti.com>
 <a92cd9257efb58711b2d5d3de2abff9c8a1052d2.1408397864.git.jsarha@ti.com>
 <20140819131621.GL3302@leverpostej> <53F3A843.4010409@ti.com>
 <20140820123434.GC21734@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140820123434.GC21734@leverpostej>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ezequiel.garcia@free-electrons.com" <ezequiel.garcia@free-electrons.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "airlied@linux.ie" <airlied@linux.ie>, "t-kristo@ti.com" <t-kristo@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "detheridge@ti.com" <detheridge@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/20/2014 03:34 PM, Mark Rutland wrote:
...
> Sorry, I meant in the same node. I take it we never expect:
>
> compatible = "ti,am335x-beaglebone-black-audio", "ti,da830-evm-audio";
>

No never like that.

>>> > >Is the 'x' in the BBB string a wildcard? If we know the particular
>>> > >number for BBB we should use that.
>>> > >
>> >
>> >Yes, its a wild card. BBBs have been made at least with AM3358 and
>> >AM3359 SoCs.
> In general we've pushed back against wildcard strings, and used the
> first implementation for the naming. We should be able to use
> "ti,am3358-beaglebone-black-audio" for AM335{8,9} assuming the block is
> the same? Otherwise we might need separate strings anyway.

At least the relevant block (McASP) is the same. AM335x is commonly used 
in all TI documentation, but I am not picky am3358 is fine with me.

Could we drop the SoC id completely and make it just 
"beaglebone-black-audio"?

The board design is the unique factor here, not the SoC. McASP block can 
be found from several TI SoCs.

Cheers,
Jyri
