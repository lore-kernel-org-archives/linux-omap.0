Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DC35E526
	for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768944; cv=pass; b=XTgulk4XduI/tkhi5oq+D5psfrgMqn6IZ/oBLMS9Xn9a4X8zUTksVYrBmotHswEBEfgrJJnRwya7tPOjfhRhYHvWQK1Jby4106cwjR459EhDbuTMqg1bC+IUrSV3rPgutVXu030/N3QtxaCtGvm46eUkSSz428IR/MYzJS/LVgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768944; c=relaxed/simple;
	bh=4IZOypoh2mxenIel1BEB+3XJOHnFitDgJDIz3Q5JdHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3KZZjAlxeU/wlYCaJGtagiR+Puo0AeuPcVF2xSUKoJSLOXHP8NExL9WoWS7DIp8pupTfPMzLOEI9hHbvo5+Xai3tLw7jE8a+SVVhdxJRj5Bx30xcAOOqMTGlct51HcMvq0P28ZndzNjwG6NnHJKAudpGCJ0bJs+D8DzcJAZAI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oln1L8NE; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oln1L8NE"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b6c13b68dso2783381e87.0
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2026 02:29:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769768940; cv=none;
        d=google.com; s=arc-20240605;
        b=hIoombMujCTayDVECTRidXpBbcDbcoywJ6V+Z2dYdtLb/5yK1w4XSISMtpVkMVIyCF
         dWOyW/o2Z1EfPf7XlRthQUs4eniI3VaN/DHCTBgmLbBXUEDjnvMwP8RPslO1zUGVaDiN
         TZGd8Ad/wf5LIhxUfBUTVPh6h1Mcx4R08NBRjjjYxhQnFuTymUyBMOTviTomvwvLEkIf
         pLliNaaftdJ/FJNnVrCzOEhX27lSaAcyX0JGRMIBKcIF3xiBx8N7dzInmBOdZAPdlMpW
         xVAy65CjHJE8y6a+ZGA1LwEeTZX3x2JFVdTX3rVX/7nA7xNUFi9OyjCvIxWHxT53nO8n
         Qhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        fh=caRqoKATo47xy1IQnyJWwYBMAHh0m2HolwnbmMuvpg0=;
        b=H6Qli1vFkL88sprWb4BTAVDcTA9pNMqElK74Bzk/P6HfQ9cr/WVAj86mBnI5KG2RWQ
         aqR6HC7HC2dL9FX9zCFknmHt4XFCbASxypWgTsgDzir0eaDw+yJrVL35tToU/MnKvKX8
         g4mld+PWlfiZfZZi2nwrMxtk0Yi81IYgl7tGWT2UAOtKgVizZhUskHlBAMX3uvwt4XQS
         0dUb5tOE3NqVz4mPVPDpnYaFOOsqVx2HCeMZKN0NZHg6HOcwo6NUwKqJ8D5zlg5oLvxr
         OdFlTUtzC3m8e3uVZItCzEKyW1DE0m8Tqcg//dd3qElBZGXP3/bPl55zSlmgM3A0Tw76
         Z54g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769768940; x=1770373740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        b=oln1L8NESX4rFb4aQJM6o8+hQcZgtNvlDrkk5mWrDRGAqBdlUxeNxMcw2eX8cve9/k
         /B/tgoSqfiLOIQ6n5A7FGYAnfj5EkEFL8G5PmeCNy5FvfcKTZeeYcb2oSeEK7SPS4D8e
         AveR4t8N/Rp88C06eoXuFV1HaAjukzyQGL78WB1q/NBX2S2iW4b37uTbndAiZcD8Y53S
         yszc4WtoiN/tvRc5QBRssoUdiZyxH0VsMZ2fxnhKCwbFVUuo7ahbde+gcZ+cU5/AhEdd
         giiAjMR47BZz/ObY0X3fCnsdeDveajpO1Ikp0KpWblJ/09ymDA34ELw6z8uXK7gTFL4x
         OZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769768940; x=1770373740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        b=P2UP7VgkcySQqCy9JJ81/3/y6EbRe2gAF80k42AUISpyng2RjXLOYneg8RI21uniLc
         IVLIRyTT3+T5HbYYdDie+mAYJhHsyyzEQuNC7VFEtSLyYQdePJJTzy2xzuIQUB3QQDFN
         2psEHV/4KUTK8zq8Lfo4IhwrXeWV01ja5qwvQ+FyR+sF2pOj3AxOGIj40Babffv6zQYR
         dLPzExxvYicRULI685BoMn//CY4J0MNZBnbuztlMMqxTSAPQ9e7QD9KH3C+zIaMQvXvi
         pswR46I5JSMa4CbQJrgtfXqdtQu48gJnwY64+88pnFW1vNNKfOEmyrqemNXKolxt/KvI
         egqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsebAXMumPr8lbnOe+jCg5T59aJ7v5mWCS0uMGhxlt39WniXSupkoOo5EkjgSU5SYUjNeEofq83BJh@vger.kernel.org
