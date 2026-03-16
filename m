Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDB33A708
	for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682872; cv=none; b=bsoBfCWC8Rw8s1QAWZ/oaDCV62ldKnIgd6RQfrSBGSCDHOiSIrfCbn6Nvd9UlxjUuKLq6YzmxkNWQUGpDbWv08b41uqu2CWO5yRAaMNGHVbZrH1gKSMcq/xZoC+WjYdsEyLdh7ax4ptiWD7O/bgLg89+i8c2/0J/MQyxYRpeqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682872; c=relaxed/simple;
	bh=jtNqYoU+2H2cM7UyoKExEBfiqQZsN1aAAmOPkoFbFyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i8q7yA/fLJy0Z8rLuvqyhl7pVezOE71Np6Jy+VExL2q4C2+S6/7VKvh9emo6em60I4USJ2rncIPU3InfaiWXfOXpzLERzWGpEMtG+u+jpeLJpEN/Xr3Bk3lDNI794TKAM2H1XUS5LErYSCnLM6jn30hyPlIoAvBGXWaEN4X4mr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVO8RWdh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVO8RWdh"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so39799845e9.0
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682870; x=1774287670; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jtNqYoU+2H2cM7UyoKExEBfiqQZsN1aAAmOPkoFbFyg=;
        b=kVO8RWdhz3LUyZfrWpDIw0iUV0Uj/H9h1TubGlwb2SETsEZND9tNQos2hxDqOfChoJ
         2l7vmGNjuz3GaRItqgwo9e9GEmL5T2Hlnc0IKscP2XDpdR6J/5vId//u3vYsxm6NHP8z
         56mOQBOD7B5vcZOjiwPFl8/HGBM5Dzxs/1cy+j7lDL+7uexTJ0XfII4m8pMcjDlntuDf
         oaPYsRhu5jlKSGKcp0zzJYuidXRZODI0E91RW7CmvLrBmnbbOFdA18DwSV6wpVLgRduf
         zNR1BBm2m4tGjI7ikofDgcE/reXQPdgDEeYkUI/694ASTUJztygF/AY8QRzlkBCRdpuR
         vqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682870; x=1774287670;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtNqYoU+2H2cM7UyoKExEBfiqQZsN1aAAmOPkoFbFyg=;
        b=e4gAImWdbBHAaIjNHTD9fn1yBDDgLF/2F2rqWdDmDDtMG75wzElYfUaYoWSXPbYblX
         g6+E2sVf4Aq2A4bDUwq1ISozU3ZNWABN8n2jwvZq7FshDy6jtilMSqgRjdLenXcF10A2
         vKt8aqEEnbm/pIjkjqH/Ul4Sox/XgJ1eHNc7h3obqAg5LpDtixu5/9eHez1MIknVHy93
         LR9yt8YtH4+OXdNUzazch7C0p2JObQn862aoo8IoCni8IXRHblPZl9rfcp3YuNwvo5Nk
         bnMtI0EHeumUHSlkRUpcNvcepi//+1CEkW/6SyN4kc28J+epYeW30W35w/10351VGPzk
         OTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJu4TF3rNgKo7vVbwKpxZLdL2dCswkRPDpcmihW1vahips75IRMsf2z8d4GiTD3Nd52pzDdVs+6Yol@vger.kernel.org
X-Gm-Message-State: AOJu0YwdWApKh8OBnsTUMpUSmyprSKhYdT1u7S0c4AlP+Cr7QiVzTv/d
	D+33nhivbrkrbFy5tn5b6Q3SEjIHSgKLYS9A27QIHsRePL5Kl2wWQqBM
