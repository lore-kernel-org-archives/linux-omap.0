Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119247;
	b=IjHo1cIz4Y8p20iMn8Rqzd/GHBMCf/9iAMSkdzWsoN7cb/ZAosqtrt8C3uuTCwhqenTo
	 syOhABJGUxGJIYEwyHqEz2hRC5/EywMBRAoB+bS5969CaC8Lq7ly2WRi3wKzsi52o8G6U
	 2s7pu/aNvwub5qVGXT4MrS834rzDkUZSEbuqw8Um0JTLQ3+VRMRfVxhA2duO8mRpQJlyj
	 +unfUdLxplCHCosNg1k0Z1xTzIi/ddZZkTTDF4EpCowVwR/vdTpuzJR8ZWZ+NzTsejTzl
	 d88DPaeN6xwUSO4nE71rc5uyYTeAyG/LcCqthhcCQP1bsgSXmq8IwYVcJxXYjYSaa8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=G64J3My5E4LHAZytVY99BN0a3iynkD/Y4fMqy8a7CDc=;
	b=2q0eVbdxMwNr3TWG+rcvMUddp0gcAwYqaILYV0Z9pV4rJgAgai6zCkA3i1JYHp8uZmRn
	 QPPcWgLY1ARt9mXZN4weYLmr320tzV7tSDkHLWtt+IkDhozfiEBZ1PwL+V/+al4XcZ8d0
	 V17zRLAZGAnLAzuVf9yNFwjPZnCp3uXDZLxb0maaQXR6cjmf664h/V9wVqFztMvDqnu/L
	 TRacMUOgEwaF/LyAKSkjoIW3hEW7Mvo8GBjNRxcJhw4nZfS7UBAfyb3u1hg3jNgBy9DCF
	 s0em2nQYGkeV46TuApv9GTKWfZ3Iv1IYbzDNMXn/aCuoWGWrZWwy+kHjcx8uQlulISQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ihnwKcxC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021E606A31A
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 16:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A021E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ihnwKcxC
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-679a420b5afso45692d50.3
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 09:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793119246; cv=none;
        d=google.com; s=arc-20260327;
        b=qujZulnyWVsVJEc+SP0SS1jnzSCI6loN1DVr7e8R3nySCHskDvLM3oIYbglJrT5mCs
         MeYx5CQE2JBgn+oKy/FDFtIKFzLi1W7yNW3Gx9NYhGOav3EvpNAWaLu2f6wSCxsmC2Qg
         EnITNYBdAXgzgOI5lFvsi0kmnKLin+Pl5hqOfIBvoqIsqigOV7SZ9BXNOXfNh8RFVVmk
         V0zqTEvy2eWP3iFxtQAo2GOVHdIuAtw0TdpFRaT3AdiM+PEhjYQYAwVONHe8RVnK2yRp
         8+1YP7TiwT2w89f0zOgHcELBV4iFBEWTpnlwRJdYz5BZ/onaFr0dXNpCPq6Fs1We4O/O
         uOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G64J3My5E4LHAZytVY99BN0a3iynkD/Y4fMqy8a7CDc=;
        fh=2iN9XWU86l990rgdluZo1r7gZutjR6Js4uY+yCrvS0w=;
        b=D5luAqriIw5wRmP+zR74DR5ZN/ksGkV0JDnY5nyS9oL4zuASH5wY1TvvXfHpANmlE8
         fYngiaEahy/MbiNplE4c9Kb3pOQl1wa2tY7ceUMO2GitilrjeOWjf25IA0mKcSatNfV2
         cMRqwmXCn+NQsWTHKG1/WkpZMvWg0eZbmP/4d9ZhV78GKTDQDXLLzF/4ruCemssZBfbA
         lhH5GdGo4P3dzbphvDBdKqZUKYexIRGpVKr74JF69Tkd1E8gDBhpYtG4zGH5QV4QN3Ys
         grVWAuguiOkVI76rDvUlcZfO3GIaKVq88JAfrJ3m+zGU0vNn/XJhWpjbJfqyi2derzb7
         qBTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119246; x=1793724046; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G64J3My5E4LHAZytVY99BN0a3iynkD/Y4fMqy8a7CDc=;
        b=ihnwKcxCTJLEgMsjfIVumhb6S0IfEmdzQwZEYEoTXBg7l0yUs2viibcjKq+iTQidF7
         O8BcOsQKRMPh7AN3jfl0F2oF53nmB+3HME49sCtOa+NCR0k5I/pOikZg5PMEAHF1m5MB
         DsCDOtERRjqVO7qZcevvzlSuJm/9UMMioLJ0KaULaLQz73rO6imX9JcHOV9Kl6pzy2RA
         vwgi5QTkqwNg+tR1HhAf3J5jZH4PXC0cjj9FxDdmzqllqgoik6ahJ+uvCoP+kNlazJwQ
         43GMbCFUXNmWl7PDNmflZTBVJ0V0UCzZnEa7ewGeG8IsKFI4VvRs3TA3PDS38FpaVmBp
         Cf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119246; x=1793724046;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G64J3My5E4LHAZytVY99BN0a3iynkD/Y4fMqy8a7CDc=;
        b=K95XD5C09gy6Yw5/p9X3ZWiXZjECp2qax+wStXcVuQ9QfJBI1Rh0g+D3X9keEEuE6W
         2nKkcjpswAx5009Aptda4cwBcUrdqVYnknzMvWqjfTksDMs13bq7iKjIIflwr5atHrUe
         XMzJ9r7svGqVbt5QB2xCKIjPn/j2okJQpq1WQgZSmEWRFZfMgq8b4RBHLqvb9eAk5mDj
         4DrIxmilisD6QxJUTA3InJNirUa9KTiPrMBskos656fv+D1abj8Cu3gAheC5wHtmQco0
         frOwMDGMu3777J9yqaarP1KkmYXYxBSav8RaMq+w8FcXgej8I9qb40lb2IDXJKwiGpaU
         GaHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPzguynCyPjwp5mwE65PjrBpVdCO8UTw2MxLQTf7mGzRRpTSet2y3Fr/dq3nlVDzZlY0EONbi7S8aJ@vger.kernel.org