X-Gm-Message-State: AOJu0YwIEWbZnvVBdnCOxpdApIEqBaE3vBpeeAvG6ZaCm6pd8tx8zZ83
	pZXshH0UNIEJu1ksUgesQab4aU9pJH1Hfi1aAfoUvCiox+dBbnV3GsUIgN/TXqbErXyQpgM7gcr
	FTCF6xlmEyz+W6FDD7A9sgdMxGamtAVZ2R/IFeQEngA==
X-Gm-Gg: AZuq6aJbavnnP2jBTBMr3yWtgiY9WAfg0ns95WyD8glkw1k8nXCScq4DFZpt9cJmKKL
	f1FvDPAl/TmNFswgeYqkR2O40OW2M7pyjCdyxGHbdcTxseN+X0Vv+lPdiQR1ANFeTeP94zAFagM
	lilalsqIQN+lVxhY7WSyZn8LQHvW/IumAvxd4OLmYq5zdQgiaOuf4O2bfM5alxYLx9TlmBE17cG
	cxmznm7hKaU3BapeDPJPOq9iWBPOmofJcEFY1u3AkgJO1tOCx6gqA0xymBqjWqoRKMV4GT1
X-Received: by 2002:a05:6512:3090:b0:59e:19f8:e7e5 with SMTP id
 2adb3069b0e04-59e19f8e879mr389940e87.10.1769768940222; Fri, 30 Jan 2026
 02:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com> <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
 <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
