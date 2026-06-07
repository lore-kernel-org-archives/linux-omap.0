Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9941EB5C2;
	Sun,  7 Jun 2026 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780845476; cv=none; b=TZNGuJ1o+CCUl7g5oxDyCQb64d/1FxX1N+eaWRz98ldp3M4D+1Ss3+FLwSOZhjCOvZQW8+sZb7klaPKaTusTvT5U8ZnrTOaY+RixS0ucoR+Poes8hl4IBNO1nYhRR6FjaJocgodCcO7h9FuWRUri8xQ5nR6zhB4aU7X/c8BDfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780845476; c=relaxed/simple;
	bh=YmwTqWwkAuTePgs/tWlwFIyrNZv2ALnqvxt7n0YtRSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCk5bR+2mECAc92Rh7sVXiyoROtYZiSuQqv76F6a449dG80wG7GZ18FIqephsEGPUEahHc1EkVRzf2z+GQ2SwFqjnfji8IvmKwUvUiXApShWJyb2HtbBg8DFZ0NYKZ8ofqfpRke9IYShSoiacu2agSzumG0M3J0ueACjr8E+nQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=g4wTok1j; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="g4wTok1j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780845470; x=1781450270; i=deller@gmx.de;
	bh=OXQ2XRksp9zCD/O8872+/blcYYZA80843P/NYXrTUGM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=g4wTok1j1WsWXJQzZlleI9fMBpAbKkiSnVvnxGILKlA8Jag1+/WtTYBM112gV44i
	 nIe5IDOWsTL2IBVgFKgganW/gmDwRN7yyae783lNc4aPbROmGTSRVi5G2CfOG7uVs
	 jYLmdLbh+GlEhoKOrTUIMILkIHAiQ7Un3xtodyj6+DW5l2FEdrB/cDSFIxc1KiiUY
	 rkqFtY/iZszIR4VVTXuBQlKNc38zkrY17PApgi2IpfldflAw0XgLeWvd+3IO86zKP
	 LL35uNWR2L0YljhEIY+LAeiGzwqHuV1DtHhBGI+W+/JvzGNTRr48oIYtHUUGhbzX0
	 Bqy04slrC2lMmydgVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQv8x-1wrVQf1XFv-00Tmov; Sun, 07
 Jun 2026 17:17:50 +0200
Message-ID: <858a41e6-5561-40a4-9764-3fa578149253@gmx.de>
Date: Sun, 7 Jun 2026 17:17:43 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: omap2: fix use-after-free in omapfb_mmap
To: Hongling Zeng <zenghongling@kylinos.cn>, kees@kernel.org,
 Helge Deller <deller@gmx.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 zhongling0719@126.com
References: <20260602085421.194325-1-zenghongling@kylinos.cn>
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
In-Reply-To: <20260602085421.194325-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P6ZAMYyNd4aYUvAqjYqWsdw8gUEtnm07ZK/kSV7/pu/SfnIn4rW
 xFa4PyiG0lzzHQcr8HnkFKf9zB1ny24qiKPMGppazDqGv8YN1q0GcLqd2m5roVYnjzAd8QP
 M9BHfmgIaa/hsEMt62Alhv6KkNKZzuIyrR85I6mewHqJVpgSzcLacgBJQUcmULh6yZSqDsT
 tNuO/gZHrgk47LliwPYJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uY3HHhXqjxo=;AHItYX5alLVEbALmkVJOIBbSPIb
 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

On 6/2/26 10:54, Hongling Zeng wrote:
> omapfb_mmap() has a race condition with OMAPFB_SETUP_PLANE ioctl that
> can lead to use-after-free:
>=20
> The fb_mmap() entry point holds mm_lock but not lock (fb_info->lock),
> while ioctl handlers like OMAPFB_SETUP_PLANE hold lock but not mm_lock.
> This allows concurrent execution.
>=20
> In omapfb_mmap():
> 1. rg =3D omapfb_get_mem_region(ofbi->region);      // Get old region re=
f
> 2. start =3D omapfb_get_region_paddr(ofbi);          // Read from NEW re=
gion
> 3. len =3D fix->smem_len;                             // Read from NEW r=
egion
> 4. vm_iomap_memory(vma, start, len);               // Map NEW region mem=
ory
> 5. atomic_inc(&rg->map_count);                      // Increment OLD reg=
ion!
>=20
> Concurrently, OMAPFB_SETUP_PLANE can:
> - Reassign ofbi->region =3D new_rg
> - Update fix->smem_len
> - OMAPFB_SETUP_MEM then checks NEW region's map_count (0!) and frees it
>=20
> This leaves userspace with a mapping to freed physical memory.
>=20
> The fix is to read all required values (start, len) from the same
> region reference (rg) that will have its map_count incremented,
> preventing the region from being freed while still mapped.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>=20
> ---
>   Change in V2:
>    -Restore fix->smem_len to maintain VRFB sparse mapping.
>    -Increment map_count before mapping to prevent use-after-free
>     on driver unload
>    -Add proper error handling for map_count
> ---
>   drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/vi=
deo/fbdev/omap2/omapfb/omapfb-main.c
> index d70deb6a9150..046892682fc6 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> @@ -1099,7 +1099,11 @@ static int omapfb_mmap(struct fb_info *fbi, struc=
t vm_area_struct *vma)
>  =20
>   	rg =3D omapfb_get_mem_region(ofbi->region);
>  =20
> -	start =3D omapfb_get_region_paddr(ofbi);
> +	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB)
> +		start =3D rg->vrfb.paddr[0];
> +	else
> +		start =3D rg->paddr;
> +
>   	len =3D fix->smem_len;
>  =20
>   	DBG("user mmap region start %lx, len %d, off %lx\n", start, len,
> @@ -1109,6 +1113,8 @@ static int omapfb_mmap(struct fb_info *fbi, struct=
 vm_area_struct *vma)
>   	vma->vm_ops =3D &mmap_user_ops;
>   	vma->vm_private_data =3D rg;
>  =20
> +	atomic_inc(&rg->map_count);
> +
>   	r =3D vm_iomap_memory(vma, start, len);
>   	if (r)
>   		goto error;
In the code there is another atomic_inc() here....
With your patch, map_count is incremented twice.
Is this right?

Helge
