Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FD3A4F30;
	Tue, 10 Mar 2026 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164555; cv=none; b=JmZeXl0IRs617//acnBwSWYF5en0s7drfdoVto8L/BilrNm3lW59+79ho94bV+gooY4i8uEuyL8Q2igVgQHf6HM047b/WF0Dg4y5N24Ih/kHtbs2WiktPiwy0Hlz9fAQKBVyYFWAeek143C44USGpXsPFYkmuynP3velUFfNftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164555; c=relaxed/simple;
	bh=nZZCEy4wd3aYdKAcqQ3SJUo1rkWVWoUAWHwEQ3iRFHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dexCqRjZUJ2mm0JG94se0txjZGILfyH2SNavVG51lYUf9VVlegUXxBNAh+mscJ+PtWn6on3tCD0acNKLQ8V+zaGvzAvTH0C4UpkmgNESHQeK50yh4BDWA5/qXSCXlntFnIkbiLYEgK6h3Zjws673dhIfrnFFZ8c8HAqMOP4DuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=KWA6MFyO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="KWA6MFyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773164551; x=1773769351; i=deller@gmx.de;
	bh=rt1GjkhdSKgeoYE8V98nlJFEbV5nl90y8YIGCW/ayzE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KWA6MFyOzPudjYNuLvDYBEHp5oQ2fODBPNZwtVyJGAc526QotOJWpoaYTx7zMfjP
	 R9MQd2LA7GNPDLiOG8KoT5UZ8LR6qxnwIbUmjuDmirvG70nED0X6sYk00W6BTaskM
	 3w4mk8bg0zt01qB36L6zKtxY/kXb3+7lUZp+HB970Kykbz178H+oxFFANVc+luoQa
	 92daczSUq3ABEMY+0D62GowOLfzEk3zWUI6b1+xOvcOO16eptxsQQrMdgBLz9a4W8
	 28iyDU/QZGA6O/zNJ+9Pz24WC2fuYFXkyyMvTwQLrGkindU1tM2iHBFsGIe/ZLPLD
	 8nmErN/E3ROgJwXQhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwbp-1vtieM1R7J-00A0ms; Tue, 10
 Mar 2026 18:42:31 +0100
Message-ID: <b1418319-63d5-4f1a-91dd-ea2e0840663c@gmx.de>
Date: Tue, 10 Mar 2026 18:42:30 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: omapfb: Add missing error check for
 clk_get()
To: Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org,
 linux-omap@vger.kernel.org
Cc: tglx@kernel.org, mingo@kernel.org, dri-devel@lists.freedesktop.org
References: <20260310085625.2648545-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260310085625.2648545-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T4npeP+mM3tNyPESTHgP7fv5WK9LAFagrXfWVmP1Bv6A/uiQPm5
 gLdIfxK05jcZNkNTU025426Uj0/Qdh/wuxXA94RardIOSdK7GEzhrZb903q34LasXsXDqog
 iiTteVhBEDzgYFhJIcwuFcHTMaHKYcI8hUzDu2bMJjEXS1GSmMXGetxg9t6PlmcUj1iQJzB
 1ZElfX6U18mGo+bYiZ60g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8fOD/bNNiEA=;3qP894WWdmKbGQg7n9VgSf9M7+h
 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

On 3/10/26 09:56, Chen Ni wrote:
> The hwa742_init() function did not check the return value of clk_get().
> This could lead to dereferencing an error pointer in subsequent clock
> operations, potentially causing a kernel crash.
>=20
> Fix this by adding a missing error check and ensuring proper clock
> resource cleanup on failure and driver removal.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/video/fbdev/omap/hwa742.c | 4 ++++
>   1 file changed, 4 insertions(+)

applied.
Thanks!
Helge
