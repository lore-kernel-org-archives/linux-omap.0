From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 24 Nov 2014 16:55:32 +0200
Message-ID: <547346E4.2030801@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk> <54646648.5030807@ti.com> <546DC9A0.8060700@ti.com> <20141121112317.GQ3815@sirena.org.uk> <546F2BA3.9050203@ti.com> <20141121163815.GT3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56379 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126AbaKXOzl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2014 09:55:41 -0500
In-Reply-To: <20141121163815.GT3815@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

On 11/21/2014 06:38 PM, Mark Brown wrote:
> On Fri, Nov 21, 2014 at 02:10:11PM +0200, Jyri Sarha wrote:
>
>> OMAP HDMI audio is fundamentally different to the case on Armada or on BBB.
>> In omap the whole HDMI IP is integrated to the SoC and there really is no
>> codec in the ASoC sense. The the cpu-dai transmits the audio directly to
>> hdmi wire and there is no i2s bus involved. So this case should not be mixed
>> with the patches Jean-Francois working on. The code is also orthogonal in
>> that sense that the latest omap-hdmi-audio uses the generic dymmy codec.
>
> The discussion seemed to be about what to do with unplugged connections
> which isn't what you're talking about there and does seem like an area
> where we should at least be aiming for common behaviour even if not a
> common implementation.
>

In the discussion we recognized three modes of operation,
a) try to keep audio device always operational even if audio is not 
going anywhere (cable is disconnected or video mode does not support audio)
b) remove the audio device when audio is not available
c) disable audio device if audio is not available and abort any ongoing 
stream when audio becomes unavailable
d) force pause on the stream when audio is not available

The implementation in the patches follows mode c) and in my mind it 
makes the most sense. The mode is not carved into stone by the current 
implementation and it can be changed if we decide so. I see no point in 
keeping the hdmi audio completely broken until we collectively decide on 
how all HDMI audio devices should behave.

> There's also all the stuff about parsing EDIDs for capabilities which
> would seem to be related to that but seems to have gone off into the
> weeds.
>

The idea of the patch set is to restore the old hdmi audio functionality 
in a form that is easier to use and maintain. Additional functionality 
can be added later. For instance restricting the allowed sample rates 
etc. based EDID Short Audio Descriptors.

Best regards,
Jyri
