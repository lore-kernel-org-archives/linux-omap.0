Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793787336;
	b=X3N5swYxjU71TQ8N0Z9TKyDwZjhETOKavxEx7jtRZKcKBDHjPz1a3CGc0Q8P2ckdnyyq
	 O6IrfStGYybFRwZeu2+pcrw5LrbxQIEsoEh0AouTtkyj9AmORK8+y4anSDycSDaSS6nKz
	 tKtKAqVFOW9RtA3UphcLPgo8MYrOfc3EYn60coYodVoezn6Maoe6PQ/jSbY2CJnyTGSAj
	 jQVHtUO/DLylXfZ14aOdnQ3umhjOTTGqlvkLvmq4IVltL6sRqCnOAtOG+TNcLN9SkI/rm
	 3+PDMQK0uGOaGIPw6iSyUfKY3dTxdcfqB6W+4zmts4WXId7ZTHvc0QqLg7nWqRA1GAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GeAVtba64Qwv71o9CiCo+TFgxn75Fuo5tCC+2rZXz+U=;
	b=FE+PCMAD2W9nn6SFR1Hmi+fYPP0x2X/4Tt7pNXHYSdeZ35xL8mAuUjT4gMFcXqRr4IT4
	 hzcfIeYhm3jtkua3KAQLX7wXk7QSVgkqEE+S7k45D/p8wMzbKI65HVjyDqwl1RQ5b8Yo9
	 1dKsQBuSw8p/6tR5NdzfaxD4cAOcxo/rvjdYjWhnQS0vl+4H6Y+GmBBP8qeAY+jXd8j+8
	 wVfDHC2YFqMiA6yBxFMdD1/tGmziM8RuaBmbQ24TvhLmxGgrIiOHtQwPMT+f9S52/ikaD
	 zrruJWMq3jqU5rjiZUWhXTaqHT7J42J12o3gEfUTIeiR54a9gDTHEO1K6Kxqb9AhqOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CsW3eM3q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6475606A326
	for <linux-omap@vger.kernel.org>; Wed,  4 Nov 2026 10:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6475606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CsW3eM3q
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-676804a3a22so534582d50.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2026 02:15:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793787335; cv=none;
        d=google.com; s=arc-20260327;
        b=hNiJKzW3ku/UcTcmIUqQXoHduEgJfEgqMl/oyz99sc09NjwOjjF/pcojb6UsE1oTx/
         1PyYae7QAnGc6Wnu1t/dzutOIYlw0k49FKHtUcpXCU6OPuLvwGvbcKj2uzdyR/50k5IH
         jpjxnCQkDd2RWkl7/Xn/6vPI9wiNTPIgzxSd3HosF5emad+Rk52v3+58M6ajv0MHglP0
         oKuWWiafVwj3vwAWmK/fGhOiGydUOuZiHMIsBHI3285abLoe/e2rWpOOeUzzZoUIaUOV
         HndxJ3i8eqil4q98gR0FhBDhELElEFgC0gRXxFvD5uT7GW80ThnzJlHPMscnm8YTjgf9
         zr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GeAVtba64Qwv71o9CiCo+TFgxn75Fuo5tCC+2rZXz+U=;
        fh=d3JktB2I1sFJCKi40ZisZF2nHtFXhbeUzo3pHxDGTTs=;
        b=in5ZsfzudJP3XzyUkavv82hNVa/8XAGgD2cPSn4HQKHqdebl+wOm04BCUtO4uEaTMV
         8q1ruAoUDlHOqELevAM80GqyskWW3Jl0BtKjhO2K3nAm3wPdAkJt8kN6G348eZNBhrm7
         pV4/qVsONvAlGuRYRTOn5LbO3tCKoGoLeGmO/nIFJUJPoqg260/juCXUa4qk2XDN6cba
         E+OtXCzjjfAEFsiZV/pBIVmdQxYelqhA3KoEAunfQqO5M0xIqypTFzK23KxOIyx8tukW
         EDxGrH2spqKapUxqKJ0fBXMjC/TL1diRMYaNzh6WUXSXEk8PK/PiZHs/254WhQ0uJ5gp
         0yNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793787335; x=1794392135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GeAVtba64Qwv71o9CiCo+TFgxn75Fuo5tCC+2rZXz+U=;
        b=CsW3eM3q+zrDVPeiuScolojFCOCYBWgyo4clxbjKxraJ46mUtejaySprZYxuQFfDiK
         BWIHUXQxMEXycsc0m29HMmGfjhzeSwHbsZ9ul0adZrdff4Jua8v/NQ+ILnzPDu0hgAuA
         oVpQR+rgVMvln+aBlcXumRF6WMOEyHlEtHmG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787335; x=1794392135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GeAVtba64Qwv71o9CiCo+TFgxn75Fuo5tCC+2rZXz+U=;
        b=x4hhhjusJoo8wnvjwphBRm3DQzEDkhWU83gpAuU15RYjIzVvOYGL0BZ+wrmgtXTUJM
         Syi5VdPY13tTtrsO8iUUFqsVnX6CkQTPMuqjjESz5osBmFAjQt3+GZw/B2sU1NRiuRdI
         P6fpZbEPVXTnRkeF9JMK0XdlfhBF940kiqC1v9XSAWzFkRGI1I4eLfNg4D1cBOhgtiOB
         xnmBhCkZQy/EtzOzm8wBsLTJ0lN+S7X8G5AxJQ5i7vzzNZ/Anc3gO5tRk2bZ0GWLhBS3
         Ne7ACokS7642mRKoihfs3Ebxb07vg4vjJPpAn+YDNNF0L4aludn0PMl9VErd5UsnGnxa
         BHzg==
