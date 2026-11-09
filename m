Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215283;
	b=y0qu2eQobQi8AshrzgenS8tx/IvVTLGsW8R25pXAz0o3v7WBUptfeMt1Vou2XclMOmMm
	 oB4xxofxKVlq9NH/hqZ6/7Znt2/wbVG70CDJBS3EdLdBTqjrPZBrnHBRvp6nQMXt+yGra
	 hAUks0dQgR1CA1vgkQKdAuAIRikOeKq4ZCCSYGFHgiG7klX6O0DAsufJfFFFSCuoCl3ni
	 YfcDqZq5Pb1q1J1gb00Th8jrkVD6Ryitv7pYq04iTMsA7xdYFMkFOUEiTWi/xazEhQyxb
	 vjDosagF4k9w6Zo6CyYdKYnkDG+N0BTkq5Q8tE+nZq4R7HTerrErtGj9fjBZTzeVwnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215283;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gGH5WQC7n7vzUXd0nfa+o5hb82329Xqqb8HkiaIbfeg=;
	b=UmZBwx0dX6kw4dslt5gSRazbwepjekwenj8jirkhDaW6CjI+pRUhchrT9QciuSuBi0s3
	 d8Bh6EBVu2PzpY5oQRFpn4s02ffPqKqlk6UgS/+ijLBBDgXKvGW9eaaHAYvbouDjXPpxt
	 RH4O2chYHu0Xul3BizQyLA4O+oaubyEIm4i6uySCPpqJeLFi86b2TRq4fQJ5ejj3SOJ4E
	 e1EXJHh+GtkJUltcfs4Vv/q1bWfod5yV0dXHa3VSrdJR8c4pP6uvxLQcVYJ3pViF1MicJ
	 ZD8SMdLxXNzO+JEFC6D6SPo1wHBi/IQ/5NCn/1KFp38CHAtHCUHl23ST+9IijUFxr8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDjrwnhm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A98DD606A31C;
	Mon,  9 Nov 2026 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDjrwnhm
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ABF381F008A4;
	Mon,  9 Nov 2026 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215283;
	bh=gGH5WQC7n7vzUXd0nfa+o5hb82329Xqqb8HkiaIbfeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YDjrwnhmbacmI5fskK6AS3ZEpwjytE3KXrchjoeaDbZE+sOZQAilUs5pBxcCa8YjH
	 rJ9ksUtWme5yLQqrnBZbENKvj/3hl2fCf2Qayd9GicQObgrjZXTIVS9Xkzbb3TUGTL
	 3lJAB6e7r7uI1JryroKSteSDvabFEjE7wmb3PVi+d7foBw/XyIG3gMd0v5UYn7Wu19
	 jUrYate4BoPlQhuCoMe42av71fNcY1tA3Vem8/oSE4CnYHXtsRt1NotJCwAkPIVOXM
	 8JCaCzBQhWCCONDCNy0FhDK++gFkJfBJHIDbMB3kDJZ7I8+6VgteiLUMT0HfpnH0mR
	 zw3b1TPaUJavg==
Date: Mon, 9 Nov 2026 10:08:00 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Jiawen Liu <1298662399@qq.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org, 
	Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: handle clk_prepare failure in probe
Message-ID: <7bv2kqb4accxf54nma2hm766tlk3cwocpi3rypgwfaqpe33274@ibz3poncjkqj>
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
 <20260820154323.0a7c7929@kemnade.info>
 <tencent_A1BF4495D1F5E54524907BBA2A4ED480FC08@qq.com>
 <avFeZWgJgID5XA43@stanley.mountain>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avFeZWgJgID5XA43@stanley.mountain>

On Mon, Nov 09, 2026 at 08:47:17AM +0300, Dan Carpenter wrote:
> Andreas is the expert in this context, not Markus.  His suggestion to
> use devm_clk_get_prepared() was a good idea.  Add a Fixes tag but a
> CC to stable is not required.
>

Yes. Please don't spend time discussing with Markus, he's well known for
nonsensensical comments and you're wasting your time.

Add the Fixes: tag as it is - after all - a fix.

Thanks,
Bartosz
