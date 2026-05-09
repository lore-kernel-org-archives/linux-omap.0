Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148433B6F8;
	Sat,  9 May 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332058; cv=none; b=V5fOTooFtsO2GgtTummVz0k+Tm3F5nZUPEk2VbfmAMmyJ2N3mMFgNu4QasiIcDeTLuHdVoDGWS40oBevj1iHGMYkZIqOzS5TV5kdL0hSawtwwjl2opvMnGZ1AeyfJxLsZev2oMzE4WmuWazylQcd2T9By4KyFxCVYseTCj9JYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332058; c=relaxed/simple;
	bh=oogT53oBlNpwWQnjCTf7meStnZ+vCZK6S5CS4XxdH4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUMRoI3vJwPPJlNW0JXzL/E+x/8K69UiKvCh37lDkrfkpftAXWbs6IVhE3vEA7bRnfU2W4cqwrnEJw5Uy2Rvb/3vPHWRwz/ZrK/Uj/pZVDxgBjHncRXZ0WP6fgItfdJEQVFa8ob/ZOKSfeaSHFkwerOdF3HLHaX5JmoaA7e/0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=Z4xj14u3; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="Z4xj14u3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oogT53oBlNpwWQnjCTf7meStnZ+vCZK6S5CS4XxdH4I=; b=Z4xj14u33glyB4U355mwB8jcd8
	QA1eiWqGGxCYuE/+ETZXL14TGRiMa+mpPjjyhFDUPJeEIWlBOUnFY3Lr/frEJtFkPp/CpbWEckhbO
	jio+BrvWrsp2lJ+QwT6B1Lwn8OP7zL5hWk7ErLjYODkxxE79xsrrQJZm8yuyN2ugZb3Uijda4vm17
	LN3ZvgK8aMlxGqw2UWHlkw3sgC542O5JTAN1C2kU99jQC7PFaReTIOgz6iPzR9kCwr++qdxRJcEuL
	5mcXbeTKuqT/dQuUMsTbz7Cd05ChDNHyAYw3+wdWtXmaBbOEWTJ35ItD6uLEEwoGW/e/OQdcBhkif
	ebFErveA==;
Received: from 81-197-209-194.elisa-laajakaista.fi ([81.197.209.194]:41068 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wLhP7-00000003Zdn-1iEx;
	Sat, 09 May 2026 16:07:33 +0300
Message-ID: <21e1eeaf-5c8c-488e-89a5-123fc2cc7b1d@bitmer.com>
Date: Sat, 9 May 2026 16:07:31 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: soc: ti: rx51: remove stale reference to
 machine_is_nokia_rx51()
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20260509012247.14990-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260509012247.14990-1-enelsonmoore@gmail.com>
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

Hi

On 09/05/2026 4:22 am, Ethan Nelson-Moore wrote:
> The rx51 driver relies on the machine_is_nokia_rx51() macro, which is
> always false since commit 9b7141d01a76 ("ARM: OMAP2+: Drop legacy board
> file for n900"). Its presence prevents the removal of boards no longer
> present in the kernel from arch/arm/tools/mach-types, because the
> machine_is_*() macros are generated from mach-types. Drop this unused
> code.
Not fully true since machine_is_nokia_rx51() still returns true on RX51
(N900) and driver loads successfully both before and after your patch.
But true you may remove this test so please update the commit log and
you may add my tested by tag:

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
