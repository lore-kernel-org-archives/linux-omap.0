From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 0/6] Motorola Droid 4 Audio Support
Date: Thu, 27 Jul 2017 05:01:06 -0700
Message-ID: <20170727120106.GE10026@atomide.com>
References: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170725 08:11]:
> Hi,
> 
> This adds audio support to Motorola Droid 4.
> 
> Tested:
>  - Playing via both DACs using Speaker, Earpiece, Headphone
>  - Recording using internal Mic
>  - Volume Controls
> 
> Known not to work:
>  - 3.5mm detection support (requires closed source firmware,
>    needs further investigation)
>  - Modem / Bluetooth Audio (actually untested, but probably
>    needs some quirks)
> 
> Changes since PATCHv2:
>  * Fix a whitespace issue
>  * Fix const notes Takashi provided
>  * Fix a DAPM route issue I accidently introduced in v2

Audio works for me after applying the cpcap-regulator fixes
and with the dts kobject ref fix I posted earlier today:

Tested-by: Tony Lindgren <tony@atomide.com>
