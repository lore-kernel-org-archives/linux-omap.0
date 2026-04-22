Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D2282F35;
	Wed, 22 Apr 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868266; cv=none; b=VxrY5xwZApBcsBCnHs07G7iaaK2D9T5ghIbpl7YT9R7DXU1fBaZeu66XcYyZoiN6eC/wqk2v9U7xH64XQGWp7Bhi3r/NdnZp1GbsZ1/nRzbt0UsQZBmwAxa1yK7t2DSqEnriEOQAFyEa2Zat+f0x+Xg0dB2hyH9ad/1DZwMcWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868266; c=relaxed/simple;
	bh=2fwHBIMl8RpzbnmQ1cLrtUvTBFqdqbk0MK2G0eYFxqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pAm21WzvG0VCWWOduTABNPak+t1qp9nx0ownA1niHcRWq7azDR6yv+fHYQD2rEiuJNxBrzj+GFzyNfaIDzwQkgbw8Y0OLPQP1qGEFd+RPDXRAObGiANn6f+EqltD9P05bYrOh5NzsDT1sM3o9JDpb9ohHiRug04kYqegqzqfm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=F5aKJLS8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="F5aKJLS8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776868256; x=1777473056; i=deller@gmx.de;
	bh=1TifOBYq5qKEW2JoIG5bn0chXPKkPUHqrW+m9iGb/fY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F5aKJLS8XxozbqgsuRmsKRKtKhXi8ZinCHU/6Gl2UcKsfk7tn9kknuL+jLaP9IVK
	 wxVNxjHWd1A+wxfzoAfU3xsTfVMMrm7tWaSuIfj8OD+2tLCMdzs8QRulhTosXtn1l
	 MlkM5gErKqL7brqj4T1fESKEAz93XzDmcEY4dnZ+eT21M2/xuY6w4eshMv0iqjkLG
	 i6KH9bWwaFl3mNdHlmzhbaRJD+tRaPbgux++ytuid6DwF/2iHfTBTR6kDg7yj7esc
	 cQrS6g9VaB1xnemSm9k5bzrufPgESGtbitbCKO1GGQ8XzY3LqClN5UBdE0dkgu7RJ
	 zHzf6zjD632V5JOPaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1w7c7g3Brv-00263p; Wed, 22
 Apr 2026 16:30:55 +0200
Message-ID: <0bd64a89-6530-4447-8a36-01f8803728f0@gmx.de>
Date: Wed, 22 Apr 2026 16:30:54 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: omapfb: fix reference leak on failed device
 registration
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org,
 linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260415191747.3845525-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260415191747.3845525-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:93PmKDn862vVQf6jR2ehVxPSOwFuZJ223ciE7y/JKE5/wrDBRIT
 CI0476txVyh5LyCyZqjWikTTVOZBwiDwDEY1CgdCGoyWN1fxFf9PHYf8NevXhi80zDNMpWW
 7fWBC4POR/sGRc/Kv0q8PGiKx5OiYbKQzhIoaXJ1e6M+KIpnczI8TL3pKqslyWPqAjvtqwK
 QYBv5LFAc7mC71W02ubeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MzvukMqzYp4=;V0ZeGtICTtarAw/fez0u72MyAPX
 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
 rUMlsvPbEkxXhTA==

Hello Guanghshuo,

On 4/15/26 21:17, Guangshuo Li wrote:
> When platform_device_register() fails in omapfb_probe(), the embedded
> struct device in omapdss_device has already been initialized by
> device_initialize(), but the failure path only reports the error and
> returns without dropping the device reference for the current platform
> device:
>=20
>    omapfb_probe()
>      -> platform_device_register(&omapdss_device)
>         -> device_initialize(&omapdss_device.dev)
>         -> setup_pdev_dma_masks(&omapdss_device)
>         -> platform_device_add(&omapdss_device)
>=20
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before returning the error.

I see you submitted quite some patches, all about the same issue.
I did not yet fully checked if there is really a reference leak, but even =
if
it would be, I think it's wrong that all the callers in the whole Linux ke=
rnel source
would now need to use platform_device_put(). To me it then seems as if eve=
ryone got it wrong.
IMHO if platform_device_register() fails it should put the device itself b=
efore
returning.
Just looking at generic code, see platform_add_devices() in drivers/base/p=
latform.c
which seem to have it wrong too then...

Helge


> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>=20
> Fixes: f778a12dd3320 ("OMAP: OMAPFB: fix clk_get for RFBI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/video/fbdev/omap/omapfb_main.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbde=
v/omap/omapfb_main.c
> index cafe859d6e5a..0d47a8aec5c5 100644
> --- a/drivers/video/fbdev/omap/omapfb_main.c
> +++ b/drivers/video/fbdev/omap/omapfb_main.c
> @@ -1768,6 +1768,7 @@ static int omapfb_probe(struct platform_device *pd=
ev)
>   	r =3D platform_device_register(&omapdss_device);
>   	if (r) {
>   		dev_err(&pdev->dev, "can't register omapdss device\n");
> +		platform_device_put(&omapdss_device);
>   		return r;
>   	}
>  =20

