From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [alsa-devel] [PATCH 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 12 May 2014 23:13:14 +0200
Message-ID: <CAGhQ9VzjndCBp+ZHS3XPPvS4ors6u9BfHf4NY_HNYN5ynyQOYQ@mail.gmail.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:35410 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758203AbaELVNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 17:13:15 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, broonie@kernel.org, peter.ujfalusi@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benoit Cousson <bcousson@baylibre.com>

On 12 May 2014 11:12, Jyri Sarha <jsarha@ti.com> wrote:
> Since RFC version of the patch set:
> - Split callbacks removal patch away from "Integrated ASoC DAI
>   component driver implementation" patches for easier reading
>
> This set of patches fixes OMAP4+ HDMI audio. The structure of the
> implementatin looks a bit different than before. Instead of creating a
> driver specific API for a separate ASoC component driver to connect
> to, this implementation integrates an the component driver into the
> HDMI driver.
>
> The idea is to use an existing ASoC component driver API instead of
> creating a new custom API for each HDMI IP and to avoid splitting the
> driver to half for separate video and audio parts connected with the
> API.
>
> The new implementation also uses simple-audio-card for a machine
> driver instead of having its own HW specific machine driver.
>
> The patches are based on 3.15-rc2 merged with
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> and
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt-omap5
>
> Everything is pushed here here:
> git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-linux-feature-tree.git omap-hdmi-audio

hey, this worked straight away :)

But there seems to be something wrong with the channel mapping.

For stereo (speaker-test -c 2) the mapping is correct.

But for -c 4 and -c 8 it gets weird:
speaker-test -c 4 -s X # where X is 1-4
1: Front Left is Rear Left
2: Front Right is Rear Right
3: Rear Right is Front Right
4: Rear Left is Front Left

speaker-test -c 8 -s X # where X is 1-8
1: Front Left is Rear Left
2: Center is Rear Left
3: Front Right is Rear Right
4: Side Right is Front Right
5: Rear Right is silent
6: Rear Left is Center
7: Side Left is Front Left
8: LFE - Rear Right

I think you need to check what channel order ALSA expects. I believe
speaker-test does the right thing on my HTPC normally connected to my
receiver.

Note: I am not 100% sure about the -c 8 results. I might have to do
the test again.

Tested on VAR-DVK-OM44 (OMAP4460) with Yamaha RX-A1030 Surround receiver.

regards
Joachim Eastwood