X-Gm-Message-State: AFq9FYJjTyDymrYvfjYIEUKFdNedP0dmXl1Z9CkDBnNG0dSRpJv/2mg1
	0VBuZe+Bphkz1HpLITfiTQ5xaJeo+1261rxM7CABQMiZXm81Zu5cJnk2HmZtxvzWseK4xwfcUAs
	0oZR2x529ymstXrY79C8dPUwM9lSDORQ=
X-Gm-Gg: AYBFou2GQqR6QXWtlWmSif65OlOkejZLSdlxURDcdM12xkfHwR5UT+3t1nf66gU2apd
	kfyqgtxKC2ICFSAepP2GfMCKP5bFrf5QU0j08yZY7Cpl7KHKKY/D8wckgu/QgQmb4HhfMhZdCRc
	ujgaSzl4fuZmoNSnFvv6gHOp7iA44TU2OLv0UgQNtcuEEufleMUdJ+H8Nv6Q0fAr7GvPclu4ncG
	O5il5Ouz8SWsWJO1XZjnGDynOW9vVcWDn0Jx1g3nZCFYxyw42bp7dKV2nrbFqmLvxiVahrFAptx
	F8lGaENHgpFoNlQHKsgFdt5gcRJEq4Di6pV9HlbCbDdtfMn7teZnW0K6azIhZvCbzX3nujRYKVa
	HspUilkeDyXD37pjy9L+qnC/lH2twIvqFgK2L
X-Received: by 2002:a05:690e:21c9:b0:678:151:5218 with SMTP id
 956f58d0204a3-67a7bd81c3cmr32130d50.110.1793119245748; Tue, 27 Oct 2026
 09:40:45 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027032609.119226-1-lgs201920130244@gmail.com> <179310015976.2808517.13064510476219400398@kernel.org>
