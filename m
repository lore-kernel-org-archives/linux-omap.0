Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63849347C6;
	Sun,  7 Jun 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780845031; cv=none; b=FZcWL5U+i/Lb/wwSwVXlkMM6E9mB+5YYr+8V+4xsgld/lJWlO8xqWCTkJAr8mJYPrLogpPVWCgryRjScrz2PpXrAKOm3KwlWLQElWUbIjHawrKRvx8CtKt/qWU+YwJGu9R1HKLTfmGTzxuwKma1KXDZcKDkSPMbLI1pGegSGs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780845031; c=relaxed/simple;
	bh=hhFYlH/4lU0lZbVfei0Fu1z0Nhhzd59J2uXZrLeoU04=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F6p0h5hAE1K9O1K2DuY+Xo2WQJWeSKMxx/PrFiVR9uIQqLERbfCYIjF1bs+Tc/vERWgIzSihKXDSguqhL/VssxoEB7eWPnxfWlS7QRtfLAVaB5id6BXi0LLjyCIBZ96NtsJHJJrvL/ChzWJas3RMlQ2ldNnwWqpB6E7cF8OHxgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=UuGnKlhD; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="UuGnKlhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780845027; x=1781449827; i=deller@gmx.de;
	bh=ni3DnTaoKVIXVRI8bOHMrhybOOslW8wwRSsPdhW0HPo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UuGnKlhDQZ20dwvEzTRdizBKul9oRkGGuET4+MJOCAmyqDr6XYWYdIQ9wrU2elR7
	 yHCGoISeVwl9ZjFxfySODEAzuZ7LZAC+1/2dx3t4DesEmQBBlfBpYHk6faQ1QSbSv
	 +GClZDp/HizTpGDAbmGX7ecwVSmjot4fTwR2iCrCeED7Jn4ADQ5MKTzfMJ9rBAIZL
	 iKDJpTzutZ/jD94vA9eFHSOukCBDnfH0OXjrn9pmSixhIVIB4mZv887Zt77hIpM6+
	 amlc/S/4eBIeHJy5fcZIrjPf10peZh0S/cEHoFl4VbZZM60dg5oe0ZpSdahOhEr4E
	 k5YX4PxVRr+YbWJcwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1xG7WU27mz-00vzk2; Sun, 07
 Jun 2026 17:10:27 +0200
Message-ID: <de84ad83-5820-4633-8161-ed38606f5ce4@gmx.de>
Date: Sun, 7 Jun 2026 17:10:25 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: omap/dss: Fix stale modedb.c path
To: Costa Shulyupin <costa.shul@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260531140325.4115024-1-costa.shul@redhat.com>
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
In-Reply-To: <20260531140325.4115024-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bUSQeMkHrdW2lZjWHD4eqscUKgGM5b/YlKK2yRpIl1SKHPvTq72
 orl//5oxCjG54AVn9eWH4pfwlOTpnt6dMS8hf7uHqXEpXzpIlNym0AdaOhAC9PZ+EOrsBwB
 lhJ9FXPetOoJ1XE7nPihYvDGN/l5SSVMmkRl0OJUW0XjrqIPIYArPm+EGbAY2oQJrpBT3gH
 oWYAEfT96q+6G7jP1t3Wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XLChSKnbc5Y=;NysPg3CYA1qHX96GdmNHAeiYWhf
 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

On 5/31/26 16:03, Costa Shulyupin wrote:
> The modedb.c file was moved from drivers/video/ to
> drivers/video/fbdev/core/. Update the reference.
>=20
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>   Documentation/arch/arm/omap/dss.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied.

Thanks!
Helge
