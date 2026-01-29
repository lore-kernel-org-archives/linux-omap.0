Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BE28934F
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709621; cv=none; b=FtdEMGUiJdHbya5b9ObLw74n0CKZWZQNnJMH1FNxwmjVFEUono+gOe4IquLzWfY8/p4qJuMzf/XlwA5MdGJPnIIHZxxN74DpQnD+1QrgX9BylGaUAouhTnRzV9ivjKaEOOe3VxybgZp2DTVBE54r4xe8U/8Ovz4Evjk4YdSNu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709621; c=relaxed/simple;
	bh=BmaXlCZ6264fsqvXXrjSoDhWiC9g1X99D6Z7+wsR+aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhJE2DKBetJev/sS+LxgqaCHE0mrMeksIhnv42yCbOTeJjGcyWa4gw3dWtrD9yFwjruEHFdM1qdeO4GG9kmvAK4vXA/8joaZ6Gi0BQrcMbIAWiSImL9A8lsvT38SSQJksauropOb+GlQiYyXHDSrnamtmZSg5I0KAL3udVHt/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-894723da7dfso17356426d6.1
        for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 10:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769709619; x=1770314419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/B1720oxlP4NMLZCxNr6vg90MXZvyAsBr77z/rjaXw=;
        b=gVk/W65BtzMBSpN0G8A5QN+PiniPxW61CTo4TjS2brf2RMEXbl40RJ0YQKcXV2+Rs2
         jgF483XK3pqMk7dl4f+4Kc7fGJV/LTPbGkuoofW0YHrzEdJyI5Lnn89BtiG1nBtN3SrS
         9kCbzXd5CcDOB9Dn6Xoeq2JmvgdHna2mquESKeFlRaNtqtc6Sl4K+YMQ/8XI0o55GIRY
         GhNKfJu0baFP8W9vINxjabwtd8OrEP5oVlhqbvnWBlGWraxAUztVlZp7h0I4I5Y4f3QM
         nTdduO5NnGoNfjDvZVX0flhCYKQQY/ArwD4PJo7824P95kHJOmSqX8ylbWjly4mLCn0c
         DFZA==
X-Forwarded-Encrypted: i=1; AJvYcCUwyAseGTanF/MXhFOi3ffADO4lO5Ua3Tb7vNHT0OhLzBZJMT1kTxWwCw7uPvQGRZaALJeGeidvYw/r@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKH/0AKxnqOwJLsfl/2SAtsPQDA2FG1LJkiz6kbXaLeDBlht+
	vCeYKxWYNADP/ND09KBmhDukS3XiULtbApKsmHhRZdcD1v4foTirKi1LpMZJuCyi
X-Gm-Gg: AZuq6aLZXwbR+it+uhXmIO2VsUFqdOMXG+JSUOfgnKjb6O5vF8IdnwI9lUsgEnZnDZO
	7QUTNmh2r8eY8IFzAATtG/2ipr4k1vBo3AL3nMPY543r26adiGYZg/wIHzSaiWECXKJYPOHTj5H
	xr1DkOOR64E/6StPuCYoMSbLoXuWq1xEEmxcujwLzslqCKF8w4G+kP8URtOb6+OEHouYDsVEi+W
	L2oh9niKsZefV++F3wW+SHcypfUMFNiefCZOGCg5zp01mt3AXwCB2WDwZy42i4jljgDqBF47CCn
	aYTHubRl0+zK82VTxYOzONtnTwY7B6maeTz2uNPNyMQrcVQDKwtW6wRfwaHdgnRn4V6f9M+bhPN
	5iUpsDotoYoiyHXs/m61k6moqG1d0K+Tm4iBuXGKf/ZJKOS5L2l7+2blJsgFV+fY2DTzH5QSvbE
	mvdrJhCyh4oIfgJQF9GeYq1sTnoX9Wyrw+1d48mWtvb2Ugo2Nn
X-Received: by 2002:a05:6122:912:b0:566:2741:2e5f with SMTP id 71dfb90a1353d-5669ffcb2e3mr44216e0c.3.1769703585724;
        Thu, 29 Jan 2026 08:19:45 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685becfecsm1369283e0c.14.2026.01.29.08.19.45
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:19:45 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5f530da3a07so698603137.1
        for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 08:19:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXD6x0UP5/UEI6HscqRRZFMfqqd+DLJoUyap4/FvmDlYrr5lAA/Mlakm4ocUZuB4EJhcXd1Om/SCUN9@vger.kernel.org
X-Received: by 2002:a05:6102:32d2:b0:5f1:50d0:3797 with SMTP id
 ada2fe7eead31-5f723937ba5mr3352368137.43.1769703201568; Thu, 29 Jan 2026
 08:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com> <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
