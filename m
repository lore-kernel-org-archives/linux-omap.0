Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFB21CC51
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854287; cv=pass; b=bL6/fHEjE/Hvh5+2HHVT17T9+cqPRuobwKFmHM3buO/y99IsWgbJSn7YWIAfhNqes9FLuP1vjmvd3p1RIpNxUScxz1u8BpFw8RjqFmqugS6kGG86bzcyt5r1LTMWY0L2agGP21FXjAbYeRKTNN9PXC+upaEINa1Ayb7Cbo72BFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854287; c=relaxed/simple;
	bh=sR1JFSsAon01OtvSAsV6/RGrd106y8rHwXlJpuS8MH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPj4CUG6qg2GjhD21clmtGicp13AI29R1edd25WSTiacOHF+ZOek69AAPEMknKsIcAcraKevTtrV4Nz4u1PHEFAhEVfVipvtrzB/yEK9iBEngiIf5A+0nDwxJuz6jnRD/v8IWggEMyEY5M6x0bCbNbBbeKLQ7ZKA3A3PjNb2oqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mn6By/yF; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mn6By/yF"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59e4989dacdso4476977e87.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:44:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771854285; cv=none;
        d=google.com; s=arc-20240605;
        b=Tw8vISLNWOIJblmOb3y0ojadODukAWJZFi5iiNZgzEBf3sPzP0E1QIUrPMMnrdwB3f
         2bLoBuZ68suODaFREtelIi7RWS9VSV8kNNe2oi1YFobiHDAvnzyu2SjDs3DI7Gm0F3qL
         uwP+mOhfEKGNIv6zrXJnH5D8oxnNOOmjqQvALg38hv6bSKTfQwkfUOvWG5sDPu6ftA0e
         RU87m2q5eMTokkzi6BYnW9WN8OqmA2M/PNzLxEgFVY6f6pzCvqcvtFfFvIXYrVWAYe/i
         glKX/zitOh6VRbdCNF+oUQioSbxd2QmCmwGFeTxjbt5EtaGRGxa1zprMEpwmDfrc02l4
         qgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fhetx7uwtFJRgRkUexEhKn5KeWaKODjWdb8CIbVt7HA=;
        fh=sunT+QxPo/Biqmz6SAb5j/Hw5SKV0meXWmBFlq+9km0=;
        b=G+EXlzhg2F8M3FFCxtaAwhGmXg5jwv/n4DijXtqR8285DXUehV5N993rlEIjbErxLl
         HRs19oPcK3KqU1EyqzRSkvzrOMAlPHPq4feMgYyXNOXy54Q0mHGWeU02YDZLxKVnGm/R
         wHTULkeDRLOs+80aJSd9bWJbTNRco4A2/eSyNPwanutd/NA5IslfTJs57y2QtswUWYHS
         NawRup2b0rjs5OOm7N0LUIlzfARV4hjbrISRpJYWimIPmQKCjSztanyWSLHO5Z7Bhhia
         8T4j3nH5gz9FFS3XshcWYLY4JaFxcKte1qLj7jcpe7//dQbwbTKv3ClaC4Db7AcjPi48
         CROQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771854285; x=1772459085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fhetx7uwtFJRgRkUexEhKn5KeWaKODjWdb8CIbVt7HA=;
        b=Mn6By/yFk66UzcpBhl82x6Y1icrzzwKx9TUqEq3avBMnSHH/WPGJyCzaC3X+5e5n2K
         7bDTmcVGAZib/lFAPpQS4zMhkeXu1HrYYx1cv3XLXC2baXFEJz0XfoQAvyESmb3L+kov
         m8dOcBWKh0Nd9Dk0z+OBiGcWj3EDk5E/1l49nKJqzfTmM0RsHFeSxMB2oY8IyO5gUP3i
         9tFtVAJdHs0MvdjgqSktkuXY9C5WkZah8ldRFmKDb+zeQaNPVhQ1wVnpYdTyKVqJFi0z
         k0hdwI1KdLLql/L472glJMnAZ1CMcfcaaKq/2ndxHwGkyetsnWfyB5b+Zi5aQxebeWze
         YszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854285; x=1772459085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhetx7uwtFJRgRkUexEhKn5KeWaKODjWdb8CIbVt7HA=;
        b=uwxZyjZy9C2KchVHhsNSI96gH43DFopGU965Dj9ooPLEGsOxBWndEe5vQV0UWFbf3H
         6A5dQ+d5bdR0ydhRJsNGVf2faEP3RzG+nZXZ/YQzkOR37a9ZI/aE0aLdbAu3qGDvsZt7
         GBXQhDFBiHj4ENmy+BiriSIXU6oMwFDXxKAQpu6bBjSxkXY//e80ube85nmT5TQrb1po
         csQnN2jwN0huZfO1J0UPebJQEgR4+0AMUXu0Bb1kGyQKmyOf5wn4mfQrlLsq3J3CGPER
         d7N0KmoajOHSqAyK77ymRl4qPxKps4f5A08vNfkXvsVXlG0p/N07XD2ntg0QpMZwn8Ax
         5Vaw==
X-Forwarded-Encrypted: i=1; AJvYcCW+GVFiI+nUKGtlJJu/fc7StHboSdGwX2LBO2TlmsI/JWA062tIIPk/7AIBDGbOZBYxQi7WczELoGsZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhdvwsqaSU2b5HaihNs9hmZu80okI6VTewfFowj3aMGcfWApP
	bb5Fk5qPaocOI6ejHDZkUChrwih9njWt7zlwGSsU1g70y2XtcPawmeoOXzSWawSlALfqQf5BiYA
	RxTQbHQA85ORdLvW6AYqE84+sy8HtXUSebR5/j3mjVw==
