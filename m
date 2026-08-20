Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F6E407597;
	Thu, 20 Aug 2026 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219340; cv=none; b=F9FbSdPahRbELSPjQLXzknoBjxN4l1BCKR6eM08IOd6kRinnWG+ufnS0dLEebIa7VsWyNP5LD5eLFRjP+55lZetfvmPIWo/aS5j2gjRDxeMa69w+3xzl8cV5FiZtxIiyz73f2/YFNzgRtV6K8nloMKMOKiBEHsza6c1HyKQIA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219340; c=relaxed/simple;
	bh=qFyEa3K61Qwi+/Yk0CzGX6o5bMIVBmj5U3cBu6gEre8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGtuVSDqEJbHmn2ROmIM9e9226YGeys7Hcq8YodPw+9Be6XeI0SBGVTDjBzASoSNKcIYacGYEvmWwFnmAeJnA2orbzPCivX+Nz7c5JvoMo+1Ou0aKn+u3nFr1crqURUg50bwlKqiud182HUo72iObZBje8IFTI2HP5YkJtP4wS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=UU6s6Bjc; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UU6s6Bjc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=qFyEa3K61Qwi+/Yk0CzGX6o5bMIVBmj5U3cBu6gEre8=; t=1787219337; x=1788428937; 
	b=UU6s6Bjco7pq6SqWhDWqk7wm17l7gtCO5gj5TP3ayouJRc7172ZOa8yKuSE9ECeNzWn0J5vyEOu
	ojFIJIWQ27WX8/Qi5lwL5xnPKe/g8YCCmuTaaoE4VCrFVK5TdfXx3s7KpKSuCa+WF0wBuvZOYQnWp
	VKmZd1s6HNOOsqwZFHQj1EcabyRS11/d5SFNi7PftlSciQgWxRLbBcssF1kZ9P6hVjXEgJl30TDbN
	/PXr9aSOto0JOH8LNN6PFZ3UrjZetA2B8LLz7yco3b9/DnRo7+laHFxL1Suaynn4ts9YqcuIEuB1S
	kHxEqnP7KlHdmT89rnIxKr24HE4To36SwSWQ==;
Date: Thu, 20 Aug 2026 11:48:43 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: 1298662399@qq.com, linux-gpio@vger.kernel.org,
 linux-omap@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, Grygorii
 Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: handle clk_prepare failure in probe
Message-ID: <20260820114843.1b50783f@kemnade.info>
In-Reply-To: <b610718b-3c9d-4417-b1b7-69f0ac15dae1@web.de>
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
	<b610718b-3c9d-4417-b1b7-69f0ac15dae1@web.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Aug 2026 11:19:00 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> =E2=80=A6
> > Check the return value of clk_prepare in omap_gpio_probe. On failure,
> > clear dbck_flag and return the error, preventing unbalanced
> > clk_unprepare in remove or error paths. =20
>=20
> How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
>=20
About adding this to stable:
does it bother anyone?
Is this actually being used with clocks having prepare() ops?
I do not see anything there. SoC-internal clocks are typically not
so easy being rewired.
To be clear, this should be fixed in -next to be prepared if something
more fundamental in clock handling changes.

Regards,
Andreas

> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.2#n145
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.2#n792
>=20
> Regards,
> Markus
>=20
>=20

