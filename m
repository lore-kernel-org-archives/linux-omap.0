From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 10/15] ASoC: omap-mcbsp: use permission-specific DEVICE_ATTR
 variants
Date: Sun, 30 Oct 2016 12:50:12 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1610301246120.2074@hadrien>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>        <1477769829-22230-11-git-send-email-Julia.Lawall@lip6.fr> <20161030125851.bd0e74854c52ce7d4ab3570c@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161030125851.bd0e74854c52ce7d4ab3570c@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Sun, 30 Oct 2016, Jarkko Nikula wrote:

> Hi
>
> On Sat, 29 Oct 2016 21:37:04 +0200
> Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> > Use DEVICE_ATTR_RW for read-write attributes.  This simplifies the
> > source code, improves readbility, and reduces the chance of
> > inconsistencies.
> >
> ...
> >
> > - DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
> > + DEVICE_ATTR_RW(x);
>
> I'm not so sure does this improve readability. 644 is pretty obvious but
> for DEVICE_ATTR_RW() one has to dive into include/linux/device.h and
> include/linux/sysfs.h to see for what users it grants the write access.

OK, as you like.  It does help ensure that the functions that are supposed
to be defined are available.  There were a couple of occurrences of 0644
with no show or no store function.  Among the three declarers, there are
currently in total over 800 uses in the kernel, so they are also not so
obscure.

julia