X-Gm-Gg: AZuq6aKrwv0dFxPnEV90l7ZFb7JZoWdA/QCocRhSyY7fWaXo44yI+jU7PpR3aobJofg
	gW55IRwojZfMljgBuPs0vq48lPfqcu8oVa9I71KOPb2SVnGSewpc0GqOBYA+ttke5/22d1Dswpf
	aPiqN7JsX8I532J28ag/fOkBOvi4iZnDoYFhCjuTNRGHbt23YGoqMytUOKsPWRNTGImwDFiTaMw
	hzvuT1aEpE20+ANfw66dp5kFZwehpZnP5/iCIQVX5yVOrYwti32JU3XcwaopTlgxYmfMzyC6/sC
	GesICGzJ
X-Received: by 2002:a05:6512:318f:b0:59e:63b7:585e with SMTP id
 2adb3069b0e04-5a0ed99f1fcmr2755602e87.36.1771854284344; Mon, 23 Feb 2026
 05:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com> <20260216092914.kmvl7aep7dantcsd@skbuf>
 <20260216162406.0121dd91@kemnade.info> <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>
In-Reply-To: <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 14:44:07 +0100
X-Gm-Features: AaiRm53IT_Xzv6_ZjZsPbjTua3wzc0_3fH4fOJcUrcKMz5LLxYEEUcMyBCE8pyI
Message-ID: <CAPDyKFrtTaJ5fqqbGrE_K6SAdTZYUfp-BycGjtWs4SabwBysKA@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Josua Mayer <josua@solid-run.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Vladimir Oltean <olteanv@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 13:44, Josua Mayer <josua@solid-run.com> wrote:
>
> Am 16.02.26 um 16:24 schrieb Andreas Kemnade:
> > On Mon, 16 Feb 2026 11:29:14 +0200
> > Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> >> Hi Josua,
> >>
> >> On Mon, Feb 16, 2026 at 08:19:27AM +0000, Josua Mayer wrote:
> >>>>> In the future, when you have a series with cross-tree dependencies,
> >>>>> please try to think of it as individual mini-series for each tree's
> >>>>> 'next' branch, and specify clearly that you need stable tags (to be
> >>>>> pulled into other trees).
> >>> I don't really understand how I could split my series up to avoid this
> >>> issue.
> >>>
> >>> Due to the fact that one (and now two) drivers implemented local
> >>> mux helpers, to undo that an atomic change must be made tree-wide.
> >>>
> >>> Meanwhile it must be avoided that while the mux core helpers are being
> >>> tested / reviewed, that any tree adds another driver-local mux helper
> >>> like appears to have happened here.
> >>>
> >>> Note that my patch-set did go to linux-phy@lists.infradead.org list, too.
> >>>
> >>> The second challenge for this series was that mux framework is being
> >>> enabled only by drivers Kconfig "select" - and not possible by menuconfig.
> >>> This is e.g. responsible for being unable to test =m build with arm64
> >>> defconfig - and lead to it only being detected through kernel robot
> >>> x86_64 allmodconfig.
> >> To avoid this, a combination of developer due diligence + maintainer due
> >> diligence is probably required.
> >>
> >> From linux-phy perspective, there will be some automated build testing
> >> (which did not exist at the time of your submission). This would have
> >> caught the 'hidden' devm_mux_state_get_optional() call present only in
> >> linux-phy/next, when testing patch 2/7.
> Excellent!
> >>
> >> But, to work, the build automation needs to be able to apply the entire
> >> patch set on linux-phy/next. So expect some pushback if it doesn't
> >> (hence the recommendation to send a mini-series to linux-phy first, and
> >> request a stable tag).
> It would help immensely if there was a way to get the patches renaming
> driver-local conflicting helper-functions very early, before anything else.
>
> Would this sort of patch be acceptable in linux-next now, so it can make
> it into v7.0-rc1?
>
> If not then that mini-patchset would be the first one I shall submit after
> v7.0-rc1 is released.
>
> Then I can treat the actual implementation of the devm_mux_* helpers
> as a second standalone patch-set.
>
> And finally patching all drivers with local helpers to use the new global ones
> can be patch-set number 3.
>
> Any opinions on this?
>
> > I do not think that is at all the duty of the patch submitter. I think as
> > long as every dependencies and side effects are documented, it is IMHO up to the
> > maintainers to decide how it can be merged best. They know best whether there
> > is any danger of conflicts in their working tree because that is an area
> > where people are working on. Especially this patchset is around for months.
> >
> >  In MFD where it is
> > more common practice to have cross-subsystem patchsets, once acks from
> > everyone are there, MFD Maintainer creates an immutable branch with a tag.
> > The maintainers of the affected subsystems pull it in.
> This seems like an option, if I can get the patch-set (or a partial one) ready early in the cycle.

I agree with this approach as it should provide less churns for all of
us. Especially since the changes to the consumer drivers here are few
and trivial.

I am willing to help with hosting the immutable branch (unless someone
else wants of course). Once all acks have been received for the
series, I can set it up. Then other subsystem maintainers can pull it
in if there is a need to avoid conflicts/build-errors.

Kind regards
Uffe
