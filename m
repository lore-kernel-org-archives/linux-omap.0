Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F41482E8;
	Thu,  9 Apr 2026 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723392; cv=none; b=TIY2iHildnvOH4z/tsbC6I6Ki/CeWaIOK8ufFFMUSIHvb/PO5/Ontpt/ZF4moa9THy29JNTg89jA8og+0pW/l+semQS5Tu0/AuqBN9Qk7Ox4hd+6ByUY6MQgs79yHya6JZmcbkxYDB0Ghz4nJHZIIZTt8Pmn6rwhDFbmFIDY+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723392; c=relaxed/simple;
	bh=XOjAJs+G9xc6Hsl9wta0zWEFQ8AW0gv0mmhf2mZhEhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lq9jzDTN7adwOSn2FbrWScTM25Rf4QNGgYAQzdtFHJalaSJsG8Sw6gi6qIFhIO8UWTpznmJpty3HTVl8/pAGObFR5jNtrczJvkjn9ev+by6EVkQHkwDLpiagQwsRp65qLDTfVweu6byiEkTAZZzDpWvbq2TDuLN2Jc+ypeHzA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=O5TAypBw; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="O5TAypBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775723383; x=1776328183; i=deller@gmx.de;
	bh=x1YG21KYrVNW4RjLM/WhBPGfetxFZToXEwOTY7bLHok=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O5TAypBwnN2l4n6a9MFws6LKM2nu6pLHtWxHqezcNwixFgKlp2saCD/fOI8drIy/
	 XIIO3YSY/Ab1CV4vVkIaHNxM+QU12YJScFWa4kPdIWVtBkblAfzydw7RXJj5b3CtY
	 yRZE6z5U9G1eKz6u8rVB28TjXg/gnUsEPJQlC9fxOltCDXTIvK/kpWV3FE2/tl8VZ
	 P0NpLJdhhujuOAz9a5A031tySbqf4z4EqMk+HGR3uUQulAx0UH43Sfolq6ij6mE+W
	 ohkizk1nuTsvwpiV1qR3cqy7FJQP5qVmqVVQBDaqUhwCOaYHRK+EroQsx7XBdsHp0
	 6nQVRryWlzETMBad0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1vDzm52goY-00tawY; Thu, 09
 Apr 2026 10:29:43 +0200
Message-ID: <44ec798c-7b7e-42f4-8e99-a34e49db7dbf@gmx.de>
Date: Thu, 9 Apr 2026 10:29:38 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: omap2: fix inconsistent lock returns in
 omapfb_mmap
To: zenghongling <zenghongling@kylinos.cn>, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, zhongling0719@126.com,
 kernel test robot <lkp@intel.com>
References: <20260402093403.12173-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260402093403.12173-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zFGbEmLWzB7eoSYFAnGbJRHuwSDBpDPXz0qDq3XQqAcazXhUkp0
 HOVRsXbOH1Vva2/ZjV94jyYhZVNtfNDm3n7e5MsFYEADDAXmBvm2xuf7JdJUNgkRCLc/Wlv
 VS26C7njUmIgwrXPD/KfNXSA2Tgdqs4UultoTzUp8FrTEX/TJ4fjrAhkIapg+VpyWuQycsX
 OUEYkaDEIpkex8scx9oDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+nI7NhC11Uk=;IFwHoAdCajX9FyOJVHjuV/gXHZw
 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

On 4/2/26 11:34, zenghongling wrote:
> Fix the warning about inconsistent returns for '&rg->lock' in
> omapfb_mmap() function. The warning arises because the error path
> uses 'ofbi->region' while the normal path uses 'rg'.
>=20
> smatch warnings:
> drivers/video/fbdev/omap2/omapfb/omapfb-main.c:1126 omapfb_mmap()
> warn: inconsistent returns '&rg->lock'.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: zenghongling <zenghongling@kylinos.cn>
> ---
>   drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied.
PS: I replaced author/email name by "Hongling Zeng" instead of "zenghongli=
ng".
I assume that's Ok, if not please let me know.

Thanks!
Helge
