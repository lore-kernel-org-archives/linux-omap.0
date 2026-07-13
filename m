Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA03F076D
	for <linux-omap@vger.kernel.org>; Mon, 13 Jul 2026 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943331; cv=pass; b=XQkiW0AgtHwF4dH4+X/Ou8oMr7i2srqeY0PTH64L08JYIc2JkMf/eIVARQDlV72+zBQfawEamRpdqZfpnMRhytjJ9pE/+x6vzoVXMBdgd2rlpbM3ce2YCVH9S/ydl6OxdQhmiAuhGXZvZVG+BTHCssA+Jl2O4R5EAqfwcHoDffo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943331; c=relaxed/simple;
	bh=1injv9Rl4NBM+B+HS0THOHMdNObE2wuHjPT90v0vu7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7IZ8mH4JkX6iaNVHF2m7fLM+N4rbsaGakIMkRWjBWNchlqEUzwwfBjpGjOMzeNm9jfj6tehydGgev65Iwy4LfoXb5OuMYVkXXdPRHuzsP4sgEomGXjUuPLo8+lCR2GLBzqvijcaaHGSLkWz7+rDByWSIn1JbKGj1wPCt5p/oh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkNn7rPf; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkNn7rPf"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664cdeab266so4607384d50.3
        for <linux-omap@vger.kernel.org>; Mon, 13 Jul 2026 04:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783943319; cv=none;
        d=google.com; s=arc-20260327;
        b=Fs4S+Zhg76OxGUEw3oz35s17ZOf5PAYKF1xhgWadmCbSeLuSheWehjb2joqeCqv2DS
         uDiPMZ1cVa/Ssk1sQhZisjN77pBomYX1TV8lDQ3KzFbK/UkOt/87WtDhhen+nHyg/n3k
         7CMvPf2xM3ziLjGbvn4oW4QB7D823wEvK5NCCebyVoA5+JDL9Gj1qIhNuDpgXoH72vLN
         yL4z9VSRh33YxGSmx25EMWbc5QhB/L0hhQQn8RXmAy0DOp051FBoTinbiPaPHZOng2K1
         ZYaLkuK0eqFtMhu7nvQVYtMM3m0eC/5sPQOPr4MdTTiqyqtohYmsouhXh1y+XAr0c55f
         KpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mEG+/O0PcIT4+oFeruk11rdD0Dcqs/l4Kgd6A6lmTpE=;
        fh=L0o5JZuFmV1YI55w3g8e+X4TF/Ja8LwxFW0RxSDW0mw=;
        b=Ck5D+1JJ03g83+ZxgVM6mXTEHGKMeruJ5j/1eW0+dVsL/41Ax245uUICVlVz3zusQB
         8rw1ga686mU6iPHrqw9SoKR3FWDS/Iq71PGhUX0MQPYW/pLmKkeS1wgRyu4hkf5VLcAc
         5N42Lbf+LifXwHAlz1dgXNcInJ7jL+VS3Cl4DO3tZt/PezYlAnFV6VBlPXt2+g+RFMoO
         ZaRqx1hH9wvqvd5ZI7m/7j+jTf6MhVbtD0QbNcCMWqiS0gikDCG/xqgJ883XJ2ett9lE
         72zsYIh2O6D6xnOHPrturi1a6kdIbywKMOM4boPIYte3bPy2j/c96I/MepRn5VfTKNls
         ez9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783943319; x=1784548119; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEG+/O0PcIT4+oFeruk11rdD0Dcqs/l4Kgd6A6lmTpE=;
        b=JkNn7rPfgPxTCW4E0iUBIdWrmz6QeOs6vsYk12goTq3d3i3/LR9C0knwtDA47SrqGx
         d4fPq0UGpkoJvj/14VcrZnwmHXho3zXJ/iO8arbj3cNS1AiF3XZgn5pkA0oQktPSAXnM
         LVn2PElwu4PMid9JWd9y8CCJbBuAJ9jwgj1Denci6vgPv8qJ/jcw6CBAHClgvRHLMmwX
         GIsBCNcgMj3nPrU7KuEiksSxOorpTTqxfWXpalXDCWA6IAupJPaiWNClQdnO5mJ1xCcz
         Ms9ppJ++C4GnAw26EliPrsozhir2/9YpsGhphQyOSJSTucDOhSG3m1JRRuZUhcbujur3
         dyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783943319; x=1784548119;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mEG+/O0PcIT4+oFeruk11rdD0Dcqs/l4Kgd6A6lmTpE=;
        b=qUgKKG91OtcIcqr+TdieycEFkLMYw9urnBIe2zHhoTqeL58JFvsZHa00+mXrPn0AAT
         MFxW5j94/pSoskQYTo0PWYmq/+M7chBCAyQJVJ++sziKV6jUQSPUCtwtVJGxe65DfnwM
         WW+7gwN16oSd3NtnbNwePfOa4I5KSaFSgw2D0gV6BwsfHofwINPct6FV3FL5XUcsnp8p
         YbXEK89hl9hsfd8aMcNBgEJZREAkGDolil45QfRw/7eYrMpZBfM4/NhLh3t3+NKWU8T4
         TmO5uc83zNrFjMabf8Ek4Y2d8qgHQvcxt+nhkXEL+uuQxGbZAEUSMq6yQWxmCSB+noJf
         nrwA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0OmIgUUy4MksHcgFotOtd77ojTwqGNfPW/ClCQLW4JaYgp7pMWD5fqJ86jc27yg7V/7T/dFAKMd5z@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFdfwfT2ia0qP+QTu+xd7qKaHEXlryOVK4S0bMYhYwwazgVph
	IombMYQRqGn53/WPJ7N44X/CUYzCoxC66Pwt3QKjbQSTaXtqW2ypnGpC1Q64Pdm14+nveai/cc8
	/J20aAQ5rsQlpgBLWFvhV7NSYGchcscs=
