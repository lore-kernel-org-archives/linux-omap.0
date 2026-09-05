Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E634AE10B;
	Sat,  5 Sep 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625259; cv=none; b=pv3zVjk52Pqyq3e4J6+D4VD4w/xloEdgdmRWOYxXKDexBIiHAbEi9D7RcSRx/naKRYBDTtxX1BHiLm5ryZVmatUQDpm+7BBIqP76t47KjVWtqTiT2po+dJ3hWUflChNt3Arf66gdCFTt1utz07Mbkwm5/IaHcSnvDFI4/aZTNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625259; c=relaxed/simple;
	bh=McZeKmb8S8b/EC01Rk3flMGccUxy2bR+WNWnXJHZ6iI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZUm1fzwYDXAbd4n0T7JUkKECtT+ZCR64LNglR2jqGWlqAFTTQxWMXmZ7Gz4Giu1QD7jYY12kiLGgF5tj21PpuBAgW3E+k8Uamz/dur1UXMiL0bU0lUG16Po7HXnurqreF9sFaskLjKK6XM60Oj1WXARSf0Bas+4nFmVi33ikdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bUAoDXsd; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bUAoDXsd"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2BC38408FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1788625246; bh=McZeKmb8S8b/EC01Rk3flMGccUxy2bR+WNWnXJHZ6iI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bUAoDXsdmYjhQ1V6sI70RhBEPUxCMVFN6mewCFcVJeyG7A/+u2qfYBxoH7asY6VfX
	 um+dCoRUF3bO4UoWaAAEvUtoS8SpEFi24ATL/58iyj82oF4wSoEH2lksYAutczozDM
	 JHDNKg0BH3s/Xx46Jl8YSXDQE7DKj7MvKvOKI3cdLTrCot2NniSV0Z1dRsNKO3cFJO
	 oVfy0VBdIrB//r2zOd6OJIj8w1hJXhOjF1ew/LB0n0aPwY4LvlyBWfVwzxl2LVmRN4
	 s/Wq1x85OD6YJPnXRQIMiuA9dMtwgx4Ro959cZSs9xLNr37TWo/mtJUR1dO2uXTZto
	 XIorzXF6YXxbw==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2BC38408FF;
	Sat,  5 Sep 2026 16:20:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Borislav Petkov <bp@alien8.de>, Karl Mehltretter <kmehltretter@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Mike Travis <mike.travis@hpe.com>, Tony Luck
 <tony.luck@intel.com>, linux-edac@vger.kernel.org, Krzysztof Kozlowski
 <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-omap@vger.kernel.org, Dominik Brodowski
 <linux@dominikbrodowski.net>, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, Michael Schmitz <schmitzmic@gmail.com>, Andreas
 Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 3/9] docs: kernel-parameters: Drop the edac_report=
 entry
In-Reply-To: <20260905153336.GBapw2UFa7Sdc0ve_A@fat_crate.local>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-4-kmehltretter@gmail.com>
 <20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
 <apwzmSr6b0WEkW86@gmail.com>
 <20260905153336.GBapw2UFa7Sdc0ve_A@fat_crate.local>
Date: Sat, 05 Sep 2026 10:20:45 -0600
Message-ID: <871pb7zn36.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Borislav Petkov <bp@alien8.de> writes:

> On Sat, Sep 05, 2026 at 05:22:33PM +0200, Karl Mehltretter wrote:
>> Good catch! I will send a v3.
>
> Just don't send it immediately but wait a couple of days to gather review
> feedback first.

I would like to emphasize this - slow down a bit and maybe you won't
overwhelm the system entirely.

Thanks,

jon
