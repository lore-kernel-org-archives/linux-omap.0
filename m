Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795532206;
	b=iBQ3rlU9XVNooQzJKwFlZhIS6iP2tz/2omvb0+HIa4cUgAkFG/01Uz4XkH4HTtZVLeIa
	 O2+J6MyCBJH8J97ZagfSIjGYQaejNoeRhiokcc7U0b0ehcxpDoWM2BZ3Q/xLJmHC5WL9u
	 kHUiMy1nBV0kg7y3TrC3JbhoOmOMvPylRUafmNeK0sHgq+mqIpJmAR6vqMsGdMw88tUtj
	 OJzR+DWhPMP0p2ugQnA/KzgNkMFRysze+HlWc+EZ5F9vr+MTYS3nKC/3oxAcMkKHYiU/i
	 ItO2jDMmVfXxYvboWXBgchk7MMVrIky5I1DsPf6c9wczlkdyk5TtFUvzKVj4dSv+LdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532206;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=kD1GNiqGMLXsLwN0Ufm7bvf0nYrTqG7Gyun272V+FBQ=;
	b=v9z+0Zhd+k4+LCilwozNjyrZeF3skfzKdWy6Dro387RVtimsRP+l/LQL/DPO6sGK0Q9q
	 qzLvsjy2Vwk0McvLV5uqxoFIW3Dmz13e1cHthSMTLaJtTr+3sSlPB4m1KeYdeeXYmlYGN
	 dYdFNFPMx3PiUOhGlSlRoDODh6SGDQWbKDWg0B8ymICuidiId4Fr8twnXFWAJumMmLMhU
	 XYkh0ygyGyvsq9p+wYEYB/c4abICYNQRUI3mHcN1FuBxZkmdMV/Z7wHlb43Q40hIDsUDE
	 89V65wVD1nvzx7N2636XEuErCUWHTvfIi1vuBJ17RYFAVtti5c7EEGN//jXXr0N0uQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=g78qi7dm;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=b3NjsCJW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.178
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B3606A31E;
	Tue, 24 Nov 2026 14:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 171B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=g78qi7dm;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=b3NjsCJW
ARC-Seal: i=1; a=rsa-sha256; t=1795532163; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mXrrTdkIxFBikSs2buuExLGImnsss5asFyDblSFa7hvcQpzrTygM97Mmtkp/+JfIIg
    lPtNgIbXi6iNJHfbxDM2tGPrvNob4kg59IUcaqNoHOxEcaGJovd+Q8ah6gRwS+tjATHR
    J3F6sQwarR0yWNKI82jo+GLPppvMqdXu3NTffBIO0m6vpZPYB4PqyAsib2GMmAmcvCLc
    /YfumcPpcPU5K/fwK7kcsCPn1eyLGpwLn/iKFuWjsd2TcglmHak2Re0ijjZWIridB/am
    yBxH+fc0vGn7iidGwE47kY6yo86pOua8y4isPOgWFuw8s5XQmO8ZOBSxkoO9SHuOVeu3
    8ByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795532163;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=kD1GNiqGMLXsLwN0Ufm7bvf0nYrTqG7Gyun272V+FBQ=;
    b=ZM5w3Jfk9ANqD0Ti5o+IA0ULSYlRb9etAC/UedIyafx7XEVA5d2Vwgy8rW+f/KRMLu
    U6lew/Roh2InlnuduzLJoGupp9DeJs790mJ9rThUGdLHQbibdwVVD0QTBjrJYbweBCSK
    /TJzULbiP+IItbBhNwoDjFrHC5uqXyyZcfV9qui8rmpN729XZShEg9RCC3EyhVXk727V
    vQvVbkoIKSXWnAx4WSTrcjlilWu9Ztpsqict22NaYpsnUCtCXOMf11Ua+SwUBi1c0JfC
    CO662K5J6akvKzdRJzdzqupOl+qc11DOuudWqIElvQOXxWeND+vX4xpLcFTAwJH3rfbB
    0Qkw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795532163;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=kD1GNiqGMLXsLwN0Ufm7bvf0nYrTqG7Gyun272V+FBQ=;
    b=g78qi7dmmOKb50cPH/PtIvPHRVAKJ5YEB0z6uIoMX4OFugwvpdjjpdIVAGsex5nEf2
    +WpReOFlNGHjZgArPnEtlF0u8GuMMd//SD2AwxcVCQkb6Yhf2izb2FvgJX4HQrg7LPKZ
    vg0h91GAJ5dM40C2WYH/fzAlpMKyaz2pye7aSMZz1PrhDPOz5jncJCkb535i2oDzZKg1
    Co+6i1vMtP1U+lmZBJUZqEbJ+VZPje5+thfAkN6GhlxiOpoWh04i91Svi4+SElcEmBmk
    1MACSgbbn3Fh23YAbr3ZKxF072Fkqt8FHodVGyN14Hf5WYNCFv0gKSuTBJb2nrsDYC5P
    /X+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795532163;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=kD1GNiqGMLXsLwN0Ufm7bvf0nYrTqG7Gyun272V+FBQ=;
    b=b3NjsCJWVhfoMdjRGQC49ub7BeVSemOzYBPiCh/kZv/VLtpY/Mk0kV8s8RDbMvlWrA
    HZJa8lp54imBSto8izBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVWUgMvoVkTTR2P7jtjQyY2AeEP/F"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AOEu13hT
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 15:56:01 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.11\))
Subject: Re: [PATCH v2 07/20] ASoC: ti: omap3pandora: Convert sound card to DT
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <179553168323.264265.7045861860225672057.b4-review@b4>
Date: Tue, 24 Nov 2026 15:55:30 +0100
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org,
 linux-fbdev@vger.kernel.org,
 letux-kernel@openphoenux.org,
 kernel@pyra-handheld.com,
 Stefan Leichter <sle85276@gmx.de>,
 Grond <grond66@riseup.net>
Content-Transfer-Encoding: 7bit
Message-Id: <F6716339-FDD9-4F23-B4BB-9C99A13C8875@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <57d9a8b26bd2282deb9188d6913976cfee41aee9.1795505160.git.hns@goldelico.com>
 <179553168323.264265.7045861860225672057.b4-review@b4>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.11)



> Am 24.11.2026 um 15:48 schrieb Mark Brown <broonie@kernel.org>:
> 
>> Convert the OpenPandora ASoC machine driver to bind through a Device
>> Tree sound-card node instead of creating a platform device from board-
>> specific setup code. Describe the CPU and codec DAIs and audio routes
>> through DT, including the external PCM1773 playback DAC.
> 
>> + DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773")),
> 
> You've added the external CODEC but not updated the Kconfig dependencies
> for that.

Yes, I remember it was discussed but slipped through.

BR and thanks,
Nikolaus

