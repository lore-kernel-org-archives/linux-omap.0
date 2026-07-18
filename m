Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BC27BF93;
	Sat, 18 Jul 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784400683; cv=none; b=o9ePjvkxJFwuJ6s5NMkGH3328isz31s1KxVkPlo/wssbiSTwVPYRUIqvQLnq7W6vpG3bvRjA3w54hXmmYBfg9be+SyQtRhuzOIJGP7J4Ah2xjhX2RJDjWjWGyGBzoh8gKhU6lJUBa5Uwvfin0fhB/TJ2fuxxnLWdkDPg2a+U7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784400683; c=relaxed/simple;
	bh=uws36cDvgsU/wdcPC9zUBC7d4otStHfTulnhxfbaAxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ts7NfkNkXV+N4x1DvgGBowR93P1TCeKuiMlDN58oFydfEFLISGfc+0zgLV6qfzM0E8vNFh5sIAd6iBH02PFCmF1DRpg+61Me7eLo/n6vHmYh9+JdhUWFgI55mbc5xhFKU/kEeiO18DIMqi1Syfwo5oHiE8pjV/Jr6xyxaiYlWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=NtCQZhCd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="NtCQZhCd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784400673; x=1785005473; i=deller@gmx.de;
	bh=jOlaFsqV4LLUU3UB6EEK/xtK4nPXg4FzVH3zipf7lRI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NtCQZhCdeDBmyroGczL2dOblnaZI/dkr3iLqX8QjaF//h/vaYZyvPfX1UGuWpGDi
	 hJzf4J5WxSGRjiqC501DUR/nxTNl4s/yfuyDTxFIPYW9wutMiPBmE16X2QHURDsvU
	 RA4FyXBxCfsx0JdhhqFBYgx0tMYcTiF3g0rqqgVzJRJutyQJ3Zo9CsP5Y/N35a2aX
	 3NtUTWQa+H1I6btOIWg5JCmMBhWczGSIBds8maj960NNXfr+pOOT448hydWX6w5M3
	 naWeNNm1aoqS0sYHVip5eH9nqCn24z2wFQ8RjLprqujncuJCtPpBzINxJH9ZpyMS/
	 V6AEGgapzZ3Q2MI0pQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1x6B9O17Fz-011mlZ; Sat, 18
 Jul 2026 20:51:13 +0200
