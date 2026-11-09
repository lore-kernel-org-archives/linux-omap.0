Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215926;
	b=g6m1XfN19Rl4xhShffEGLAZHHh0mdBBOrczUmKEShq6eLreY48h/MsIkzmx596Z7KKNO
	 50imIOsfjtw2FM8GqEeP3W8ra5DA3j4FBkRlHQs2XFEdcdXrz9TzxiZgCJNs9kuRqdvUI
	 CoINfnIi+mMVdX3k0IuhjfPbS7QsLb4/kU0eFcyTQlPUtiwY9kqpRMTmgIvtviBXokfNH
	 Jc8135AT4OjBIS7lFNv4fvsUKv7QrrmxbtnFvU7RwMJgBfJ1oaGg8sAXXzDjPet9LVUxe
	 F7P1gJOlOQ6cmifnlew5zxCItRXjNAknlSrN6ZoIg9XIULgPoHNyFFjx86OAPy6nGRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215926;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=ZmQj+KIGHYR+clUmFk2f4zZI91LHwUPgeokLo/WXOJs=;
	b=V10ClUc0QEyEZ1Li26e54to762Yo5k0wpiV79UwEZjXa7NrqldX8v7W6yMmJR52Uvugx
	 YV67xWdHTIpXYD04DfykbQ/oA6CINHNaQ6SowozSw/w0V3GXZP6koF192vGJ/KmZX0r9h
	 GB/r6N4qQAhPN7m+X9WY7wXLo19j3X5tiqo0DLqbD0Cox1xb/O6QpKU/m8rk3MWCAGu5j
	 SP8HXm9Jq4WG6tqrcHVOwCLUm61pYBNABCdCxZoB+mLG06qmfvs/pApNitZo9Ff8YAwXJ
	 xqyatrklGCaQASEcI5ew514nAcn8poPhTLCscjIj9G6oLwimhY8Lu4f8Ej+HbxJDvCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=V2n72EHA;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368A606D82D;
	Mon,  9 Nov 2026 09:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3368A606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=V2n72EHA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794215901; x=1794820701; i=markus.elfring@web.de;
	bh=ZmQj+KIGHYR+clUmFk2f4zZI91LHwUPgeokLo/WXOJs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V2n72EHAdEf2m8Cpg7VN3YrMEwlSLhUK0DvU1eg8AerNwVE/KboKziHAZb/A1PXs
	 94c78APFvt2Gy0cI02+mGIHMbAegGgYomLIOFTQVN830j8vPvPsSVEaFp4DMO50J4
	 7rMLCzNfVeT4HjkrwaMuZpuJ55ymv7K/e1QHPh1Gjmyo46+p7oziAst+TdTVUUu/V
	 FTrnn2+As9ZJIE8cHXedQxJz6tEom9cYt3xBFvoKVN7sWdrJP2vKbeDR+KgyngstH
	 yrOio4nTNi5PhdMwwc0ZwbM4htyGpDGanKRldeat18jVXdOzBdA4/CYzB8kgt5PN+
	 K9a+kmJM+ur2ALxv5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK52q-1xCeNm379S-00UsT8; Mon, 09
 Nov 2026 10:18:20 +0100
Message-ID: <07e3660e-7f54-46f6-bc1d-7485a0289a8a@web.de>
Date: Mon, 9 Nov 2026 10:18:18 +0100
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gpio: omap: handle clk_prepare failure in probe
To: Bartosz Golaszewski <brgl@kernel.org>, Dan Carpenter <error27@gmail.com>,
 Jiawen Liu <1298662399@qq.com>, linux-omap@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
 <20260820154323.0a7c7929@kemnade.info>
 <tencent_A1BF4495D1F5E54524907BBA2A4ED480FC08@qq.com>
 <avFeZWgJgID5XA43@stanley.mountain>
 <7bv2kqb4accxf54nma2hm766tlk3cwocpi3rypgwfaqpe33274@ibz3poncjkqj>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7bv2kqb4accxf54nma2hm766tlk3cwocpi3rypgwfaqpe33274@ibz3poncjkqj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:S/bqJmmckyYBvYrrJVoz14doqcHv2GA8h6bjbEDTKKisZxXvdxr
 m8fSOGfGqppYnivSTpcoPPVHtxBxig+ZxT1p5I50DyO4BnHTmBTHQ0Xq3loMddUUgDYFvh/
 0W6/XUwkUnJSkxqsjHXAbuxrnSeGk1DOBd2TaEM9V68lqK8qZXeRsz6ZOD9/d9G/OMAlP9z
 5xUiimlpOOvcyfTOF4umg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dRnpdlUGs40=;kFrMEJtJJJ7xfY9Fu3h9iXdDK0p
 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

> Yes. Please don't spend time discussing with Markus, he's well known for
> nonsensensical comments and you're wasting your time.

Under which circumstances can the patch review communication become more constructive again?

Regards,
Markus