X-Gm-Gg: AfdE7cmtqnJ0/H/2O5Mv0poDQwx9KU6tgMBG0Ql+PlWwdax4Foq687gjisMslEnR+2N
	ZWyjcfMPTtaNjjR9A32cqzxvXCOoRdhCsLjROHyCL1L4zTiwaSjwOMJWcJJC5o4boeMtG1eiN10
	xUQrmI1F1oSv261dH3408Z5NKd/i8S3qKpcADhKMaTk8LsuXKXGKpwXC3EOTRqzTd6d8IkSpq+U
	YrOVYWNicQ7rshc0TlFVKkLeENI9RGtge6xgms1ZUPQiXNDdlKn6J2uhZgjSCBiad9xxxLp2Dwp
	q4dyEAIILg==
X-Received: by 2002:a05:690e:4144:b0:667:e3b3:264b with SMTP id
 956f58d0204a3-667e3b35f5emr4355142d50.40.1783943319427; Mon, 13 Jul 2026
 04:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705091411.282560-1-lgs201920130244@gmail.com> <aktUJSxhLBtlWoFF@hovoldconsulting.com>
In-Reply-To: <aktUJSxhLBtlWoFF@hovoldconsulting.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Jul 2026 19:48:27 +0800
X-Gm-Features: AVVi8CdjFXPB-eUHcBXigPqZjUktfJXA8GDMtbaIq76RLFAQWKb9JIcqJBuLKuA
Message-ID: <CANUHTR9dRbRcAA4fB+uTZVWwzr3T8S5cg2x838D7t5j7yL0g6A@mail.gmail.com>
Subject: Re: [PATCH] usb: musb: omap2430: Do not put borrowed of_node in probe
To: Johan Hovold <johan@kernel.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wentao Liang <vulab@iscas.ac.cn>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

Thanks for the correction and review.

On Mon, 6 Jul 2026 at 15:07, Johan Hovold <johan@kernel.org> wrote:
>
> On Sun, Jul 05, 2026 at 05:14:11PM +0800, Guangshuo Li wrote:
> > omap2430_probe() stores pdev->dev.of_node in a local np variable. This is
> > a borrowed pointer and the probe function does not take a reference to
> > it.
> >
> > The success and error paths nevertheless call of_node_put(np). This drops
> > a reference that is owned by the platform device, and can leave
> > pdev->dev.of_node with an unbalanced reference count.
> >
> > Do not put the borrowed platform device node from omap2430_probe().
> > References taken for the child MUSB device are handled by the device core,
> > and the ctrl-module phandle reference is still released separately.
> >
> > Fixes: e194ce048f5a ("usb: musb: omap2430: Fix use-after-free in omap2430_probe()")
>
> This was not the commit that introduced the issue. This should be:
>
> Fixes: ffbe2feac59b ("usb: musb: omap2430: Fix probe regression for missing resources")
>
> and this should be backported to stable as well:
>
> Cc: stable@vger.kernel.org
>
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> And again, how are you finding these issues? Still no LLM involved?
>
> With the above fixed:
>
> Reviewed-by: Johan Hovold <johan@kernel.org>
>
> Johan

I will fix the Fixes tag and add the stable Cc in v2.  And I found
this issue through manual code auditing.

Thanks,
Guangshuo
