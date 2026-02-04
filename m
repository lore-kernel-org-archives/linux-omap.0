Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66B410D23
	for <linux-omap@vger.kernel.org>; Wed,  4 Feb 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214913; cv=pass; b=Rc0PFVCICPyuLFy0sdCKBZvki7W8NheLDmYX/aE1S6l+dIiQbGEQ1trvvccFw6+rB1N5u09NLsXAcR3lvmIxoc/irNgGDXhsXZe1IXxB/fz+t2AAm4bEUriOuiu2a77DWAXKKT6Azmg3bUcQVfdxD6j7uwdATDHmtWBEl7v5XXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214913; c=relaxed/simple;
	bh=psGZzOZbMuFzaU3jqsxMK4GjCf6+fMfPrTbP+wqu1kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4CNURGF0i+RmX/gLCIrZoFHRZghBERC7emqwZlatUIsNHP7e5NQM9DeShI3X/CcRlY8OhlzNuQBrqsxeuO96UrQh3TRBbOGF435Wktmgo2OEQBBtoCTHy66eLp2RZ3zuKLn6Y3BircuR9lmRTOnZE6HYexBaqd49cwt0k+d+W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d9cqv3UO; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9cqv3UO"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59dd9aef51eso1002944e87.2
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2026 06:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770214911; cv=none;
        d=google.com; s=arc-20240605;
        b=bzpzfQivPypDFUFLqS90m1ymLYWDymTFDC5FCA8VIgYc+ZTHkSqoecpo03IUWuNFjP
         p9LP9vZHb2RINfwcox8gyayyI2o/NWsKIGNOT6N3qjIZ4Ae5zXsUd1gNW9zJPG2woemn
         CzxqiGrq0IojmK5KmOMWYI00jKlLAeNbeFPkjRiX83VQe6ybXGvLd+HXjrHWsTMy4vSF
         N7w+axIgq/ctl5Zo2pZ08BQ/A9rdiKzZ0mHTjz2NR1TZmOziv6kyDBbPuEj6ESstUqdv
         o4xduQZ7lwjnHjuhLTHpN0RvybB5CRy97f47UAeI5a/tALLjyVh1ru5TznLeHrHjVuPI
         OwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c5qbJkJQB6xAL7Tc+McFdVmhrNTCwyZzzlaLu/NQwoo=;
        fh=/A438UcBPi38vwnpfUs/94qqdCvEmlSdQdu7HpM+H7c=;
        b=E9ONcs/CSjhR4nkmG4WJqcYA2l1M9uMkqjyAA7Q7dqYPvzeGxYwnXamkPCefcT+CeY
         JSeUKBi+MgU4v+32gMJYTzkA7JUCP7TEk18tnJ1UpK9JMzNQfLR+Dw7/Eved5WQo4eno
         eaHIhreUT3jXOE/kD2bxAfeTmohAOCUy0B7xWQqXwfcjQ1q8lgfkLGbIl4TnC/56mWDq
         iQJJGh19tVqrhPlukb0esBOOVRsZXHGYJms5SePncJqJLX+6HbjXLuaFG570e4z9SPkj
         +b1Y0wO4GSC1wtFbbWTYKhhY0758hJGUjVAu5LHMH6GAVxUxTZUs0uiuppq8SLqjIY5/
         r8Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770214911; x=1770819711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c5qbJkJQB6xAL7Tc+McFdVmhrNTCwyZzzlaLu/NQwoo=;
        b=d9cqv3UOUddhCBCK2ecMAoLuCuoP0pmBNUfVFrBnVXK1UgxnRIbhLpliT+2bDUqlN/
         F+JTYoxSpPi5dLd1OldYmbOeJdGdi7V0VavE321ZLbeeuLDNr57FMs2ZkPA3Q29q7/YH
         1NWKjTZuuFJLpvdMvP2ZDlWRq2sySJ/2dyW5p+dpvSjmq03/VyphhOIDsIppLa71YeJj
         pdQIa6+x9bppJNVnj7syDgwV8IedDGL9hKFR6/pnmZNs2Ry1AS+MQpyw3izENCAqV0gV
         z0O+Aiye8F1R8ufHSXgmetKbg+Qaf7ergN3RdxKBzTxIjp/5xZU5pYR5DRK+w6ESlqSb
         byCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214911; x=1770819711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5qbJkJQB6xAL7Tc+McFdVmhrNTCwyZzzlaLu/NQwoo=;
        b=nbSBMb/MZP9EZQqgtsQytwSdHPbLMqe4BEir+icATM8X1Ar0inMYw7ii6yKso8oFvA
         5OWA9UVc3f/1UcpZ5Ful9JR+WtxZkdbQ58i0Nc8yl0yOtgnMIrVd8yowtNRyHmONmycO
         LVixWlvNKLyn0PBDmlQa2u6EFsGoV1VeP//OtzUdwjTPLyjG/Z8STCJiSVHK/wmaKNgG
         XGdnyxhkrQa6q9IoOUDUtkuzNuzxaPTjcl62QdHXWqv/RLcmAULkzr1Mout58E+3lXnS
         mxlbukAxxPNJ5x0tbFW+ZWGPhjLK6ye6YAGvsb9Mhgd2ld5OwqGu+3jrEgInAhpgNyi2
         B41A==
