From: "Matcovschi, Oleg" <oleg.matcovschi@ti.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: omap-pcm: Free dma buffers in case
 of error.
Date: Fri, 20 Apr 2012 17:59:25 +0000
Message-ID: <E0D6B3D7803B1A49AC7CEA9958379F6318873C@DFLE36.ent.ti.com>
References: <1334795870-5726-1-git-send-email-oleg.matcovschi@ti.com>
 <CAPo=G1yqVDj1u3_d28MzE1POaJcvi3e2VVh3i5EqmJuwgWWWkQ@mail.gmail.com>,<20120420130810.GA20681@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50934 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050Ab2DTR7a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 13:59:30 -0400
In-Reply-To: <20120420130810.GA20681@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From: Mark Brown [broonie@opensource.wolfsonmicro.com]
>Sent: Friday, April 20, 2012 6:08 AM
>To: Ujfalusi, Peter
>Cc: Matcovschi, Oleg; alsa-devel@alsa-project.org; linux-omap@vger.kernel.org
>Subject: Re: [alsa-devel] [PATCH] ASoC: omap-pcm: Free dma buffers in case of error.

>On Thu, Apr 19, 2012 at 07:00:55PM +0300, Ujfalusi, Peter wrote:

>> If the playback preallocation fails, or if only capture is supported
>> on the dai link
>> this is not needed.
>> It only applies if we have both playback and capture streams and the capture
>> preallocation fails.
>> Luckily the omap_pcm_free_dma_buffers() has internal checks for these cases...

>> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>Always CC maintainers on patches...

Should I resend patch again including maintainers?
Sorry, my first patch. Will do in future patches.

-Oleg
