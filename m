Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30325374182
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2026 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773829891; cv=none; b=FgzOOSUFbvoB6rr6Jv/M90P0pxb8MMRImc7P6F52sDfAb6e608WxuUQftCbaewgZ7Xw89TrRdgLpPip39Bib/9FMOFDbUG/2xJV5oVRe9gGeNWRGvLyNtS6UeSRJgY92LzAVZsn/RGy+Cl2+wvRVFIa/keqSAmTnmjrH5Yw1JBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773829891; c=relaxed/simple;
	bh=tNz2zKgiIZ4b1XgW/xgqhkDTe7RnDJCiXkFfoEfaLTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL+EszJddC+vlBayQHQ3Jj7x1kqdQFNgZdeeO8YsIoxmrKQ76XTiBN6OAu4NkEotBvQJjyxEE+y4on9fRvRmLYhBEiek4pb4dDUbU42G2XjasEmmW4vPgjDb7HWEda9lMcBj6DKtK5xhFayMGuryO3YOa0fhAaVziiTaDK9yQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=j0+If8cX; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="j0+If8cX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=rnzd
	zNBShor5SsCSqm500KkuoYe6Fk+7EQmEipEUtYE=; b=j0+If8cXjhMytAuuv3jW
	symnEI673OxAipEnveU+8nsBw/z6ifDnQoZG1Tyr6Uju1kwDt8iDohWo/idrsNEA
	3ko5H9oRd3IAsn2ZU3XurgHC4R1rm3Il4M2A42M0JDsiwDeqDNNmpYiqZGJ6PR/U
	Lv2aQXzwdztSFpRROlkIRhb9S+J40Tn52TAu0AhTU22xbdbwxBWlKHyoAE33UqaJ
	SX8eTW9uDSpvGYcVOF4IE5699O/OX9ZNUSbJytWt9FuICEIFFgosMADLiu+zF+UR
	TLC3I3GNnrmpjH70/bQBdszMDNS6E49Dk20ySM0X2RfzvYtZOxC2GFahdHfgcIGN
	6g==
Received: (qmail 652465 invoked from network); 18 Mar 2026 11:31:19 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Mar 2026 11:31:19 +0100
X-UD-Smtp-Session: l3s3148p1@d+DX80lNYtsujnvy
Date: Wed, 18 Mar 2026 11:31:12 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Wilken Gottwalt <wilken.gottwalt@posteo.net>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 04/15] hwspinlock: add callback to fill private data
 of a hwspinlock
Message-ID: <abp-8GlLkoBAUJj8@ninjato>
References: <20260310075539.11701-1-wsa+renesas@sang-engineering.com>
 <20260310075539.11701-5-wsa+renesas@sang-engineering.com>
 <dd21653b7343e261ec9c88c622c5facbba69df95.camel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd21653b7343e261ec9c88c622c5facbba69df95.camel@foss.st.com>

Hi Antonio,

> this API is described in Documentation/locking/hwspinlock.rst
> in chapter 'API for implementors'.
> 
> Changing the API parameters should require updating the documentation too.

I totally agree. I missed that.

> Since this API is changed again in 10/15, it's probably fine to update the
> documentation only once in the last 15/15.

Well, the changes are little, so I will change the documentation
whenever the API itself gets modified.

Thanks for the heads up!

   Wolfram

