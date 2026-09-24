Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7A414DFA
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2026 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273039; cv=pass; b=JBSyWRLrfJVZ1zLqoOe6/n2wbMCE2gC7JJN2WAPSssBDhIhPfO17Q86A+ocLbDOOeG0p0nh7uVMv3i8e305QOC2aknhfYbkk3bqXfU4cOuvSao0xJOEtCAfx9lQo6bfYZ2KKSL55Ue4JDM3yjuqyDflcrCxxXrYSDGy+cCBArDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273039; c=relaxed/simple;
	bh=be7ui7RFb4TvlxRvgKCPBiOHLIe8vlOIGLT6VBBiuVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8QZP+LHGXs+YRDgFnGVTWllzs4SrwVxw74FwtP1qYgMSiIEQ3BlL6gF230GV4WLmF+X9Z7HWHWKe0+rGm4eV60yop6Hcq6aDvLznttmFGqitdZu0igqAwjqdlv89dOJYj4MlESzT1eGa8iB7Z9it7iNaTcYo9emvqTJzPLsgZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=Tllg3cgI; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="Tllg3cgI"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-67408b109e3so150267d50.1
        for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2026 11:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790273036; cv=none;
        d=google.com; s=arc-20260327;
        b=BTYlpmzZzdvDTbzxRb9L7QgsXQAah0+20EAAT+zrlwUa2ZAYuJK41ABS757jyv0pCW
         cnyoaIpz6oLPMNPPLe21B87JJL1y77KqWFp0+VHuWx/orjKpKB3uMpNL1ZCVMSQheF1U
         IFROOwXp96CShzfMzswuuaLlH4s1TVUy/DpfNDNCC9yCO9XESdK00wt4HFIKwKaRj6Ec
         Ias3G8r9EUswuN1kico1tE/U+/oe5hfME8t4yVtPUjs5b7RuKM24oIySViFJg69ibrg5
         JLSoDnOXvQwsmTKlWSmoYFzCQJr5jJtUZwjL2Pq2l3WtnjHM3Bcd3k/RnFcf73R3QTZG
         7Ibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GbI6rbvHDi76XEhVIPPpSzJuZ9OLSAAQszp6JpdmYTs=;
        fh=ynIJxWfTVHgdqMT6DLu9gk/CxGXol33oQbugh3R46WQ=;
        b=BYKmK9VlOlo53XENmrcgsMjzGuGL4wp/NTH2GQw5xzntDFzpfQKhBfM4yTGSPIwdGA
         tYRxt4c6VHP1SlNCK1KV0OpCTVeZvQsP3vmL9CB0fbgvUsmVkNfzqi0bI9zLNVrMMZNL
         Uv1cHKDrxzHHA19VedYWYWRR1yGiMRVKQzRUFnEGLTu+94DGGa5Tw7gQNmu2XhSegFbU
         yAgFcQ1z80QYUXeJOTvkZjzfGmgaZ7SGJg3r1VnCWDTA2s9QQzXjNRmN8jQOdcQ7RPuC
         7XENxFZTyNDpARY13TO2ShmsQ2QyjKx2xhocMq3xFVR2MgHHThWiFGniFjSaxT37QRAT
         IpLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1790273036; x=1790877836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GbI6rbvHDi76XEhVIPPpSzJuZ9OLSAAQszp6JpdmYTs=;
        b=Tllg3cgIs6Mh/QsE/gqtoODSVbxsjQTUklnMElum9L+0Mg7Z58Jvx5lGe9DXBEvpQm
         UchuSGjjQpmHpdQeM30OXV9skW3zA0Ksucr+Bw8IrCuZLaVypsanKji52dK5vjcPevoB
         ZnjXgGW45scARmkFDbXcvQLqNQExve44Lmc63dJ0T5trQnEvnx6c9ardk5j0iiDGgPPp
         BchPZ/j0mPfJ2tTWiMvBvmnzsG8FChmaNKvCyUPGvY27HgIwLNx6xApZzfmvVWXMuncd
         nRmjwC0bDVB1Q9qzmhfkYC5+aOy/lxzk1Cloogorzg1TUwiagURqYVV06Zp101/GDPIW
         WjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790273036; x=1790877836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GbI6rbvHDi76XEhVIPPpSzJuZ9OLSAAQszp6JpdmYTs=;
        b=awVFIAjio7b2SHeS2lcg9D+2GWjYnzxyt/eoySRZ6ZWOFGd/pAtoEuSWEwwND9tIYx
         gqVq81sIEJFfdF1l4u3vRR5RD7UKaYAp8irRkGkVMms2MT6oa+IB6E75+PKPsaGZiJ6T
         u/JDZ+vRRQ3yK7h0DuMPkfInQygf+F2L6c0qx8yE3xXJuJUWvn1o+b+dyMBpWpJrDd+I
         hdSQ8Z2HgLuLMYBuPFZb8d3O1/vSA0c3KeIyP3tUo6H4f5dWYt/oJve4kHomTYZRzeRS
         tsrKpeTsMIkwyuec+wP18RudZcmkYEPk2DIjfwPrTZEDjIYmIveuJu7/ncQNODtwYwg5
         hctg==
