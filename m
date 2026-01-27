Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685C36CDE9
	for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542007; cv=none; b=bWMmQfVw429uf22qIVjkDUM0egrrF1kpaYAIxkmL2y+EWDOQfIXi/hs791cyWXZvf9eMMb44+aJcPyObs3Q6wbv03TbuUqV4EVAFthWKxVj0c0/A+eM5cdiZ50RaapKmuTJcWNzM6Ez1rClLxbArh7IVWskrB7ao0m7jwfuQqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542007; c=relaxed/simple;
	bh=4iJMoONgKjZl/35yM55dK9/5u+NMiXbWSQwXg8aFz8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kcb48uK6rE2GLdm7CKN95nrZBruuANJyjM3TMNcM8F1kzSXvgxtwnZJgejt/ATYy9YjGZFTvo1NjSdzaGnO+0GSSukhFDtU3OIIM6++3UYRC7dUu+Eka8pu9SdN0kT463q442/BbQRLB6zXWuQKAKAFHG5Kvrr8akTGSi/jLBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrbK/XTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrbK/XTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B173C19422
	for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 19:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769542007;
	bh=4iJMoONgKjZl/35yM55dK9/5u+NMiXbWSQwXg8aFz8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mrbK/XTojORzNZNIThS0b9RpzF8AlSjgZOiy2QfiOaSAxxPLrqP55Gk7yjimsQy59
	 TbPFiXooldTnWQyVBr/lmR+0yrkpw1aUo5NG9UgmQmPB5YOFTDx6cP2HZd9GqkPci0
	 iEhjFNYwTFmypGMpfF0xQWn5biSo0gNGyUtYBBERnrtuwD4qAKMmspBJPvGU8OQX+A
	 y6hmGnlE5nkjy2TyV5g34r15hjRIg+QXyOmsGMLun/ZXg/zQSXNMa84tvrIdwTbYf2
	 sLZp6OPrYhj8tHgt59nlJDAeRWvNweYu4uTtxHLaf3VkKGIUXz+MvOuvNW5/RCB8SG
	 EowgFStmTAl8A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59dd7bfeb8aso7431621e87.0
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 11:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJe+salZV0JpJ9u5Pm2Ac80ZqqGxHWuEAefYzBM2CeyKcE79z4kzsSRKVyTsLCjPtM/Pp39PVIuMeX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5y1QjEjKSQFEyguzpSXRI+clOAQf8EqEJdkGpqxTZEuTy5KLH
	tpo8r0vI+J2iTzbnl+WPwtEaYp5HKhSwAwR83ELP2e83gAtq9QvASPLL43zZRfIkNOBFKpkbx+o
	tTJ7X9o1mineOhbPR9JW0nW5MIMl4fgtl6L3Oa1ML5w==
X-Received: by 2002:a05:6512:1cb:b0:59e:4c9:36e5 with SMTP id
 2adb3069b0e04-59e04c937f8mr735915e87.52.1769542005638; Tue, 27 Jan 2026
 11:26:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123133614.72586-1-dakr@kernel.org> <176950495232.13307.15142034347404555496.b4-ty@oss.qualcomm.com>
 <DFZEVBSZTGK8.2227V5O5GQS9T@kernel.org>
In-Reply-To: <DFZEVBSZTGK8.2227V5O5GQS9T@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 27 Jan 2026 20:26:33 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mc5vHWLYUxtT4xvYE3eBsUGjw4oK6P534jT+wPGjSRdFg@mail.gmail.com>
X-Gm-Features: AZwV_QiBpTXuc6CtSxf6PYQoCYyuA_tku2BRJyv9FOp2BjqudeScHgpvsW43ibU
Message-ID: <CAMRc=Mc5vHWLYUxtT4xvYE3eBsUGjw4oK6P534jT+wPGjSRdFg@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: do not register driver in probe()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, broonie@kernel.org, will@kernel.org, 
	grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, 
	linusw@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 2:38=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue Jan 27, 2026 at 10:09 AM CET, Bartosz Golaszewski wrote:
> > Applied, thanks!
> >
> > [1/1] gpio: omap: do not register driver in probe()
> >       commit: 3cb53b083fa665ec14c52962f50b9c1df48cf87b
>
> I think you missed to pick up the diff in [1]. Please let me know if you =
want a
> fixup patch for this.
>

Yes, can you send a v2 with that included? I'm dropping this patch
from my queue for now.

> (One unrelated note, just be because I noticed by accident. Your applied =
patches
> seem to use https://lore.kernel.org for Link: tags, while it has been agr=
eed to
> use https://patch.msgid.link instead [2].
>
> I just mention it since it might be unintentional, i.e. it might be that =
your
> tooling does not consider it.
>
> Personally, I use b4 and have the following in my .gitconfig:
>
>         [b4]
>                 linkmask =3D https://patch.msgid.link/%s
>

Yeah, I do use b4. I changed the linkmask now, thanks.

Bartosz

> Not sure this is still necessary in the latest version though.)
>
> [1] https://lore.kernel.org/all/DFW0SC4QG4W8.C7BRHX02W3IK@kernel.org/
> [2] https://lore.kernel.org/all/CAHk-=3Dwj5MATvT-FR8qNpXuuBGiJdjY1kRfhtzu=
yBSpTKR+=3DVtw@mail.gmail.com/