Message-ID: <44f66ed1-7dd8-4cf5-b1fa-28372f3abf18@gmx.de>
Date: Sat, 18 Jul 2026 20:51:11 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fb: omap2: dsi: do not copy isr table
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
References: <20260702-fbomap-uaf-fix-v1-1-6417edf9d3e7@kemnade.info>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260702-fbomap-uaf-fix-v1-1-6417edf9d3e7@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W3fsYCO8ScpUM8FH7Ddc7DrS1LTgTcOK7pvrbuC1RRjvvdD4SSD
 OFg5qoctLvxmThxK3UksLYy8l2u7OS0vWF993D46fVPx4xPoMUNahoxxiPFetHfv/3CnZNz
 z8Fp+yfU2U23F4UtMR6A8tur7e/dJLyDmtCKhMcCbdFWHzl5IPUWgrLvWm+UxXkK5vR7VP0
 2NRWU1wRXRW3nRBXRjDUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:idYy+RafIEk=;VbEp5GGbtzut3TroSgcCFJYIbz8
 C00aYS7q7say+z4kRm7UN7tEY1q8VtXYPC0Q4v3covGR+/M7ePCNpk8i3LdW1C4qKFoz/zjB6
 UJHFIKpLqJ13vXXHDY8B1pAx40ulungrPphbiMjVezCtOmbVfSn/lCmZ5PS5siMuN4groYpLp
 Mvjt9JDVKsGNyJOIekfzoG3/l0Icz8zxhQy6UYRBuhGvVaPFi/GdPlC/713+aGP/Hw9xjzHhi
 vUnWANXPKqRliJyrTzrFyLiGpNWWJUE68UhuUrG2VI0qXmW7+9+cpudksfEhpiH66xa30Qqc1
 TWPB+8B4vmgEnXw7I0B+llut51VztIQuYPBbsRW6Jop1hK5NhG3OtWvQbvVXRItgfqblGGrvo
 esV5lhwWDKLo8SF7UawEcIzD+1nz6xdivBklU3dAxEOaER1Y1SQqs3P/5Aqe6Nbndy31qUp7b
 VwHw7nOtzwyRMxziDj6sBiPmEFfDysWu0fbYdAPB14vICwaOS8h8mWe9c8HE8A27qKs1Sb0YP
 J9e/tm0i+0QGPW6texo8xoTZxDFvA8pbE/6hnzvyctk/K5tK94nMGbm68J0xZtghtWyjgzZgh
 r1IDJcYOIVz4lI6nj5iWam76rk2tWWoNCQ+5ooZgDG3ZaefM14TnOLAAfbk4JJbHMI8h+8hal
 lO25n+NmghCw1Oc1Q7EiqhLhULbGLrvVYFcE9R3+Cd28RSWlD9DoYM4ph8VrQn5potsMDSd10
 vUZi31ZVnh2O1q0GpGXR4HlOdxfHLqHu72rBTJnTzMPd9TRj2pTo9GeOaz/V+MzyzRJ3Da9C9
 XtvoLK6a1E5trtdIXY3QAmk/+ajqM1+Hn58P9EIkQe90m3MZtLPMOeEBNcOFx2ye76Pac5yJN
 rVdolRCYuO+jJMLEepkwQXbHMhVCNfSqxYMQ17K1Z9xqytl2UuyfYae3Z0EMg/DFL6vkpDfV2
 aUPNUkE9kPXbVFJvAVvWNO7+cJxlT/gjOBWZSDTMS+1fmg21V/NYxcgLixUpPsnPsr+9JCqzE
 sZyFi8dgxclH2HenIuYE4pRv6PVJnSTVqrBMZ6tx3+wywc2W+XGCgzE7WpiJAsj38zCmFhb0K
 SZBqAqnOpp6pGuCs4AKfGrxdQQkB+oOPulA+vmKqhuNXtRqxuiqfboQ10miteSuxCqjpT7Pj2
 s0ZFw9Z1gbfFhqKJE5BrHDJchC5vbFmC8GqKcfI76f25c/ZzDanA/Nf4WHp/REsrjaTkparME
 mrWswdJ5YrbUnYyXjG3qQK92uKcUPQHbIiFbOpWaTd+lTbpRgkjQXPj7AMFxR/MMDdZJJH+a5
 2xYK1sLif4EgqPrBLzBz6jBRTrC4UM35aq2tJHoqguqbwN5SEZpupBQq28ycPINlsvRQt8shv
 Kmo1U4J4LLkvVoic1JTz9mlOP7jHIO8HawNm3J9iqR2LbaXkxTrwFy9aepzedkGejAE61ImxS
 aiRHrKA4Aa5ZlPZ3bVt3UQiQow0mPbp4AxNHzOyuZAfgmoyWn2GfAo+Qgwum3iZOUiJTFRzVG
 1mcnudwwi0c9j4QX1IfLsQ2I4eHcUKlF0+Ys7zgmxXW+oM31O17I88yy3IuVU1A0so3QdvHXd
 kyZfeNwwyGQHcQqxUxqdcuj2azoxKzsCAs85DekzLrlFGioVjac9uoWYx48MV5f/6zzf7OunX
 2280XaoyypRuv9NC74d9rtbnrj7iG7e77krSIrJixUKCxKO8CnEmKpaC4oKdNYQ7/EUwa9tr5
 bI+R8xCv6zFf5uBQ2K1WUwEImfCwWOI1Oe41mO4LrmiiQN1rg55wniiJ+nuRSLnSjUTPwa0sy
 QtNh919mWno3CxjUQ1SVauDChRIdTasAuqkeoMbjoLT8CzfmTp1xZ7/o/pUMm43fS4hFggpYJ
 mp5ZLVGGquHmkdZaxCsw2/5uHECKxitp7tOuwhEbxy34xezkPNF1MpXwQipz2KREkLlfByl+3
 qXt+flBtecxtwgH+7u+BPgV1/UyY1Sz3blN9dGUILB9IM62+exbVCo59FRPS4seXq8CRMsfEr
 niIukpAiqPt8w0lwSgfpyO0Y7eGddkASCR+xH7HitiPVdgIyc6YshW8BFlhE2Zb6Gqb+/SBDL
 2j/AqFzpD34718EzJKWDVBKChW9EPEG/pNLYER1gvhDELcJ0bx5OhqePdaYCrjNlzi4JdgwNI
 fGl2AsV5iuH5sXubXCVOaPDyLY4oq12sIQiMwLOe5exqz+qnGnMz7ocqzQjM83cX1yUsQpZR4
 Ben4ekXPUb4lvGxUZfazSRDYvEVVDsS3uN4QFtQA8w/CeBeP0GrIw2/ltByyBOqrJ5salUsuh
 NF8o/GY6WVyoiRC+2+7Bb+NvoI8NWfZBZjsUsOvybAifSBJaqI9bvDKNe/mSQjO5LX00hYXjd
 2A+hVuW2uNovFSXdY9jof6j9IOaLxhNSPjglOhOQ3auWQ53ailOptEfWi376RIzTbB1C1ru8/
 XVc0TtHhx5Swc2RMv8v2PD/Xgp33TjeDeJjeo9fCZuaK8wUTh+/Ifaqx3vuhJLkvOEdTUYDD+
 m2hMiaz/V21ApG9kryeRIwYUAwet433MMKB0d/IQVbL66TYHg9UA2GKErCDTMZhvq+Ut1wtcK
 EhQrQ/XOyMS8CI8uIuX9Q168iA/7701KdczjIo+uU2yejkQcyzZpLRj9regDb6KGngqu5SNCc
 isZGKaTJ5fvllveKDpoikWvXUDboUO7mqNZhqEcuyiaFw0UWcgMzQjdvI0ZNnttFgMVZwn0Sm
 K8D1EKKfka47WP4SL3y21s+wW1Bme/yJHK5OC9KOA24pneOxEsRC73uo6d97vMnIN9zkV78X2
 sfePFK9z/AKB3f0h8pzhZx5dT5CZ4cizCcPFFO2+X08wsrFg5ZHg2vFnD9FNSN1+Cz/TsLkKS
 Lp6DY6/pOMYHxkwWpG0dwZETCW++2psQejG3+v/VYZl3G2pxxAY4/EK7Dn35Ycog3FoMDxkek
 SoPBZLxQP3q18jWc4s5JyH9ltJDiShPDqDLBZ0UuH5TeCilsU4mTOphOP65q/59cG1dU/xSm7
 kx0Pecxk96xIJbod3oGaAc18CAK1W71j7p0a0LurvcxtICPoIsExLFtRke7evWlgT+uH6KSs1
 N9oh1ePpQOMNhLxoI8Xr39wsJw/ig9hK6eyubtj/DMjlZCZloGsse+j4yuSzuD1gvunjRtneR
 vIGvRcnsdmTm7lXzFj+7R359kbIslqLRFBP/dRLOrm0U0Jko1AJGyda2DxPYvIfk3dKHk8Yu9
 xSdfQUmdGszELvTM9pi7PXyt15NpgWBm4k+LmkdFi28KmOHUgmBpikApnjGuGzhJJl3A/yQwX
 SBRm0Nn/duQ+wU5W8C8l+dpUIsUx5qKF9BiuS2/GbpObMHgSfm7d9C6rwk3fiBfBYDsajlE50
 EYBrW/owl+jE7l/+8P4kFlhfztg3omxSKGTCjv6CakBVYeW2rZzD/kzu6yAOZtpaySnC1ICIb
 GoHYpm52S+0mEq48emTMcA7s63VdxxXfs2ZRpsQtAQftQLGYtbvdL2NWnJG3l8wig7F54d0Nm
 Te4bO1htJBhhjwTAC052glrtmB0pLEgftaGXFJonKyXJHCCv/puMzgS5TDew7AUPqUvQkLAIi
 xZoja9FD2ctUCUw9tW8EVMpOA1f/XLu2XOUVwW8eNWsCbDcVIAnRLKWPAFkg6mTxIuDuLP1vM
 fPqsSK0xjNqIqBaD871DlO9Vra90hhHHh6KGjuTzMaelWlUkser2F/CTuozMgomOuUtOcaHgX
 OjbGx2Zun1vcPM3AM9+5a7wSnBrDqNHYAyN9yQExeDuaI2pWg3RVw1FgCe7/8KgUDj1EQktTP
 0s7CdQ7rgdNu1Bc4QzY5VUFGdTvGuO16XeST6IjyD7BxkfaDAOkEQbHoKOQ9B7vDh+fJ5EAjn
 xmMooCM3gmva22fH6HO3WVeuGkglOr5S6JomsoGUAwkQOZvb6q/aCN/D+NUuxSaMZ8wBD/ASv
 Pf+QVEsSBo2UCOjp26tWrCfJXloE/oQHXH6UEPoJtS+nKzgVQCwcHP7qQoWeKvZ8ApWyVj6vN
 Zf4rvnOMfeADN9CtuCvfV/0G4UMFAE6DuCe7xg6OnvJ7M0qBjz/Ex5cJBl+BtNGL2SKuWftL1
 k/8XYGxCOlEDQ4Z0Zxr8WK0k0AC654x6qLNgDjCuBglPr3en/zXeZxdMWFoK+nycXD9hpHCIh
 p1G8YXjb1Q6AQOK13yDksErmxIzeQqoomTH6GoOMiXfaRvc7yO4aRFPiOm+kGEk5MeghpnYA0
 emUjtmWQVprZNTxEMbQz9f0hirD4iJ6jyLrFO5A2xaQl8+2QgxtYVVpxiTcfdOarelCkc0HT7
 VhKfQ4RU1GlVtdV9LHjw95LjHF/I7BC90fUmJvh0sgHgxBVK4hn9HvXLUdNATcm5k4FvUr6Jw
 1yXcJQvC++DtLa70LCNc3eDXkJYBnxySD+ZyJoMfu+yKNCAwIO/XgDAQ3zNMXd23ydauMsp0G
 /jAJkXrgHuHQHQ/s+Nhbh/lw84O41VZQQdQI3C4XG3llPw51/3Edn8faEnQlXfdAViNIfuCaa
 lknp32nTSpB/9c1erhxOY8B25KuqeADdXf4z9CxeH8Mpbp2UHb0ao23WDogzinglJL+qbGgMs
 19dUCWjsffTCvdPjOCtNh3j55mxE5WX02igvslNMyFzRKj3nxCheGd9L0mfrilYMBR8msqUdz
 8VArocg+3PFtLmzTiAvLNItScAWMFQi4Kxc9/OJ5qMuW3dRgHpIT6VO9kwNgI0f8VqIsD0aKK
 Dj37zVItHIx/315uA/6JCmWh5GROYIy0I1KOPZcECluN3EAjML8zNT9O4HOnuu2+ieYF/Dv/2
 meuzA9Wrn3EY2VBwTqQn50DDYh422l9gRmQbnWI4k3X1xsJdG2PdyvL45qmdsVeDOj9wEQlYt
 UNNei8zRWpOiPh5ZM+WAIklwoxM1SifwbsqWW90de0m5OdlgKxe/kUvnAtaggyA9rYOF2c2dK
 SemQj1oz4+rSMARF6H4Oot4ox8lH5UUXmIQQ4DQ0EUb7VICg9m/kSz3Ey9l+HtV1WqbjAbcj1
 RgbBhmNFNunC4c27x6Hl3aFM1jl1vlWy9w1KTEQZYTiSzok6ytrSqUyvBGnxBwA6KeTNT5xvf
 +IXtTWOLayl2PmrAqDNOplUztwQOXoL8I7OXCnNEVHNgU8HgkorbbWrb4MZtEmwyWRx3zyzLF
 bcSxSwXLiiEyJP2kjJjkx00E0+zYygl3lrsIxm6DnryUfBNe1fvhuyimWnlFkcTS2/wKxyzmg
 gDjYtgPqQRYVp9kADgjdjgTEWGH1VJDIVIN1PMaOj7MxqKY5BjEHt/kdefXhTil5+L+WFQTwV
 xV6vHYAIB6kIY/MOh0avFlx+Yy4wjWyEEJqSuGJvbq3613hxC0M90grJdPJJLaRFpUz6GrNjz
 6RD3SbO12zCVEinbTTDdyt8/4xT5qfLhWgDTyk5lR/wkq6Ap+ux63hXrXqTrnQPt+P0/V1GiK
 R5zq1fc2eXK5/83RsalCWL0sFA49FLTd1tsnadUvlzTbm+OBoWk7czpz4C9Byce2Zt9OrXJt2
 3Qk7pncirptwpN/4Rk8TD6EtxA3g2Zt5hGJpF1JW+XXKBPVENkjvQaYwaFkI5Uz5cFWn22ueo
 FuItoieg960e3JV7qHWdmSAmlJB0GqQXF8mHMa6Hf7J0oMVIqvAGWKa6DNq/zmENlkHIENYc0
 vjCSXZOybh2A0+Ir9Re6E7rDbqnuWm

On 7/2/26 17:50, Andreas Kemnade wrote:
> To te able to unregister stuff from isrs, the corresponding table was
> copied.  Nobody seems to unregister stuff that way, so it does not help.
> But there are stack-allocated objects passed to these isrs giving chance=
s
> of UAF of these objects if irqs are unregistered while they are handled,
> so better do not copy that table.
>=20
> Suggested-by: sashiko-bot@kernel.org
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Fix for drm variant fo driver:
> https://lore.kernel.org/lkml/20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.=
info/
> ---
>   drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)

applied.

Thanks!
Helge
