Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36046EC8D;
	Thu, 20 Aug 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787233419; cv=none; b=bIEIPlTv2VQiCZ1RFu4lWz1pO9dPeb72R7eQAgbYjLt5ebLKJL6nYJs4QExZzzfgAq0w2XV/eE8cuWfQyiQjnXCLTlwguiNtdEgvahd6K2rUNhT1ML6NXHPnjq0N3No1VIY9Q6GGslRdfZ5u2FN3uQuixYa6tu7ryX3q4a6c7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787233419; c=relaxed/simple;
	bh=JF2Hfspvy+SVr2lJoLQECIEEFhR4v9Bj/u8UirX+ux4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwXZaBMP1Ssn+oAreuho+rsISTYHeLogAfP5OZNxK1uHchjuOYE3jpTRVjhw9QAA37wFvrYm6UJZWRVOn87VPrKsf9da9myBYK5/G/gomT4OAzjB7KLihLeWcLGjHcLVL90pS/e3hlW4XHyZBnQVDBm8jSJz+gxg3MKT8Qb2bC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=TskAOehj; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="TskAOehj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=0hnkKJN82zoHJv4K7UufbjGMMHI8pFhj5Ti31z7ZufA=; t=1787233416; x=1788443016; 
	b=TskAOehjpqqby/XTZNLYWubl5RKB/0r1k25LTxK6vmPBOBvwcQnyzmta2+jzRZ9W9nFmZwmHiBA
	KL7N9kR3s1rGYrT41hqus3a765ET2dEN4BFaTi32WmO86UTo/Q06OnKo7v/B2uI/rJ0lPtX7+nW+r
	XWUWsKP6fuMe6qKKCgDAtv1rLQ6bH+i+xZ8GDh07VP5GB8cQGjVtx1sS2z075JHjGkltSAI15S8t8
	1QAweyWcKnONZmrNVWUF5SQOlSYIdoupub2BSyDa1UOSZztwE84Rhd83bM/FzxeMC+/+2r1yJZUOb
	zuENUG+1mqnsJrhUUXxfeOEggg5Yxkd5MtRA==;
Date: Thu, 20 Aug 2026 15:43:23 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
 1298662399@qq.com, Bartosz Golaszewski <brgl@kernel.org>, Grygorii Strashko
 <grygorii.strashko@ti.com>, Kevin Hilman <khilman@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: gpio: omap: handle clk_prepare failure in probe
Message-ID: <20260820154323.0a7c7929@kemnade.info>
In-Reply-To: <1352405b-7bf2-46e6-9aa6-df1e60bc096c@web.de>
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
	<b610718b-3c9d-4417-b1b7-69f0ac15dae1@web.de>
	<20260820114843.1b50783f@kemnade.info>
	<1352405b-7bf2-46e6-9aa6-df1e60bc096c@web.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Aug 2026 12:47:05 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> > About adding this to stable:
> > does it bother anyone? =20
>=20
> I imagine that it can be safer to avoid return value ignorance a bit more.
> https://cwe.mitre.org/data/definitions/252.html
>=20
Well, if that would depend on user input, esp. over the network, it would be
clear.
But here you need to patch the devicetree to add a clock there
that has a prepare() in the ancestry. shows the desired behavior to exploit
something.

And then the error check is done by clk_enable() anyways.
BTW: here the return value of that is not checked. That is the more
interesting issue here.

Quoting stable kernel rules:
"
 - No "This could be a problem..." type of things like a "theoretical race
    condition", unless an explanation of how the bug can be exploited is al=
so
    provided.
"
=46rom taking that verbatim, I would say no CC stable.
But pragmatically, also to avoid noise in any security scanner, I would agr=
ee
to a CC stable here.

Regards,
Andreas