In-Reply-To: <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 Jan 2026 11:28:24 +0100
X-Gm-Features: AZwV_QjKt-7WVZ6iCRSlLFm6WIvZGroCu2x79LzMFz95tWuDMfGW172v0QkfhHE
Message-ID: <CAPDyKFrvSp6tmhP=2=9kca1d3+b6MezvxJWwMOW=Gv6D8TKrgA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Thu, 29 Jan 2026 at 18:46, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, 29 Jan 2026 at 17:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
> > >
> > > In-tree phy-can-transceiver driver has already implemented a local
> > > version of devm_mux_state_get_optional.
> > >
> > > The omap-i2c driver gets and selects an optional mux in its probe
> > > function without using any helper.
> > >
> > > Add new helper functions covering both aforementioned use-cases:
> > >
> > > - mux_control_get_optional:
> > >   Get a mux-control if specified in dt, return NULL otherwise.
> > > - devm_mux_state_get_optional:
> > >   Get a mux-state if specified in dt, return NULL otherwise.
> > > - devm_mux_state_get_selected:
> > >   Get and select a mux-state specified in dt, return error otherwise.
> > > - devm_mux_state_get_optional_selected:
> > >   Get and select a mux-state if specified in dt, return error or NULL.
> > >
> > > Existing mux_get helper function is changed to take an extra argument
> > > indicating whether the mux is optional.
> > > In this case no error is printed, and NULL returned in case of ENOENT.
> > >
> > > Calling code is adapted to handle NULL return case, and to pass optional
> > > argument as required.
> > >
> > > To support automatic deselect for _selected helper, a new structure is
> > > created storing an exit pointer similar to clock core which is called on
> > > release.
> > >
> > > To facilitate code sharing between optional/mandatory/selected helpers,
> > > a new internal helper function is added to handle quiet (optional) and
> > > verbose (mandatory) errors, as well as storing the correct callback for
> > > devm release: __devm_mux_state_get
> > >
> > > Due to this structure devm_mux_state_get_*_selected can no longer print
> > > a useful error message when select fails. Instead callers should print
> > > errors where needed.
> > >
> > > Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> > > property presence check") noted that "mux_get() always prints an error
> > > message in case of an error, including when the property is not present,
> > > confusing the user."
> > >
> > > The first error message covers the case that a mux name is not matched
> > > in dt. The second error message is based on of_parse_phandle_with_args
> > > return value.
> > >
> > > In optional case no error is printed and NULL is returned.
> > > This ensures that the new helper functions will not confuse the user
> > > either.
> > >
> > > With the addition of optional helper functions it became clear that
> > > drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> > > Add stubs for all symbols exported by mux core.
> > >
> > > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > > ---
> > >  drivers/mux/core.c           | 178 ++++++++++++++++++++++++++++++++++++-------
> > >  include/linux/mux/consumer.h | 108 +++++++++++++++++++++++++-
> > >  2 files changed, 253 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> > > index a3840fe0995f..b01ec126caaf 100644
> > > --- a/drivers/mux/core.c
> > > +++ b/drivers/mux/core.c
> >
> > [...]
> >
> > >  static void devm_mux_state_release(struct device *dev, void *res)
> > >  {
> > > -       struct mux_state *mstate = *(struct mux_state **)res;
> > > +       struct devm_mux_state_state *devm_state = res;
> > >
> > > -       mux_state_put(mstate);
> > > +       if (devm_state->exit)
> > > +               devm_state->exit(devm_state->mstate);
> > > +
> > > +       mux_state_put(devm_state->mstate);
> > >  }
> > >
> > >  /**
> > > - * devm_mux_state_get() - Get the mux-state for a device, with resource
> > > - *                       management.
> > > - * @dev: The device that needs a mux-control.
> > > - * @mux_name: The name identifying the mux-control.
> > > + * __devm_mux_state_get() - Get the optional mux-state for a device,
> > > + *                         with resource management.
> > > + * @dev: The device that needs a mux-state.
> > > + * @mux_name: The name identifying the mux-state.
> > > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> > > + * @init: Optional function pointer for mux-state object initialisation.
> > > + * @exit: Optional function pointer for mux-state object cleanup on release.
> > >   *
> > >   * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
> > >   */
> > > -struct mux_state *devm_mux_state_get(struct device *dev,
> > > -                                    const char *mux_name)
> > > +static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
> > > +                                             bool optional,
> > > +                                             int (*init)(struct mux_state *mstate),
> > > +                                             int (*exit)(struct mux_state *mstate))
> > >  {
> > > -       struct mux_state **ptr, *mstate;
> > > +       struct devm_mux_state_state *devm_state;
> > > +       struct mux_state *mstate;
> > > +       int ret;
> > >
> > > -       ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
> > > -       if (!ptr)
> > > +       devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
> > > +       if (!devm_state)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       mstate = mux_state_get(dev, mux_name);
> > > -       if (IS_ERR(mstate)) {
> > > -               devres_free(ptr);
> > > -               return mstate;
> > > +       mstate = mux_state_get(dev, mux_name, optional);
> > > +       if (IS_ERR_OR_NULL(mstate)) {
> > > +               ret = PTR_ERR(mstate);
> >
> > Should this be PTR_ERR_OR_ZERO?
>
> "mux_state_get() never returns NULL"
> https://lore.kernel.org/202601221036.J0kR78Uw-lkp@intel.com

By looking at the code in mux_state_get() and mux_get() that $subject
patch changes, it intends to add a "bool optional" as in-parameter. If
it's set, it looks like the intent is to allow returning NULL, which
makes sense to me.

Anyway, there seems to be some additional smatch warnings to fix
before this is ready to go.

[...]

Kind regards
Uffe