X-Forwarded-Encrypted: i=1; AJvYcCWf/pR40IQWcp5DOEXQt7h4Xi4YLK/Me2I3JGfFDnhvY9XhQUa7aoSuqCaIkI45wjmRkXh/kbUNpStl@vger.kernel.org
X-Gm-Message-State: AOJu0YyyBEYX89JpOiNmol7hZvsadF8ts5AsmbQHNmSZapq88qQ4U6Eq
	g0dGXDEHfPBUMAu+KjgCvkGWD+D6QRiKi6Ad4gWxQn+j7wnqctthRqscge87fsYqSVlVriTdReB
	1uGsEocqyRIjkqb8GfPHKQTmIJTYxIEK1uR+aGzUqdA==
X-Gm-Gg: AZuq6aKXf9l8iH6YqLD0OuhdpTURYHjZJtDPlOSL//u/UOR/aVyvjhsJfXF9G1HMGuD
	mnzRGs4zNpNpl6fM5UuqWND0zNiXDmQcaLtIMIV6nlGK3mMzUJ/Yi4CZdcvyf33++7e1vAWMOEN
	JaghjJDMMN7+0jAsw5x2sY94htOraSGajfvDuX0vOZ8YWaSWaw+g8q0vYAvYO5FmGiKBM6KngFY
	Ki9soSm9GWRrBpKs2KclpcyACA8vNmP6Co77J/lz9SL+1PqxNN0juj/kSTmHh5+bHgEVsj9
X-Received: by 2002:a05:6512:110d:b0:59e:39af:a70f with SMTP id
 2adb3069b0e04-59e39afa7aamr832564e87.35.1770214911328; Wed, 04 Feb 2026
 06:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-2-024ea405863e@solid-run.com> <e6bccab9-79ce-4b9b-942e-01c504228d7b@solid-run.com>
