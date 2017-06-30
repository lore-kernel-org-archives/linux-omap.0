From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Thu, 29 Jun 2017 22:52:27 -0700
Message-ID: <20170630055227.GF3730@atomide.com>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [170629 11:50]:
> Is it just me or do other OMAP users fail to see omapdrm changes being
> posted to linux-omap for testing or review purposes?

Yeah Cc:ing linux-omap in addition to the drm list is a good idea. Hopefully
we get few more people to review changes that way.

What also should help preventing regressions is getting the changes into
Linux next early on during the -rc cycle. And switching the defconfigs to
use omapdrm instead of omapfb. Maybe we should do that right after v4.13-rc1
is tagged.

Cheers,

Tony
