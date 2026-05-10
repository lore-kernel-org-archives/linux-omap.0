Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B601607A4;
	Sun, 10 May 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778415795; cv=none; b=bCWMLwdYIbJURiWBneok0SV6UHyfNcq4iB/z+kLQVO00z8eHg9ylFQB1d0lgBgWvyoKdwJZLv7i+zx9okFfJLpuwrV86/zkf7e7iFrJi2r7JZhEdmLe9gmlNYmYaL2cbL1JCHHcppf1733rpl24jUpy6SM2lmFwGi8vyKjPE43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778415795; c=relaxed/simple;
	bh=tyEWJ4A3IvcI4MHUF3EGIdSbxUnffM/VUaiQmwIg3I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+cdL2OERI1DyCIOp3yI5QIqIV/QPHXDOyBOsB/lyOTFuV6ie/wMrBDyWra45Ml2G/icpWYO/TIbQDG5Yu+MgUuqM6GzMEnQ0hjTB6HTVUE6i1rBfQJez/oX3rNLJgqu62ObXwg1oE3OxTYrHaf7wjXAsd5hqeEjGghB1BtvS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=cmfnR8js; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="cmfnR8js"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uuSB8y8BQGXRiaO33RKYN8hc1+aqn3ltMhU/ueaUSvI=; b=cmfnR8jsxaxC3vqE/V/+HqfAkK
	Fis8ikPlXAbH0/g9IdpV4fQhLDMSSLGQBpitlHFp+6Ax7sZpcMnReMsbW/yrK8wuACx5i+AKbTpyu
	Iz+3+FTzns0VumloFymTJXlt76LDkDXVoCneV+rRD/nz9PMBghjkh0CWG8d6HnfXWI0V4XOmtSt5S
	2cBWoxsXRpacYYz5SNPSD9EQfAM3SSMAcScr1rrklPckMPd/kL1NQ0UC2lR96V8c85L6eHpv+QcqO
	UlAaNtSYgO7fYCDyQnpkS/E3h2k6AuxxDKpU+f5OwHL+ySMJwmuAnR2/4/4UWzCztR9PgMnpDgo/C
	FDVIWjwA==;
Received: from 91-158-0-77.elisa-laajakaista.fi ([91.158.0.77]:36542 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wM3BQ-000000074fG-3FZp;
	Sun, 10 May 2026 15:22:56 +0300
Message-ID: <0cc395ef-0b8d-4905-8186-e9e3ba129662@bitmer.com>
Date: Sun, 10 May 2026 15:22:52 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: ti: rx51: remove stale reference to
 machine_is_nokia_rx51()
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20260510054214.564950-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260510054214.564950-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - wp23.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bitmer.com
X-Get-Message-Sender-Via: wp23.hostingpalvelu.fi: authenticated_id: jarkko.nikula@bitmer.com
X-Authenticated-Sender: wp23.hostingpalvelu.fi: jarkko.nikula@bitmer.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 10/05/2026 8:42 am, Ethan Nelson-Moore wrote:
> The rx51 driver relies on the machine_is_nokia_rx51() macro, which was
> used with the legacy board file dropped in commit 9b7141d01a76 ("ARM:
> OMAP2+: Drop legacy board file for n900"). The use of this macro
> prevents the removal of machine IDs no longer used by the kernel from
> arch/arm/tools/mach-types, because the machine_is_*() macros are
> generated from mach-types. Drop this unused code.
>
> Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com> # v1
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
> Changes from v1: Fix mistake in commit message - machine ID checks
> still work with DT booting if the bootloader passes the ID
>
>  sound/soc/ti/rx51.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