X-Forwarded-Encrypted: i=1; AKwUvBwp5wJswM2Jh8VUi/NwuuZVXSQzLljcKWpyk/NPKIPBj0xucvl+LNunoIuopAeS9RB2rlME6sTDYiDa@vger.kernel.org
X-Gm-Message-State: APuU4Z9QFGb8fkUHo4yiQjRLTdvDUnWvDBOvKtdzLzAvzBFWxs3afCWy
	aSYCwxS0Fk8Q2a9MB7VfQDSRxlgeq2fgdkA5eKKvsvBtGFaTToW4nDBZdM1b45WxOohTEpiE4Zh
	7/0nKODoYDw7NOcDbE1/WLN9yirUtOIIDmrjxruUVSQ==
X-Gm-Gg: AYBFou2W7OUqhAeOaGe5Qk9YCBmstbJbZd6pcID1h43YYqBORnfpVGF6hJZ6M8kdnro
	qtoAB3LW7oSGyyrS74hp7XKKiUWOfAGM55mL8do9QJialkRsPZuUYOCr5BET1FuyBnJCYCHxgQA
	hokM8jHtmPyA+bqs0YKSOUA7BpxJbnmVl4gJ3qohJQGtVwa959ypPFns8wEJDU5pQhqyMQw+PZh
	BOPUduo3zQaxDr4hz9w2iH+KNN6YmLpM7HlrqOkgc4HtBFooRytC4lM5I5XFqNdg9Is2zzzx66u
	svne0eZu5tRubuPJc+PrZ+CEaPipP7hJFme8BHvSuduj/OLl6c7RNrUH8VWfWkwq+N1smudNTYH
	oiiCXYzx+22Oy2/f73B3nQiBZK5Z4j5pUvodQ4VuZxZr9hdhJNkjirR8NBvz3oFCarApM
X-Received: by 2002:a05:690e:408d:b0:679:8fa4:4661 with SMTP id
 956f58d0204a3-67ba508cacfmr13916977d50.82.1793787334695; Wed, 04 Nov 2026
 02:15:34 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028074436.1958132-1-dario.binacchi@amarulasolutions.com>
 <20261028074436.1958132-4-dario.binacchi@amarulasolutions.com> <179373624826.588706.3689544002135897133.b4-review@b4>