In-Reply-To: <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Jan 2026 17:13:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
X-Gm-Features: AZwV_Qhgryuc7jjty9iqHy9zUzs2cyLGoonPOo05F0vrabMAU0UMySZvEVLbN1w
Message-ID: <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Jan 2026 at 17:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
> >
> > In-tree phy-can-transceiver driver has already implemented a local
> > version of devm_mux_state_get_optional.
> >
> > The omap-i2c driver gets and selects an optional mux in its probe
> > function without using any helper.
> >
> > Add new helper functions covering both aforementioned use-cases:
> >
> > - mux_control_get_optional:
> >   Get a mux-control if specified in dt, return NULL otherwise.
> > - devm_mux_state_get_optional:
> >   Get a mux-state if specified in dt, return NULL otherwise.
> > - devm_mux_state_get_selected:
> >   Get and select a mux-state specified in dt, return error otherwise.
> > - devm_mux_state_get_optional_selected:
> >   Get and select a mux-state if specified in dt, return error or NULL.
> >
> > Existing mux_get helper function is changed to take an extra argument
> > indicating whether the mux is optional.
> > In this case no error is printed, and NULL returned in case of ENOENT.
> >
> > Calling code is adapted to handle NULL return case, and to pass optional
> > argument as required.
> >
> > To support automatic deselect for _selected helper, a new structure is
> > created storing an exit pointer similar to clock core which is called on
> > release.
> >
> > To facilitate code sharing between optional/mandatory/selected helpers,
> > a new internal helper function is added to handle quiet (optional) and
> > verbose (mandatory) errors, as well as storing the correct callback for
> > devm release: __devm_mux_state_get
> >
> > Due to this structure devm_mux_state_get_*_selected can no longer print
> > a useful error message when select fails. Instead callers should print
> > errors where needed.
> >
> > Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> > property presence check") noted that "mux_get() always prints an error
> > message in case of an error, including when the property is not present,
> > confusing the user."
> >
> > The first error message covers the case that a mux name is not matched
> > in dt. The second error message is based on of_parse_phandle_with_args
> > return value.
> >
> > In optional case no error is printed and NULL is returned.
> > This ensures that the new helper functions will not confuse the user
> > either.
> >
> > With the addition of optional helper functions it became clear that
> > drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> > Add stubs for all symbols exported by mux core.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >  drivers/mux/core.c           | 178 ++++++++++++++++++++++++++++++++++++-------
> >  include/linux/mux/consumer.h | 108 +++++++++++++++++++++++++-
> >  2 files changed, 253 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> > index a3840fe0995f..b01ec126caaf 100644
> > --- a/drivers/mux/core.c
> > +++ b/drivers/mux/core.c
>
> [...]
>
> >  static void devm_mux_state_release(struct device *dev, void *res)
> >  {
> > -       struct mux_state *mstate = *(struct mux_state **)res;
> > +       struct devm_mux_state_state *devm_state = res;
> >
> > -       mux_state_put(mstate);
> > +       if (devm_state->exit)
> > +               devm_state->exit(devm_state->mstate);
> > +
> > +       mux_state_put(devm_state->mstate);
> >  }
> >
> >  /**
> > - * devm_mux_state_get() - Get the mux-state for a device, with resource
> > - *                       management.
> > - * @dev: The device that needs a mux-control.
> > - * @mux_name: The name identifying the mux-control.
> > + * __devm_mux_state_get() - Get the optional mux-state for a device,
> > + *                         with resource management.
> > + * @dev: The device that needs a mux-state.
> > + * @mux_name: The name identifying the mux-state.
> > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> > + * @init: Optional function pointer for mux-state object initialisation.
> > + * @exit: Optional function pointer for mux-state object cleanup on release.
> >   *
> >   * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
> >   */
> > -struct mux_state *devm_mux_state_get(struct device *dev,
> > -                                    const char *mux_name)
> > +static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
> > +                                             bool optional,
> > +                                             int (*init)(struct mux_state *mstate),
> > +                                             int (*exit)(struct mux_state *mstate))
> >  {
> > -       struct mux_state **ptr, *mstate;
> > +       struct devm_mux_state_state *devm_state;
> > +       struct mux_state *mstate;
> > +       int ret;
> >
> > -       ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
> > -       if (!ptr)
> > +       devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
> > +       if (!devm_state)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       mstate = mux_state_get(dev, mux_name);
> > -       if (IS_ERR(mstate)) {
> > -               devres_free(ptr);
> > -               return mstate;
> > +       mstate = mux_state_get(dev, mux_name, optional);
> > +       if (IS_ERR_OR_NULL(mstate)) {
> > +               ret = PTR_ERR(mstate);
>
> Should this be PTR_ERR_OR_ZERO?

"mux_state_get() never returns NULL"
https://lore.kernel.org/202601221036.J0kR78Uw-lkp@intel.com

>
> > +               goto err_mux_state_get;
> >         }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
