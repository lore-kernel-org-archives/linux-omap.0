Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9D1C2AA;
	Sat,  9 May 2026 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332941; cv=none; b=Qbx7eAHgM+jtvf2COK3iPqIKzK/GoA1RL3dxefBkfLBDf8/zk8SJII5c3WvIkqPhtiqa1c06L49gMK+oSX+XQ6R2cFIDy+idHsaMU+clrD7IZ5x6tAi74RBFV3ZJD8aQjRqmyRnXpT6qG/9IgJ+e4wkKhuEdwNaEio6VpWLgP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332941; c=relaxed/simple;
	bh=r87L/QhMSyPEFz4E+RNZi8usUnbzT8vVSCEIgvVOrKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Em4Zg0p7+KLGjMnZ/QSN1szvpPHOD9em45cnI1lUkzK/JgQ9/epZPNTs9+DU8O6GRsW3feDXLKeB7UUMiravBFTI+NhiEdCFC5dVz34B/n95uwB9xaMtkTp+I0C+hzldNvyM+z8M50ngv5TXLkaEqR0e4K2h0Mtd+93ht0yjqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=gzUJ+U/I; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="gzUJ+U/I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gxHVMVhWzbY939TV3LHWPsjJaPCgZqkO2X1e99twetI=; b=gzUJ+U/Ix2orqlaRMkVDUGBGZA
	9O6pZ3R7eb+FKJGTdVurQp45q7OOF2u7fhDV8kL9WQtydGztEST59ViTmY2H7hUdAcrORGULPmcQg
	PFn6Z5My4MwDy4BS8S15kpwQlIkkZo4jtanUDZeM58HySmsKXm2ZBp6J+JdknVxYDamEw22VZCFeg
	rY1JG9BldysXmS/TBQnQ7Rpq7q2NbEg5tKRyE4GyDX/ODamhEOIm44iNdk6LdEqO77O9ZM96B1opd
	4a3x28toN3/75ACnjyI3/g/65Rzv0j5UIoK81WBrAhsmBiADLlq3Q/0vt+MIvwzf9qDIiTqVUOflu
	rl80Mv4Q==;
Received: from 81-197-209-194.elisa-laajakaista.fi ([81.197.209.194]:41400 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wLgl9-00000003TCK-24Ex;
	Sat, 09 May 2026 15:26:15 +0300
Message-ID: <a92bd92e-379c-40d7-afc2-6cdb6d58d09f@bitmer.com>
Date: Sat, 9 May 2026 15:26:10 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] ASoC: ti: omap-mcbsp-st: Use guard() for spin locks
To: phucduc.bui@gmail.com, peter.ujfalusi@gmail.com, broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
 <20260508103837.138142-7-phucduc.bui@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260508103837.138142-7-phucduc.bui@gmail.com>
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

On 08/05/2026 1:38 pm, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for spin locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  sound/soc/ti/omap-mcbsp-st.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
