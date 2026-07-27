Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F520432E7A;
	Mon, 27 Jul 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174402; cv=none; b=S0uANQPJR0vKdRWykTb+O8Hf+ecIfGoP/cAxw+If1i2XhxTNGi1PLlvEl20L00lLSxbB+u09bcK9lAIML9HMG+fSHY3uiFzuJNBXb22WnWpZgBaK+qSUMuoYkkeZ+R8i3077cQkAA09eSvXxuqB4Dd0EB+ISVSZNRmpYETAvtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174402; c=relaxed/simple;
	bh=wjp4ntie7u68r0keH+uJQ0fDqDjHzf4A7Vm/mmhFnX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdlUgBlSwq9W6NgMNwpRsXr/JycuzYWzfNZkTTFlJaW4ecURW9Z43iV7I4gb2h0rPLEvJfNSy8GtUg0whyBIIf4/s+LJEdm6hwOnsrWY/3+o8+RBrhiTCAZacHYXV+1LSqrignxGQsJTq7ZolELT/2maLvp9g/PhEhEFCq2wG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=LXh23w4d; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="LXh23w4d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=waU9u/YgOeavZJ3O7FteGXSqfKmVNEJ1LKNCB7sORzg=; b=LXh23w4duvKvhGORGH6NDwYatl
	QHk75ZdOWdc7AO7HjLk4rnQk2NtgPT+LEKryk9ieJnkhjNHHXqgSZXrpgMN+leeMmOQNW641xsOV7
	266Qngn+9g2VKSXivW7E/mh0ksykVSjb+wntqErN1GtVMnl6v8n+1VSNwWyV6ZgorEgmzWx/T2NhW
	g4/vFIOqLd0+L/M93dVMqDCuCDmsGB9nO8ZcDHFJSVNbpbqObWlB6vDk+eZbiGSJxHsNtuKPf3m/V
	OzvxA3AbXrlF5kmBLfcQ1o3PpZ/07TlhZAaufkhVjPXuKnzDnlE8K8rfDfVOZA48vb8sIBv1qwJAr
	VC2KE+aw==;
Received: from 91-159-18-144.elisa-laajakaista.fi ([91.159.18.144]:45308 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1woPP9-0000000EPYy-3cPY;
	Mon, 27 Jul 2026 20:46:18 +0300
Message-ID: <b95ab53f-12da-4ad9-82bd-f5248c237ad3@bitmer.com>
Date: Mon, 27 Jul 2026 20:46:14 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: ti: omap-twl4030: drop support for platform
 data
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
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

On 25/07/2026 2:34 am, Dmitry Torokhov wrote:
> There are no users of omap_tw4030_pdata in the mainline kernel so
> remove support for it from the driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  include/linux/platform_data/omap-twl4030.h |  42 -------
>  sound/soc/ti/omap-twl4030.c                | 134 +++++++--------------
>  2 files changed, 44 insertions(+), 132 deletions(-)
>  delete mode 100644 include/linux/platform_data/omap-twl4030.h
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
