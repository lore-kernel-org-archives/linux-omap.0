From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Fri, 21 Nov 2014 14:10:11 +0200
Message-ID: <546F2BA3.9050203@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk> <54646648.5030807@ti.com> <546DC9A0.8060700@ti.com> <20141121112317.GQ3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41687 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaKUMKV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 07:10:21 -0500
In-Reply-To: <20141121112317.GQ3815@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

On 11/21/2014 01:23 PM, Mark Brown wrote:
> On Thu, Nov 20, 2014 at 12:59:44PM +0200, Tomi Valkeinen wrote:
>
>> The series looks good to me, and works for me.
>
>> Do you have any comments for the sound/ parts? If not, I can merge this
>> series via fbdev tree, and for that I'd like your ack on the sound/ patches.
>
> I've not reviewed it yet and I'm still seeing some fairly basic
> discussion between Jiri and Jean-Francois about approaches to
> integrating HDMI which seem to have ground to a halt (I've not been
> reading them in any detail).  The fact that we're getting no sharing at
> all between all the different HDMI devices people are supporting and
> very limited dialogue between them is really setting off alarm bells.
>

OMAP HDMI audio is fundamentally different to the case on Armada or on 
BBB. In omap the whole HDMI IP is integrated to the SoC and there really 
is no codec in the ASoC sense. The the cpu-dai transmits the audio 
directly to hdmi wire and there is no i2s bus involved. So this case 
should not be mixed with the patches Jean-Francois working on. The code 
is also orthogonal in that sense that the latest omap-hdmi-audio uses 
the generic dymmy codec.

The issue about generic HDMI codec, that Jean-Francois (and soon me) is 
trying to solve - applies to the cases where a generic cpu-dai is 
connected to an external HDMI encoder with i2s (or s/pdif, unfortunately 
do not have such HW). In these cases the structure of the ASoC setup 
resembles closely the usual pattern of ASoC cards. The main difference 
is just that the "codec" IP also handling the video and there are no 
mixers, etc.

I am currently trying to find the common denominator between tda998x and 
SiI9022 HDMI encoder chips to come up with a generic solution for the 
external HDMI encoder case. However, this work is completely separate to 
the omap-hdmi-audio and its review should not be delayed because of the 
hdmi codec work.

Best regards,
Jyri

> As far as I can tell in order to figure out what to do with all this
> HDMI stuff I'm going to need to go to square one, get an overview of the
> hardware that's out there for myself and try to work out what to do with
> it.
>
> With this specific series I also need to figure out what all the video
> side is about (like I said earlier a lot of the patches look like
> they're supposed to be simple fixes for the video code not terribly
> closely tied to the rest of the series but none of them are getting
> applied) and what the end goal is beyond mechanically moving code.
>

