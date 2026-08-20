Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039E2E7396;
	Thu, 20 Aug 2026 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217553; cv=none; b=ehA5vJHD4m3tYxq7i8F5OMPDRLFHE9+PV5BzsWRRHvlez1g7YFjwr0qX3Pvzn1VPWSAJ20QN2ERDMl/AgWvyu1diTv01KUl+/rxbdqjCtPo3g5CmIU9m9murR0wPRq0jM6TmMNmjjLE/g1/VIpwzDrpHveH6/UzCoxggJOpa//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217553; c=relaxed/simple;
	bh=AT83Z4Y11R6HpQN94riw3nAQOgYdXCMgDNXM/p5xDlU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QMJkuqo+3heE13+Cc1BK343Iyn2HQl3IlBzVptg7/SwvymRxyc7Hw/gU0sQusxL5H+hSUPyLMJShsNFZSHRtOOmPdmwOvNws117j/I5U53sl9UHgdwiBrAoAoc1NmPSl1sMRU0YWDxSJF36jSGxIjChBICIPhWi+a4i85PI0Zvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=v92vvLV9; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="v92vvLV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787217542; x=1787822342; i=markus.elfring@web.de;
	bh=AT83Z4Y11R6HpQN94riw3nAQOgYdXCMgDNXM/p5xDlU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=v92vvLV97op9eIXkK+g0z4m50diKVdZDNyOa9VGvLn6GzWIssclMo74b60x8TAjK
	 a3LbsSIZGVtv3uY+uwD+FbkXLD3wHzj4h2L98/oDUmfpyIB3ugHlNX3XWewMpwOEA
	 QqP8lse0VWTdx3zqZqM1gwqJu8aJDMeBIoU2S1LqC7FnPpTnMYEWpgsZ00lpRFJjW
	 FKSsl5WDMeRkqq1BDDCsICBXwg2puYwu/lm3ErsfKsfNTIff3GAc4C/xh32sYUlsS
	 AdSXIly3lHU86fdXsI90p6DColpPU6WHWt32fRfsenHF5BxHl3cq4ExlOIeMyzel7
	 HedCpWMPKPNUgBj0gA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1xQ6fg0vZO-00If4D; Thu, 20
 Aug 2026 11:19:02 +0200
Message-ID: <b610718b-3c9d-4417-b1b7-69f0ac15dae1@web.de>
Date: Thu, 20 Aug 2026 11:19:00 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: 1298662399@qq.com, linux-gpio@vger.kernel.org,
 linux-omap@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
Subject: Re: [PATCH] gpio: omap: handle clk_prepare failure in probe
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a7OJxHeEZJAbj7dMZaJtDTmR8KRtjhAu3kgPmckqPjVA5XW+WmA
 HcIzIISPOOJW8oT3KisluIQwnWTyk/EoSX3BuSx1G6gBhM1CevxbC2tHik140v0AamiAUub
 QOlIx2mRrd4FjPeGPVZJK6rtPWRqdR7Zd6R4BI5fS954eT3sgh7C305VIw54AM/j/sA3tm+
 4LFbVND34x+//nKKiTiLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7niF8XAnIGQ=;ckczkKxRpoJij8wQYDcBPbk8piy
 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
 osJYxUpVHBpQnf0+h5C1N/kCZBIb90y9

=E2=80=A6
> Check the return value of clk_prepare in omap_gpio_probe. On failure,
> clear dbck_flag and return the error, preventing unbalanced
> clk_unprepare in remove or error paths.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n792

Regards,
Markus