X-Gm-Gg: ATEYQzx/TT9UXI6toLQqTgwL3FeMHjHL7fGNjIu8Yf5S1Z18+YonNyaVUB+gsuQQE4/
	xHOUAInM/4VIIRr9B9FGiLCdFZ9MnnBYm9ztYcMmkv1pUIB0ZrexfAFYlrYVnnPR7/iJngn7876
	8Su8hSyy4Yy1MwnkdanTn2bhfVJdZavGYpMmk4deMEscG+cIDXQM9ttX/mzeBxssPauq2A8nVbt
	kc2hv2iFwbX6WyUfzPgQDJRcikdaT6ztLrKjUTwtZZ3hcWPhdl34lNr0blOdzb1iuXBznO/pYOD
	51L1NTgBfT4QT7k57j5f0RFw9pzWEbKTeRcOlXtCDd6eZKMx1hMhATq9HpzzeTvY1PbxQdVwZEd
	m3HziVXcnB7EMiEQpoIsG/btRUVc092AnxlNP4onieRuJWqw1NGizTBMtgMDdtgm8xR63+8FCwH
	FcmEF00CR5EATMRh4Brt2oWqnBeGE+EAc0NkPbO8bXUN7u6vzWVz+gpLUuZ0cuQrFOU20N4U5l7
	90YOSg=
X-Received: by 2002:a05:600c:c0d1:20b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-485570ce1cfmr171983085e9.4.1773682869870;
        Mon, 16 Mar 2026 10:41:09 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856e850634sm14960175e9.0.2026.03.16.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:41:09 -0700 (PDT)
Message-ID: <50002e822278e6474dfd1ea37f22aad1c27003cd.camel@gmail.com>
Subject: Re: tps65219/am62p kernel oops
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>, Francesco Dolcini
	 <francesco@dolcini.it>
Cc: Andreas Kemnade <andreas@kemnade.info>, Jerome Neanne
 <jneanne@baylibre.com>,  Nishanth Menon	 <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 16 Mar 2026 18:41:31 +0100
In-Reply-To: <d6de7066-a802-41fc-bb10-2f5d248743db@ti.com>
References: <aBDSTxALaOc-PD7X@gaggiata.pivistrello.it>
	 <20250429185240.6a7644bf@akair> <20250430080109.GA65078@francesco-nb>
	 <aBH5s7p2RxLGjTQD@gaggiata.pivistrello.it>
	 <23eeda43-a938-4c15-aee3-b1b9df217ff8@ti.com>
	 <20251209134343.GA238880@francesco-nb>
	 <d6de7066-a802-41fc-bb10-2f5d248743db@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Shree,

On Tue, 2025-12-09 at 12:16 -0600, Shree Ramamoorthy wrote:
> > > > > > > while working on adding support in mainline for a new board b=
ased on TI
> > > > > > > AM62P SoC I noticed the following Kernel Oops.
> > > > > > >=20
> > > > > > > This oops was reproduced running current Linux
> > > > > > > master, 6.15.0-rc4+, ca91b9500108d4cf083a635c2e11c884d5dd20ea=
, but I was able
> > > > > > > to reproduce the same with 6.14.4.
> > > > > > >=20
> > > > > > [...]
> > > > > > > [=C2=A0 +0.000022] Call trace:
> > > > > > > [=C2=A0 +0.000011]=C2=A0 regulator_notifier_call_chain+0x20/0=
xa4 (P)
> > > > > > > [=C2=A0 +0.000018]=C2=A0 tps65219_regulator_irq_handler+0x34/=
0x80
> > > > > > wild guessing: maybe because irqdata->rdev is not initalized in
> > > > > > _probe()? At least I do not see where it would be initialized.
> > > > > your wild guess seems correct, I'll send a proper patch with your
> > > > > suggested-by after doing a couple of more tests, thanks.
> > > > so, the bug is clear, however the fix is not an obvious one liner a=
s I was
> > > > wishing.
> > > >=20
> > > > we would need to add a link from each of the interrupts to the spec=
ific
> > > > regulator. as of now such a connection is not existing in the code.
> > > I'll try out implementing and testing the solution, but will get to i=
t early next week. Will email with any updates!
> > What's the status on this? Were you able to do any progress or work on
> > it?
> >=20
> > Thanks
> > Francesco
>=20
> Thanks for following up on this, the task got lost on my end. My apologie=
s!
> The original line deleted `irq_data[i].rdev =3D rdev;` was never replaced=
.
> The correct code should be re-implementing a version of the tps65219_get_=
rdev_by_name() function that was removed in commit 64a6b57
> & add in irq_data.rdev =3D rdev;` where the other irq_data fields are bei=
ng assigned within _probe.
>=20
> Is there anything missing with this solution?

Thanks for looking into this issue!

I would be happy to test your patch, but cannot find it.
Have you published it in the meanwhile?

Regards,
--=20
Alexander Sverdlin.
