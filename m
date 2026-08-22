Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471B493643;
	Sat, 22 Aug 2026 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787394228; cv=none; b=ETEfYMCVCRnK0u6jaRyGwCp1m9pGexhlkFH1rjwbu9gxvbPnysWiDFwzddHfvy0sXbn8+PCrO6ZABwxLHExu/YUvw/XOXo8MQD1TetVVGy/YWZyBK4F91Jv7SFMgDOjZ/mMkpIyDiBc4sBwdNv4hXgnln5is+ouI4Njye8k60PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787394228; c=relaxed/simple;
	bh=T6OFElw4gRICcbOKyP7bY6TeNrI9EzyvoIW/oAs858w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms+Ch1wnB0L2IGKp6Pa6Ubzy57gJNfXVJ9FGaP6OHxAqdgXgVS8UGsbEWomSg3kxL4uw5N7Bp5zCIB7rXMq7otS1kARNzW1otsz1CxfFz86cw2mTBbq/vqyqza80LJ2DcoxbuUoyxxN+QljFux98FgmaeMzekKTh+NQ7yx+2A8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=XuhpSYje; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="XuhpSYje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787394217; x=1787999017; i=deller@gmx.de;
	bh=B3kEARvv2fp9x0HEl1gifd1+MOmV7aaNESpiQuDQ0wY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XuhpSYje9xlf+75kkqrquvE8pXuKT0Oa+wBs7EGFctaYW1HEj9uCpTh2RzRMt6Du
	 P12NtFneckSzx2VflXIhmYyRmAZWqX6tpHADP4npasaeJIVTdGiResuScY6ECEU7y
	 MDdxwiOxRO8NB4UO6puEF3L11JsMZB3rVTx+FRFBuFzG83ZncBS+IxdzHyicqdhc2
	 TF+kt62ES0nX4VHRXuayRROGxaToDeY5oapwC4dxAonptf0QuRTnGe9ZCv9rZQJ3V
	 XHQIJEDsQBXt0qwLicrzkeGlu5tnmPKRbL2F95Z6gB16+UHNhbZg69bCLPSdpBASG
	 /NXP1n3tJgBoCMDOog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1wT2q037dQ-00pqkR; Sat, 22
 Aug 2026 12:23:36 +0200
Message-ID: <cd542bf5-775e-407f-88cc-4cf18305f2b3@gmx.de>
Date: Sat, 22 Aug 2026 12:23:35 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: omapfb: Fix __be32 sparse warning in
 panel_enabled()
To: linux-omap <linux-omap@vger.kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 dri-devel@lists.freedesktop.org
Cc: sashiko-reviews@lists.linux.dev
References: <20260822094805.421002-1-deller@gmx.de>
 <20260822095809.1D0651F000E9@smtp.kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20260822095809.1D0651F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G6yuPffwbcN4mrs5m9G/kqpsnrJVsopgFAwKttHKwr7PYrYdof+
 4cG5iGeEICFqscdJ6kR0ZbGbKx98wEnR1i+D81jL40BoslrumngCS0JlLok/3BRUhHYotJ1
 SEkRGEhiyqpQxTRfetm+kw1yw5JjsZXWLlla9zxyqklHl/AIdA9Dto2MO8akvOStOvaX3+c
 HTDaC6FgAVbGmpHuUQq0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X75tP87bRP4=;77qfRW7j8YI3GfioowyPJtRBes8
 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
 bE=

CC'ing the linux-omap mailing list, in the hope someone with omap
knowledge can judge if the sashiko AI bot is right with his analysis that
acx565akm_transfer() might be wrong on big-endian systems?

On 8/22/26 11:58, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>=20
> Pre-existing issues:
> - [High] Hardcoded little-endian assumption when transmitting the comman=
d byte breaks the driver on big-endian architectures.
> --
>=20
> --- Patch [1]: [PATCH] fbdev: omapfb: Fix __be32 sparse warning in panel=
_enabled() ---
> commit a9e06be56fc1b74d7c6e76133e9ea1c25675a615
> Author: Helge Deller <deller@gmx.de>
> Subject: fbdev: omapfb: Fix __be32 sparse warning in panel_enabled()
>=20
> This commit resolves a sparse warning in panel_enabled() by explicitly
> reading the display status into a __be32 variable. It then converts this
> value to CPU endianness using __be32_to_cpu() before checking the bits.
>=20
> Closes: https://lore.kernel.org/oe-kbuild-all/202608211811.lps93xao-lkp@=
intel.com/
>=20
>> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx56=
5akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
>> index 8f430d9e80549..0202ca8cbfc23 100644
>> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
>> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
>> @@ -210,12 +210,13 @@ static void set_display_state(struct panel_drv_da=
ta *ddata, int enabled)
>>  =20
>>   static int panel_enabled(struct panel_drv_data *ddata)
>>   {
>> +	__be32 disp_status_be;
>>   	u32 disp_status;
>>   	int enabled;
>>  =20
>>   	acx565akm_read(ddata, MIPID_CMD_READ_DISP_STATUS,
>> -			(u8 *)&disp_status, 4);
>=20
> [Severity: High]
> This is a pre-existing issue, but while looking at endianness fixes in t=
his
> file, does acx565akm_transfer() have a similar issue on big-endian
> architectures?
>=20
> When acx565akm_read() calls acx565akm_transfer(), it passes the command =
as
> an int:
>=20
> drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c:acx565a=
km_transfer() {
>      ...
>      cmd &=3D  0xff;
>      x->tx_buf =3D &cmd;
>      x->bits_per_word =3D 9;
>      x->len =3D 2;
>      ...
> }
>=20
> Because bits_per_word > 8, the SPI controller reads the buffer as a 16-b=
it
> integer. Taking the address of a 32-bit int on a little-endian system yi=
elds
> the command byte in the lowest bits. However, on big-endian systems, &cm=
d
> points to the most significant bytes (which are 0x00).
>=20
> Will the SPI controller end up transmitting 0x0000 instead of the reques=
ted
> command on big-endian architectures?
>=20
>> -	disp_status =3D __be32_to_cpu(disp_status);
>> +			(u8 *)&disp_status_be, 4);
>> +	disp_status =3D __be32_to_cpu(disp_status_be);
>>   	enabled =3D (disp_status & (1 << 17)) && (disp_status & (1 << 10));
>>   	dev_dbg(&ddata->spi->dev,
>>   		"LCD panel %senabled by bootloader (status 0x%04x)\n",
>>   		enabled ? "" : "not ", disp_status);
>=20