X-Forwarded-Encrypted: i=1; AKwUvByc544ErEYihV3T43sQ26XbtHC40bi38hdd+Z/duOuQclX2GO3Q+NAYMRPVlzmP1U7J2qC9CHaBi8Kg@vger.kernel.org
X-Gm-Message-State: AFuF++mnPuYG/oiJeALBZEm7u20npaC896WyfdwmG1WHb8KioGRDB9hP
	+um24AlmB5mlgaAyi2B8jbKqaqB3TaSpnPsRMdetbXnPBXeahcMv3zwfmi5mKNY2bOt6jOme+EQ
	0nl7BD15EDabxtlSwGXK+8LcBudOOco4Wvj+STOPG
X-Gm-Gg: AYBFou26Nd6sy8ExwpgPDfMML7aRCD/SHHXK86rb9OSBJwp/F5glPd1x5/5UgQ9SQyz
	mPaHoh9QZlfuh+EgMVJXX/TUxrJqp7r8LYm8eL1rGr7Wg5G2/fP1V7KqFp673ptpMHATK7o+/xN
	EPalr/zJr4xWio1Q7Pwu8fBSYHyhjzjxen1ORXtFleY+r32I5dHYMMGpHzBpce3WUnvP5acyV0Y
	nvDXLplvcxU3iA0srTlwr+NS8Bygc27pBbU+l36K3IuBnsiI2YBnhJDltCtuQ9mv0je1/5XhT3Z
	HEUURIApVDqOLORaKJznzMEd4AAKLbJdlnHYaW9kw6jrXdgX6dGf3sxY503Zz//L
X-Received: by 2002:a05:690e:4893:20b0:673:1df3:a6f8 with SMTP id
 956f58d0204a3-6731df4bb08mr827628d50.27.1790273034957; Thu, 24 Sep 2026
 11:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919171100.90430-1-kmehltretter@gmail.com>
 <20260919171100.90430-4-kmehltretter@gmail.com> <CAHp75VfOwZG0htxs7LJ5X4cdTMApESRpDaGCQqJpD3RSap+-6w@mail.gmail.com>
In-Reply-To: <CAHp75VfOwZG0htxs7LJ5X4cdTMApESRpDaGCQqJpD3RSap+-6w@mail.gmail.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Thu, 24 Sep 2026 14:03:43 -0400
X-Gm-Features: AclHuK9W-13IkypRQ3w-qHAtFYIaLjYWqfxyZOrezr6nxGY3oYYuRteiyYlIevs
Message-ID: <CADL8D3aLAViH=5gVVRz7==M0T6rVuksNSgcoZCCTAJjroUnuxw@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: tps65219: Fix TPS65214 GPIO direction programming
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jerome Neanne <jneanne@baylibre.com>, 
	Shree Ramamoorthy <s-ramamoorthy@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:47=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Sep 19, 2026 at 8:11=E2=80=AFPM Karl Mehltretter <kmehltretter@gm=
ail.com> wrote:
> >
> > GPIO_LINE_DIRECTION_OUT and GPIO_LINE_DIRECTION_IN have the values 0
> > and 1, respectively, while the TPS65214 GPIO_CONFIG field is BIT(1).
> > regmap_update_bits() masks the supplied value, so passing either
> > direction value clears the field and selects input mode.
> >
> > Translate the GPIO direction to the register encoding used by
> > tps65214_gpio_get_direction(), setting GPIO_CONFIG for output and
> > clearing it for input.
>
> ...
>
> > +       val =3D direction =3D=3D GPIO_LINE_DIRECTION_OUT ?
> > +               TPS65214_GPIO0_DIR_MASK : 0;
> >         ret =3D regmap_update_bits(gpio->tps->regmap, TPS65219_REG_GENE=
RAL_CONFIG,
> > -                                TPS65214_GPIO0_DIR_MASK, direction);
> > +                                TPS65214_GPIO0_DIR_MASK, val);
>
> regmap_assign_bits()
That would make sense, it would simplify the diff.  I think something
like this, right.

-        ret =3D regmap_update_bits(gpio->tps->regmap,
TPS65219_REG_GENERAL_CONFIG,
 -                                TPS65214_GPIO0_DIR_MASK, direction);
+        ret =3D regmap_assign_bits(gpio->tps->regmap,
TPS65219_REG_GENERAL_CONFIG,
 +                                TPS65214_GPIO0_DIR_MASK, direction
=3D=3D GPIO_LINE_DIRECTION_OUT);


--=20
Jonathan Cormier
Senior Software Engineer

Office:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
