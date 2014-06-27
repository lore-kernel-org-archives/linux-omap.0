From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 03/12] OMAPDSS: hdmi_wp: Add function for getting hdmi_wp
 physical base address
Date: Fri, 27 Jun 2014 14:35:58 +0300
Message-ID: <53AD571E.2070508@ti.com>
References: <cover.1403807781.git.jsarha@ti.com> <71e703f319eacd5a7196d8b34601b52e32b946d3.1403807781.git.jsarha@ti.com> <53AD4A72.5050905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44043 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163AbaF0LgQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 07:36:16 -0400
In-Reply-To: <53AD4A72.5050905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

On 06/27/2014 01:41 PM, Tomi Valkeinen wrote:
> On 26/06/14 22:20, Jyri Sarha wrote:
>> The hdmi_wp physical base address is needed for hdmi audio dma.
...
>
> Maybe it would be better to have a function which returns the phys
> address for audio DMA? Only that one register is needed, right?
>
> That makes the purpose of the function more obvious, and also if you
> return the phys_base, the caller needs to know the offset to the DMA
> register, and that offset should be a WP internal value.
>

Sounds good, I'll do that.

Cheers,
Jyri
