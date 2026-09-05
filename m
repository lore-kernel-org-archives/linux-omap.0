Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6014AFE2A;
	Sat,  5 Sep 2026 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634289; cv=none; b=GzQl6TkdXeClOnZYRlljvsQLaUYlxAsF5hsvfoTy9VUNRE4T5pnzTf5GOUTqpdCGTlhZrbaXbKFgzQJGGjyDrlTdsQOmnZGuQ7Onf7o/rpEwB5s6bk1OGtyyJrpem8qdKEoEeXx6otawA63Fkw/Wko7dxWt+1EfETUQlMeNClvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634289; c=relaxed/simple;
	bh=ofRB7v39ubcw+Y/8Vz/QMz1zIkNRg+f+DK6oNCvx0tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtJaNCDZe1mwSZILN0K9WiZlrW8q+MHXL7qtjnMwnkUbfTsAWa1T2L7eYTVYPbvZIQxo56eUEuwOgb4UbDyVUsHhGgKSw/tOFCSUMW1Yw2R95Xp1tDH0i6mcCfZUekPPqZf6n/5yI68CNhtUiMN/rT4tTc+kCoo2lczyXgDhllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Fjeu0EDH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fjeu0EDH"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B28E340E020D;
	Sat,  5 Sep 2026 18:51:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oSbgdzpBFeS3; Sat,  5 Sep 2026 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788634273; bh=hXOMrLP4Jcf3qb5J5x0VYBAY8+oENz4ptR3d/QTvXLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fjeu0EDHJFgKNW5CFsNfbhfUsVkaD/II9wBzUdjPy19Qz5c9qCWHt2GaqETLRyYfl
	 ozqt388uOm5DJ1buXKFpNR6t2K5InO+k8x3sAc8omTSmaNIiNvOz2EU7pcx4cW7Co2
	 bj9uSPWz7aAU5Sn0rEMJPg9fIAhy1icFtlUJrbtz7OwM3WnDixfLv6CEnxgkdXuAnF
	 0jtCEXsX8O3iFXdpwooOfexHl7CYQg56dl8DRlRz3iTEDawCD69QFp7ViRfGeeSFpL
	 olO0RACzUr4cBADYRA431hoROmDyfR0FF4HbaInqPRITvYFkZ+d9+jpDJiku5+Qnu2
	 4rrOfrNE+8gmY5VVOmmWd6XtVVZvq4LV2K8eUnfuy7IH4EiGbIO3/VZeh1hug1fk3h
	 /yMd3cdqNcfruu4oOPod1hE9AzjYIXhsJ+ztpuQrKAQRuZQid1i8yJ98tMZ4t4CMKK
	 +f8EnC9RHcTRmYlRv0bZCqQ62a/2hfY5RYywF9+9fjorjR2iVBZwF8LBHrpPOB/uUL
	 hZCABu7vIm3QmM+bvYHH/zABlwXwyE6Q+wYyGqADUyv2oaTQvK3q9S6/+EW31L4pRF
	 BNRZSFgLovezUDQlCyRJG9oPzyNLR63CPReK/jD1NU3Rydjw/VKFTK2yxl96ZyecU5
	 gjEhHE0HJ/GN1J4OZO2cA31M=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D806540E02C2;
	Sat,  5 Sep 2026 18:50:40 +0000 (UTC)
Date: Sat, 5 Sep 2026 11:50:37 -0700
From: Borislav Petkov <bp@alien8.de>
To: Andreas Kemnade <andreas@kemnade.info>,
	Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v2 3/9] docs: kernel-parameters: Drop the edac_report=
 entry
Message-ID: <20260905185037.GDapxkfbPNUxJgaMH8@fat_crate.local>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-4-kmehltretter@gmail.com>
 <20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
 <apwzmSr6b0WEkW86@gmail.com>
 <20260905153336.GBapw2UFa7Sdc0ve_A@fat_crate.local>
 <871pb7zn36.fsf@trenco.lwn.net>
 <20260905162742.GCapxC_ra7hJd27LDR@fat_crate.local>
 <apxDtqM8UMN5KNjs@gmail.com>
 <20260905194720.7033b956@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260905194720.7033b956@kemnade.info>

On Sat, Sep 05, 2026 at 07:47:20PM +0200, Andreas Kemnade wrote:
> > That's for "not getting any answers" which is not the case here.

No, that's the case ALWAYS. If you spam maintainers with too often
submissions, you end up achieving the opposite to what you're trying to do.

If you spam me way too often, I will send you to /dev/null because you're not
the only one who needs attention. Just imagine you're on the receiving end of
multiple tens of patchsets at any given time and everyone needs to have
her/his reviewed first. You'll do the same.

> > Sending a vX update sometimes feels more urgent because you don't want other 
> > people to read your buggy old version.

That's not a problem - everyone sees when it is buggy and if it is not clear,
you can respond to yourself and say that it'll be fixed in the next one. We
all have done it - no problem there. And if you document it, everyone is clear
what's going on.

> > But yes, some patience is also good there. 

With the amount of work all maintainers are swamped with and no one really
helping them out with patch review and testing, patience is the only virtue
here.

> Well, here it is a bit border line. You do not have answers on all patches,
> so technically it is some resubmitting.
> 
> But if the main maintainers (which is a bit harder to say in this series) found
> time to review, than IMHO (also seen from my maintainer perspective), improve
> as soon as you find time and submit the improved version.

If you want an earlier submission, feel free to ask the person.

In the general case, though, one should do a good testing before submitting
and all the issues caught after that, one can work in in her/his next version
locally and perhaps even state so.

Maintainers feel a lot better about a patchset when the whole evolution of the
patches is done on the mailing list and is documented. But shooting out a new
pile every day is just too fast, too much, too unnecessary.

I sincerely hope that explains it better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
