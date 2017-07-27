From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/6] Motorola Droid 4 Audio Support
Date: Thu, 27 Jul 2017 02:39:43 -0700
Message-ID: <20170727093943.GC10026@atomide.com>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170717092904.GG10026@atomide.com>
 <20170717101258.llyly7kwfnwtoftr@earth>
 <20170717101709.GI10026@atomide.com>
 <20170717141347.t2642xbkol3g36rv@earth>
 <20170718054833.GL10026@atomide.com>
 <20170718092931.be3lyp6m6xvjb5yv@earth>
 <s5h7ez6ccgm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h7ez6ccgm.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Takashi Iwai <tiwai@suse.de> [170718 02:38]:
> 
> The problem manifests itself as an unblanaced of node reference.
> The node is released mistakenly at of_node_put() and this is caught as
> sleep-in-atomic, fortunately.
> 
> So likely either something forgot to take the node ref or it hits the
> unreference due to the missing object by the implicit probe disorder,
> etc, I suppose.

Yup you're right. This is what happens, will send a fix for it shortly.

Regards,

Tony