In-Reply-To: <179310015976.2808517.13064510476219400398@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:40:33 +0800
X-Gm-Features: AclHuK8AK6dZaz6wgjS33W_jF3KCjGoJH6NgyB5biX1dQWpffjnyXhNOXiRNnyU
Message-ID: <CANUHTR8Ypwpm+Qqmk-fob1=e040rRH5QGTs7gN6MWRKQYyOdCw@mail.gmail.com>
Subject: Re: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, 
	Samuel Ortiz <sameo@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
	linux-omap@vger.kernel.org, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lee,

On Wed, 28 Oct 2026 at 00:26, Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 27 Oct 2026, Guangshuo Li wrote:
>
> > twl6040_remove() currently removes the regmap IRQ chip before
> > removing the MFD child devices. This destroys the IRQ mappings
> > before the child drivers can release their interrupt handlers.
> >
> > The parent driver also registers READY and thermal interrupt
> > handlers using devm_request_threaded_irq(). These handlers are
> > normally released by device-managed cleanup after remove returns,
> > when the corresponding IRQ descriptors have already been removed.
> >
> > Consequently, free_irq() cannot find the IRQ descriptors and the
> > allocated struct irqaction objects are not freed. The associated
> > IRQ threads also cannot be stopped through the normal cleanup path.
> >
> > The probe error paths have a similar issue, as they destroy the IRQ
> > chip before the device-managed IRQ handlers are released.
> >
> > Remove the MFD child devices first, then explicitly free the
> > parent's READY and thermal IRQ handlers using devm_free_irq()
> > before removing the regmap IRQ chip.
> >
> > Also update the probe error paths to release successfully requested
> > IRQs before destroying their mappings.
> >
> > This issue was found by our static analysis tool under development.
> >
> > Fixes: ab7edb149c75 ("mfd: twl6040: Convert to use regmap_irq")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/mfd/twl6040.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> > index 562a0f939f6e..7b05d21cd17d 100644
> > --- a/drivers/mfd/twl6040.c
> > +++ b/drivers/mfd/twl6040.c
> > @@ -745,7 +745,7 @@ static int twl6040_probe(struct i2c_client *client)
> >                                       "twl6040_irq_th", twl6040);
> >       if (ret) {
> >               dev_err(twl6040->dev, "Thermal IRQ request failed: %d\n", ret);
> > -             goto readyirq_err;
> > +             goto thirq_err;
> >       }
> >
> >       /*
> > @@ -791,10 +791,14 @@ static int twl6040_probe(struct i2c_client *client)
> >       ret = mfd_add_devices(&client->dev, -1, twl6040->cells, children,
> >                             NULL, 0, NULL);
> >       if (ret)
> > -             goto readyirq_err;
> > +             goto mfd_err;
> >
> >       return 0;
> >
> > +mfd_err:
> > +     devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
> > +thirq_err:
> > +     devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
> >  readyirq_err:
> >       regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
> >  gpio_err:
> > @@ -809,9 +813,10 @@ static void twl6040_remove(struct i2c_client *client)
> >       if (twl6040->power_count)
> >               twl6040_power(twl6040, 0);
> >
> > -     regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
> > -
> >       mfd_remove_devices(&client->dev);
> > +     devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
> > +     devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
> > +     regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
>
> Why not use more devm_*() handlers?
>
> devm_regmap_add_irq_chip()
>
> devm_free* eeks me out.  The point of devm_*() is that it's managed.
>
> >       regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
> >  }
> > --
> > 2.43.0
> >
>
> --
> Lee Jones

Thanks for your suggestion. I'll look into using devm_*() APIs in v2.

Would you prefer that I submit the twl6040 and hi655x-pmic fixes as a
single patch series in v2, or separately?

Best regards,
Guangshuo Li
