Received: from mail-ej2-f29.google.com (mail-ej2-f29.google.com [74.125.228.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7194A43E0
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264837; cv=pass; b=osHq6R7Jem6z3gPW9qGkYX4P7VOaXr4U7WCv8ZzcFORjfiwBbYqs/6O79gyzaUJRMKGeo0e35X8xjtaX20YLNsXWvC3lbI19BfuTyboHqygE5ld7pTA8TlvJxU+f+gUqVw8tW6a6Zs5Qr0DjxtCXfYk2TXwczMVb2hkTI5WswHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264837; c=relaxed/simple;
	bh=ngFJLjCIxCAeT7eexOCKSDLrNT1g5/NSYXpxJa6UjHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjDDWHjQvWd/cHQHAN+ui7QnOrgOOk6URlkxi+TmMMS46nvvxCKADV+94fHUL9IBxuYyrDc68sdwyV4gz1UKrQ3WX5mV0YMqkkX+xL7KEzJhbo1qpwRQyDH6Em6cGpHx9QEB2GdwBdG6mVXeTF0BcOu9K9rVA/anHYMJW/cUAxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7gK6hFH; arc=pass smtp.client-ip=74.125.228.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7gK6hFH"
Received: by mail-ej2-f29.google.com with SMTP id a640c23a62f3a-c294496989aso285073866b.3
        for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2026 08:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790264833; cv=none;
        d=google.com; s=arc-20260327;
        b=JpE/Pd5DySl5WrTrlg3ZimUJhUP5qQo8zKEFFXdRWnx0iTCh7RVRDX/R9ki5XGN1vt
         5PWNycmsms/+p/hOPU/WpCsXlP0ni2rIjauv7v1PH/kNza7B/Byi4lPB3+pHEaGwtd6f
         qRuOyjI1adlllp79XdPtd8r6ZLfson30QAqW40rJ2BzE/t09/1LUvhm1GKVgCq7bFNaV
         7u/irZRJyE3JPwRl8z5eZFrQQgGdqEwvupKcB+IvE9FP537vjg9qjS5aN9gAkQigfkGc
         clULTXuXN9twkd+lJAkOfa7bMcGA69oZgFaAvaJ3vlkUMnjC33wWzZq5Gx2IJWn9SOT+
         vd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjMgt0ZpdQg2knSU2JXbBhhsf0Kx0wU7rhre5Y0cyIw=;
        fh=uNxlGdp6KfRY2HR6aSv5rPVqgdaXQJ3mZ06xNVwN178=;
        b=lUrEYbpdNTBF8jraoF43ET0RnyWOiToVD5i/GlWrRCz/gyTBGQXaa7FNa/nVD4z+no
         b0PoP+O9RG/tbfoQZBpVgIh+3zX5hNJ+WkGUUk95h1sy4VvTKwvc2E1k0mmxPfVzjh4b
         g2naDO+91WUvF6E9xu3o3BpLPGsiZz2li/Hx7/KkyfJRPOuNnT/I8QTnS5zReaU2hopT
         N4r7boIs5X6mm4+Kj557H9pZ4xKMqnS9z9mxmoTuJlmhNxGfji5t/jH89d7egU5Hp9Es
         uRbsmcyUVY03ETfLMPO2Ky7e5CK6yB1AMmguCXe1FtJGcuHU57zEIdrWSbRz89W9pc+q
         OiFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264833; x=1790869633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NjMgt0ZpdQg2knSU2JXbBhhsf0Kx0wU7rhre5Y0cyIw=;
        b=N7gK6hFHAihZOUZORT213j1fI5UtgijwWWtFSyC6oQpnkkFWe94kgpQZ+SxEVStIYN
         FGLWMWh7BqtzktIHG+ONODHaxdkY2XJ4p903wAtdsgGSG3fRe3Fc7yXDx2qkfWvnmalR
         qGXfx7Vz5MJrFvHrqgQ2msKlyg7q2qGLLfFd8jT3Zbz3v7vwd5hWOqysbRx0mLZUGeZh
         ibkywErp2mP/mLyhzAz7/X7BUrPi2XO4xw9r7J9hcRsg9Cxx+fDE3jB61Ekn43dIPlne
         G1JJTXPRT8PQwCJ4QHMvzwxqMrXDQ1302yhimmqSPAFb1rh3e+JOOTykL3BRmIbtc5id
         5yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264833; x=1790869633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjMgt0ZpdQg2knSU2JXbBhhsf0Kx0wU7rhre5Y0cyIw=;
        b=nwwrET8xjtxoyUPAKHc8wFL/YdyxlpJqFAIg3LabpCsY9xa/4YDPnxUKAWJBpbj1vr
         rYI4gDQlcvKLvavg41yIEesPGEc4eSoSIxJFCRwNK+075l3gwcd+2rD9dxEs+6bF/Ysd
         J8pZAL0R9mP8cysmgPxC1O23keplWe/DJ8SDb5x8MSlAO3zd9VPUojCgy35b3D26XgWt
         l9GFuK7iP/lC/m2KbHWYlXccCDK3nOVHRI7maWODrpIPf13iTMSeL0oWlCLH6VZqUPdC
         BfrV7q4iD24zp2Pg1cRsA+08uXp7jPfebsmmUC774xDkYyXFxSsMzgP+5WSI59SBXyHI
         kZUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbjOxmSEmSFnJutFz8Wt1UuK8w3n7/vEApW2sLVR4D16/3h59MwvA7AvjQuJbOAT2JLAOFo6ry/6Fy@vger.kernel.org
X-Gm-Message-State: AFuF++mhRzsrjskQ/3/YkQA09fVOTH5qkJA0ON//f4aMLfSlIVw+5WsF
	XXQU6I2WKOWl/OxTKfAXBJejR2g591LtbI+r6+4LcuaRdhwSB4PAeSTUjoa/ZUcrS/8qVcy6++G
	PC9x9N0ed7bCX8Ef4m4QoUP0x5cT4odM=
X-Gm-Gg: AYBFou0ywDLr2HAqASxjth69YktoMeaYkLGUSQXlGWIdYwdDVFG+ZC44AtpqC8VGbTU
	3ogEAa853Q2eoI3q8vQtLfsMtnCY5mMz4c/IkoBW4Hw4VgVJum5u1I4nZQPCh1lOSZP2m7X9rEv
	OB9Bv6bybTDPB4ViBnqdivIudPjT8KSE7uaHem9rh1KYapjvSHIIrcdMTmMGCRVvH7rytScXRZc
	NeiusIPvF/Wy/6tdehTWc/IKTFhc1Mhx9kVHh0XEpnP2XU/XuXhRkluWTMlTSuMo7bNLnhbUSga
	0oj1r1xdoS5RZrePluVzdV+H+kSzANu6mlH8cNxGe8T/4QvYH8bo+f3NA5Mce7/mouVtu1Snybp
	A0dNRCzI0oSmXnpxZQJmm4ZiOXS5uL3DSjKTH6yxYXanlSE4R2BSARhVt5w5hmy2V17QgD0DCiV
	YauJ17Md0TmSAtyAirW+pnPcCyA44ewy4HerLxDCf+fQ==
X-Received: by 2002:a17:907:1ca2:b0:c29:6de8:d143 with SMTP id
 a640c23a62f3a-c2ac23d7742mr270801666b.19.1790264832926; Thu, 24 Sep 2026
 08:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919171100.90430-1-kmehltretter@gmail.com> <20260919171100.90430-4-kmehltretter@gmail.com>
In-Reply-To: <20260919171100.90430-4-kmehltretter@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 24 Sep 2026 18:46:36 +0300
X-Gm-Features: AclHuK-80m-884TG7yfw_6rikpHBOHTr9J36QiRQ2iE519ZRagEJv1so03yiKVQ
Message-ID: <CAHp75VfOwZG0htxs7LJ5X4cdTMApESRpDaGCQqJpD3RSap+-6w@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: tps65219: Fix TPS65214 GPIO direction programming
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jerome Neanne <jneanne@baylibre.com>, Jonathan Cormier <jcormier@criticallink.com>, 
	Shree Ramamoorthy <s-ramamoorthy@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 8:11=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> GPIO_LINE_DIRECTION_OUT and GPIO_LINE_DIRECTION_IN have the values 0
> and 1, respectively, while the TPS65214 GPIO_CONFIG field is BIT(1).
> regmap_update_bits() masks the supplied value, so passing either
> direction value clears the field and selects input mode.
>
> Translate the GPIO direction to the register encoding used by
> tps65214_gpio_get_direction(), setting GPIO_CONFIG for output and
> clearing it for input.

...

> +       val =3D direction =3D=3D GPIO_LINE_DIRECTION_OUT ?
> +               TPS65214_GPIO0_DIR_MASK : 0;
>         ret =3D regmap_update_bits(gpio->tps->regmap, TPS65219_REG_GENERA=
L_CONFIG,
> -                                TPS65214_GPIO0_DIR_MASK, direction);
> +                                TPS65214_GPIO0_DIR_MASK, val);

regmap_assign_bits()

--=20
With Best Regards,
Andy Shevchenko