In-Reply-To: <179373624826.588706.3689544002135897133.b4-review@b4>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Wed, 4 Nov 2026 11:15:23 +0100
X-Gm-Features: AclHuK8nB_6aYSJgmHxc-dj0dbCRTwWxpOXswi7917sdDsYuWtlywfCGGeD2VAI
Message-ID: <CABGWkvqcOn5mvfe5G060ntDgzdr=kacDcEvo-e+Oyzs6F95Xzw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] clk: ti: dpll: apply the spread spectrum
 configuration right away
To: Brian Masney <masneyb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	michael@amarulasolutions.com, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

Sorry for the noise, resending as plain text since my previous reply
was rejected by the mailing lists.

On Tue, Nov 3, 2026 at 9:04=E2=80=AFPM Brian Masney <masneyb@kernel.org> wr=
ote:
>
> Hi Dario,
>
> > The spread spectrum clocking (SSC) registers are only programmed by
> > set_rate(), which the clock core skips when the requested rate is
> > already the current one, e.g. when the bootloader has set it up.
> > As a result, the SSC configuration is not applied, as it was with the
> > vendor specific properties.
> >
> > Apply it from set_spread_spectrum() instead, reprogramming the DPLL
> > at its current rate.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> > Changes in v3:
> > - Skip reprogramming only if the configuration is already applied
> >   to the hardware
> >
> > Changes in v2:
> > - Check the DPLL lock state instead of its parent, as the reference
> >   and bypass clocks can be the same clock
> >
> >  drivers/clk/ti/dpll3xxx.c | 49 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 43 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
> > index 634fe0a1f9fd..d32d81a27bfe 100644
> > --- a/drivers/clk/ti/dpll3xxx.c
> > +++ b/drivers/clk/ti/dpll3xxx.c
> > @@ -690,17 +690,22 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw=
, unsigned long rate,
> >   * @hw: pointer to the clock to set the spread spectrum configuration =
for
> >   * @ss_conf: spread spectrum configuration
> >   *
> > - * Stores the spread spectrum clocking (SSC) configuration of the DPLL=
. The
> > - * configuration is programmed along with the DPLL multiplier and divi=
der
> > - * at the next rate change. The hardware supports center-spread and
> > - * down-spread only. Returns 0 on success, or a negative error value o=
n
> > - * failure.
> > + * Stores the spread spectrum clocking (SSC) configuration of the DPLL=
 and,
> > + * if the DPLL is locked, reprograms it at its current rate to apply i=
t.
> > + * Otherwise the configuration is applied at the next rate change. The
> > + * hardware supports center-spread and down-spread only. Returns 0 on
> > + * success, negative error value otherwise.
> >   */
> >  int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
> >                                          const struct clk_spread_spectr=
um *ss_conf)
> >  {
> >       struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
> >       struct dpll_data *dd =3D clk->dpll_data;
> > +     struct clk_spread_spectrum old_conf;
> > +     struct clk_rate_request req;
> > +     unsigned long rate;
> > +     int ret;
> > +     u32 ctrl;
> >
> >       if (!dd || !dd->ssc_enable_mask)
> >               return -EOPNOTSUPP;
> > @@ -718,9 +723,41 @@ int omap3_noncore_dpll_set_spread_spectrum(struct =
clk_hw *hw,
> >               return -EINVAL;
> >       }
> >
> > +     ctrl =3D ti_clk_ll_ops->clk_readl(&dd->control_reg);
> > +
> > +     /* Already applied */
> > +     if (!memcmp(ss_conf, &dd->ssc_conf, sizeof(*ss_conf)) &&
> > +         !!(ctrl & dd->ssc_enable_mask) =3D=3D (ss_conf->method !=3D C=
LK_SPREAD_NO))
>
> The =3D=3D on this last line has me a little confused right now. Should t=
his
> be an && instead?

The =3D=3D is intended. I agree it is not easy to read, so in v4 I will
split the check into the disabled and enabled cases.

Thanks and regards,
Dario

>
> Brian
>
> --
> Brian Masney <masneyb@kernel.org>



--=20
Dario Binacchi
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