In-Reply-To: <e6bccab9-79ce-4b9b-942e-01c504228d7b@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 15:21:15 +0100
X-Gm-Features: AZwV_QgpPJOpHagM8bEfHl9m5X84cdk3L263aQ80RGFzSepSmlUAi0xxl4raAF8
Message-ID: <CAPDyKFqONKvPbtLRXKbF6x5RdNpJDCB1R0-7j-Epksva16Y_-Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Josua Mayer <josua@solid-run.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 16:35, Josua Mayer <josua@solid-run.com> wrote:
>
> On 03/02/2026 15:01, Josua Mayer wrote:
> > In-tree phy-can-transceiver driver has already implemented a local
> > version of devm_mux_state_get_optional.
> >
> > The omap-i2c driver gets and selects an optional mux in its probe
> > function without using any helper.
> >
> > Add new helper functions covering both aforementioned use-cases:
> >
> > - mux_control_get_optional:
> >    Get a mux-control if specified in dt, return NULL otherwise.
> > - devm_mux_state_get_optional:
> >    Get a mux-state if specified in dt, return NULL otherwise.
> > - devm_mux_state_get_selected:
> >    Get and select a mux-state specified in dt, return error otherwise.
> > - devm_mux_state_get_optional_selected:
> >    Get and select a mux-state if specified in dt, return error or NULL.
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
> >   drivers/mux/core.c           | 205 ++++++++++++++++++++++++++++++++++++-------
> >   include/linux/mux/consumer.h | 108 ++++++++++++++++++++++-
> >   2 files changed, 278 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> > index a3840fe0995f..2e8295e3aabe 100644
> > --- a/drivers/mux/core.c
> > +++ b/drivers/mux/core.c
> > @@ -46,6 +46,16 @@ static const struct class mux_class = {
> >       .name = "mux",
> >   };
> >
> > +/**
> > + * struct devm_mux_state_state -     Tracks managed resources for mux-state objects.
> > + * @mstate:                          Pointer to a mux state.
> > + * @exit:                            An optional callback to execute before free.
> > + */
> > +struct devm_mux_state_state {
> > +     struct mux_state *mstate;
> > +     int (*exit)(struct mux_state *mstate);
> > +};
> > +
> >   static DEFINE_IDA(mux_ida);
> >
> >   static int __init mux_init(void)
> > @@ -516,17 +526,19 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
> >       return dev ? to_mux_chip(dev) : NULL;
> >   }
> >
> > -/*
> > +/**
> >    * mux_get() - Get the mux-control for a device.
> >    * @dev: The device that needs a mux-control.
> >    * @mux_name: The name identifying the mux-control.
> >    * @state: Pointer to where the requested state is returned, or NULL when
> >    *         the required multiplexer states are handled by other means.
> > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> >    *
> > - * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
> > + * Return: Pointer to the mux-control on success, an ERR_PTR with a negative errno on error,
> > + * or NULL if optional is true and mux doesn't exist.
> >    */
> >   static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> > -                                unsigned int *state)
> > +                                unsigned int *state, bool optional)
> >   {
> >       struct device_node *np = dev->of_node;
> >       struct of_phandle_args args;
> > @@ -542,7 +554,9 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> >               else
> >                       index = of_property_match_string(np, "mux-control-names",
> >                                                        mux_name);
> > -             if (index < 0) {
> > +             if (index < 0 && optional) {
> > +                     return NULL;
> > +             } else if (index < 0) {
> >                       dev_err(dev, "mux controller '%s' not found\n",
> >                               mux_name);
> >                       return ERR_PTR(index);
> > @@ -558,8 +572,12 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> >                                                "mux-controls", "#mux-control-cells",
> >                                                index, &args);
> >       if (ret) {
> > +             if (optional && ret == -ENOENT)
> > +                     return NULL;
> > +
> >               dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
> > -                     np, state ? "state" : "control", mux_name ?: "", index);
> > +                     np, state ? "state" : "control",
> > +                     mux_name ?: "", index);
> >               return ERR_PTR(ret);
> >       }
> >
> > @@ -617,10 +635,28 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> >    */
> >   struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> >   {
> > -     return mux_get(dev, mux_name, NULL);
> > +     struct mux_control *mux = mux_get(dev, mux_name, NULL, false);
> > +
> > +     if (!mux)
> > +             return ERR_PTR(-ENOENT);
> > +
> > +     return mux;
> >   }
> >   EXPORT_SYMBOL_GPL(mux_control_get);
> >
> > +/**
> > + * mux_control_get_optional() - Get the optional mux-control for a device.
> > + * @dev: The device that needs a mux-control.
> > + * @mux_name: The name identifying the mux-control.
> > + *
> > + * Return: A pointer to the mux-control, an ERR_PTR with a negative errno.
>   * Return: Pointer to the mux-state on success, an ERR_PTR with a
> negative errno on error,
>   * or NULL if mux doesn't exist.
>
> If there will be v9, I shall change this to be more precise similar to
> other functions.

The series looks good to me!

I can queue the series for v7.0 via my mmc tree and amend the change
according to above when applying, but I need the ack from Wolfram on
the i2c patch (patch5) first.

If this doesn't make it for v7.0, I suggest you re-spin a v9 after the
merge window.

Kind regards
Uffe



> > + */
> > +struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
> > +{
> > +     return mux_get(dev, mux_name, NULL, true);
> > +}
> > +EXPORT_SYMBOL_GPL(mux_control_get_optional);
> > +
> >   /**
> >    * mux_control_put() - Put away the mux-control for good.
> >    * @mux: The mux-control to put away.
> > @@ -657,10 +693,13 @@ struct mux_control *devm_mux_control_get(struct device *dev,
> >       if (!ptr)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     mux = mux_control_get(dev, mux_name);
> > +     mux = mux_get(dev, mux_name, NULL, false);
> >       if (IS_ERR(mux)) {
> >               devres_free(ptr);
> >               return mux;
> > +     } else if (!mux) {
> > +             devres_free(ptr);
> > +             return ERR_PTR(-ENOENT);
> >       }
> >
> >       *ptr = mux;
> > @@ -670,14 +709,16 @@ struct mux_control *devm_mux_control_get(struct device *dev,
> >   }
> >   EXPORT_SYMBOL_GPL(devm_mux_control_get);
> >
> > -/*
> > +/**
> >    * mux_state_get() - Get the mux-state for a device.
> >    * @dev: The device that needs a mux-state.
> >    * @mux_name: The name identifying the mux-state.
> > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> >    *
> > - * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
> > + * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
> > + * or NULL if optional is true and mux doesn't exist.
> >    */
> > -static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
> > +static struct mux_state *mux_state_get(struct device *dev, const char *mux_name, bool optional)
> >   {
> >       struct mux_state *mstate;
> >
> ...
