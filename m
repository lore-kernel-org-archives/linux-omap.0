Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F04CDA2B;
	Tue, 15 Sep 2026 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499127; cv=none; b=WY+YVE21ZC8smaazrim45RHNdeuuHnUlwvje3YVjwB9q0zixtEsBSZwR5BMEz5dEfRdSjVeGl1wL/q7qO4z/Ej0XccTfmSNtAfTF9eFw2dP9/mQju8/3qkuNcSZHaB43ouTImiK4+1QVt2zw6z/N41a77o4mdCQYPG+4PsqjbsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499127; c=relaxed/simple;
	bh=n3loMqr+GZfBR6Ve82tKdG4Jkfg6eHJMDQWbwHfIQpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HYe7PQLPjCSi899GSbXwGJTvRh+L7jD56P+VkfDycOwYQw1UHMiYlldatj8Y2flIEaHmLutbaipJVARuJf5UoxYn0eOOWDFxau2o2LDARyeLRFm39pddHQouzfcMKcurz+SDt1NSE8pCaVfTsnm7lOviBjQfvpFeedK1awTx44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AezeimY/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AezeimY/"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B2E62408B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1789499125; bh=s1U6htYr3KDizbM+pvOno5keAAu3JxFYL37YugBOwe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AezeimY/EDjo3fPXgLQ44KDX5OPDDr1xgkzE1EhmKpD7gPcaQSQjTSBElZiXRAxkA
	 KILGB8FKia8q5oNdr52WrUsQ98GO/HtHsqLdegw4wrlygVFdOuGgh9g9snNDr4/8xu
	 3nvYU1Vx2XmgdCGifzb4oYWcVmckQsdkkneZfv9nQVhXlKHvuBuFghnI5XGCItVg/g
	 ZbyiL+JDMXAEQJLWXR3mnwgj5xXni5CX8KEjZWj/8+FYBxZMvVy+Lx9PB0iDEc1rxP
	 2yXvNg8nDcC3z1IJWmSFuW7cFS4GUm3/ZxZF6K/VLoGUYXIlJW0ebXouEL15PEJbdx
	 SQIzW0KKooMcA==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B2E62408B4;
	Tue, 15 Sep 2026 19:05:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, Mike
 Travis <mike.travis@hpe.com>, Tony Luck <tony.luck@intel.com>,
 linux-edac@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, Dominik
 Brodowski <linux@dominikbrodowski.net>, Michael Schmitz
 <schmitzmic@gmail.com>, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3 0/8] docs: kernel-parameters: Remove eight entries
 for parameters that no longer exist
In-Reply-To: <20260910013245.8619-1-kmehltretter@gmail.com>
References: <20260910013245.8619-1-kmehltretter@gmail.com>
Date: Tue, 15 Sep 2026 13:05:23 -0600
Message-ID: <875x069vyk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karl Mehltretter <kmehltretter@gmail.com> writes:

> kernel-parameters.txt still documents eight boot parameters whose parsing
> code was removed with the drivers or platforms that used them, one of
> them (atarimouse=) since before the git history. There is one patch per
> parameter, with a Fixes: tag where the removal is in git history.
> Each entry was checked with git grep for its __setup(), early_param()
> and module_param() handler and with git log -S for the removing commit,
> and the name is absent from the whole tree at that commit.
>
> Changes in v3:
> - patch 3: name the commit that turned edac_report= into a module
>   parameter (fee27d7d9788) and the one that removed it (7fc0b9b995f2),
>   Fixes: tag moved to the latter (Boris)
> - the pata_legacy patch is dropped, Ethan's patch from June covers all
>   six parameters that commit 3c4d783f6922 removed:
>   https://lore.kernel.org/r/20260607064053.195166-1-enelsonmoore@gmail.com/
> - collect Reviewed-by and Acked-by tags
> - the "Found by cross-checking ..." paragraph dropped from the messages

I've applied the set, thanks.

jon
