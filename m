From: Philippe Ombredanne <pombredanne-od1rfyK75/E@public.gmane.org>
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
Date: Thu, 15 Feb 2018 10:50:22 +0100
Message-ID: <CAOFm3uFJC2Xb0PuNECJ-Tvg2gQS==tMSc77p_keQoCexNqOkDg@mail.gmail.com>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk> <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180214220741.28306-3-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Dear Sebastian,

On Wed, Feb 14, 2018 at 11:07 PM, Sebastian Reichel
<sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> wrote:
> Motorola CPCAP is a PMIC with audio functionality, that can be
> found on Motorola Droid 4 and probably a few other phones from
> Motorola's Droid series.
>
> The driver has been written from scratch using Motorola's Android
> driver, register dumps from running Android and datasheet for NXP
> MC13783UG (which is similar to Motorola CPCAP, but not the same).
>
> The chip provides two audio interfaces, that can be muxed to two
> different audio codecs. One provides support for stereo output
> (named StDAC or HiFi), while the other only provides mono output
> (named Voice). Only the Voice codec provides a Capture interface.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

<snip>

> --- /dev/null
> +++ b/sound/soc/codecs/cpcap.c
> @@ -0,0 +1,1588 @@
> +/*
> + * ALSA SoC CPCAP codec driver
> + *
> + * Copyright (C) 2017 - 2018 Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> + *
> + * Very loosely based on original driver from Motorola:
> + * Copyright (C) 2007 - 2009 Motorola, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */

Could you consider using the new SPDX tags instead of this fine but
long legalese? [1]

<snip>

> +MODULE_ALIAS("platform:cpcap-codec");
> +MODULE_DESCRIPTION("ASoC CPCAP codec driver");
> +MODULE_AUTHOR("Sebastian Reichel");
> +MODULE_LICENSE("GPL");

This does not match your license: per module.h, GPL means GPL-2.0 or
later. You notice above is GPL-2.0, not "or later"

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst

-- 
Cordially
Philippe Ombredanne
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
