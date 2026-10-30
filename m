Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357342;
	b=ulNt5s6QA1mIIu/Gz8DURX6bnNRu9xrYGQOtpUjrKNSZEkWD+aEMl0B8iN2zyYSf7yAa
	 6MX+SBS2Zlcw+H+jXOwWB8s+zfmo/g+VpWWr272n5kdcV1X7CHO4qyH6lgSyym+l4lgAE
	 KK+Q8/569PxRtlOTXM8PztCxNm+VYiuxScbxxCvBRm5MNBuRA00TILadN1mAWA8X1cS7D
	 QbkUei94FbedIwP8W6ocSCXcIbNHPMHd3VjXPB0uzllPEntd6mwVVS1Wod9qzE00TV9XB
	 aOI9BQ36EQZGbpDXQmC32cuTzcYlB++S5PkGhRG4ll1ghoQ+C7lMsNoEB3q4OOtG3Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=eiIcyO7P81OBEHA4Sw3zY+ZokoYOfQKU6S8YPtjREDk=;
	b=on7Umv6vzVhtUN8XlA9F6smvHLTqLqGtWAOMmWyZ9hXwBC06ZMZg26M50HB4qII729nZ
	 lk06NfXhO1e8eUcgOL0+XS/p3XStimKIzhfuqeQFcoelWkufgNYISggOY+wTbDOwFuUYG
	 PKXDP/GbR4MyHggZ0/T0U1uPzVTAvx+y/P5TxqeM+bxelUM3tkHNA6fUa/hM4sJZkOTHQ
	 e7HkB457p//0T73WTZSdYz+kIfIs56tmv/PBgCB39Evxs2VqB7DbkpHQ0fkmLYw2jebSs
	 9P0IF01Q51J6sjLYg9gpgIXBn4u4RxWi9YRm9Fq1EiW5XDBtdVc/ao3zakfpoxLmqeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Akpizang;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C409A60A382E
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 10:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C409A60A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Akpizang
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so4991225e9.3
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793357340; x=1793962140; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eiIcyO7P81OBEHA4Sw3zY+ZokoYOfQKU6S8YPtjREDk=;
        b=AkpizangxpGL2FKTdTdqIyT5JGwdLcPlyohrInXtHrNQEE8Vu9y7cydRvZTfyWS9aB
         CrM4Laa3WmIAX/tb2vi3MM8k0UHGiOLvbi+tgzOy+hJHZ6NvSbIrlr7RP1St1FHWjoue
         YfxT3LXqtNBE/q8i5mI4mJyqAwvkF+O9+54M2KLHVs0qEI1wLU6yHyRouIUfQbFCZeQh
         olY2KDbzx0O3w9sjghy/TXjxRzywqCY/EWaTAMJrvHrCbILo+aKL/SmJQtOkA3zCLVya
         8ZOnh+9dJ3Y3y5wZkxTTbtZhB74FjaZPnViLNYLFB+NYdzb9D3najyQOlEcdX/OR+UWI
         SAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357340; x=1793962140;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eiIcyO7P81OBEHA4Sw3zY+ZokoYOfQKU6S8YPtjREDk=;
        b=IxuLxvH1tHaGp8dqQTdomXCunBTHW5YLcYseUD/cFKT/aC/NUWZqLaa/5Vzcn3b1AS
         m7S9Wix12cSbvvfUC+XL2bJlh2CXXMfbfinHx4eagqDLpn4VLI+xm6XeDp+srjJL+82V
         ROGwXvYcZo+ZgoauzOQqRWM/ZMwviJFBPK4MJwtLASIIenedCeW0NrJGKs90vEJElvbG
         4AwSpVYJuRcJhXz3bts5iSW+AY1sFYI3rEoxWiVrTBVxoHTORVzu1THQw0100XNJ12jh
         llRKVAd1HuuzC6dv5unIirzpHsSv5DaZ/rC/MJTu5H/GQOb+yL31ABbuNcOgdU7yGt7o
         bDmw==
X-Gm-Message-State: AFq9FYI+LG4uV3lo+86zpWrW9ylrN9j4iwSmnBMckLEtJO5pYzLUcZuW
	y1xvBV1ofM9DQD7jesOgmBIvUqkAdc4dCvXQ5PI9Hiztu820OPlfFKW4qC9i9kfBBT8=
X-Gm-Gg: AYBFou2Hk+wN4wUky7WRFgCXog1SqYHtzydcTaoiFgqSNXfsPqtDoi/kS6JvXzTdv1J
	95I7nrGpExGE0OUsIqRVXH2WsBREk8BRlnPHXacEOT8hix0dqzRsVBsFEu3Smnuh8SP+piIXc/O
	cCyEVnH3POT2SUKOcCMJiTYH/r0JThehAzVbszpS3sY9wepvpwnCgLZVxNjuU6BlfsOaXIvKfNG
	oGfIDFYtpQO11WmmDvbrAN8IE4rmyjw/eDaMIpN4DzgHYZc5A/496nGI1mvwOdCrRdBcnqWNkJK
	ForhAFgV9+G3Ix+9Phm1vwnpDKa7KoN1cVtRAY83R6D+4d1uzhxrKScX0dvcdPW2eKvFOL+f8Tp
	v6UE89uViF8rNYtVgmNnQYi/8vDsy5qgcLLxhJaAc+iTkBeMbfFwHrhgHwelFljdO5duMDaLG1I
	dzTpmcoCYWuJjwhtcYlw6oCWNMLnL05EhvSB3tGA7mUh60c/Q3IyAlyWwJqklkMfLuJ7PrGD5/4
	riAUnZAldZim+IS8ed8YrSNy+572WquzTmv4cFI5wBknWn8/j6Vq8sw+otFMlcaK7ZEck5inb+W
	iG++Cxfpm+/jiDEgdICqyL7h0jNUfuvdZZ3ceaCMBVHYgERN5GkWMooFvd38KGECStRKgAsrx+w
	0SyiJev2z4vXWV+F+l7ZJOHEwXahiv0eTasSIKu2QKw==
X-Received: by 2002:a05:600c:4e49:b0:4a4:6fdb:cc42 with SMTP id 5b1f17b1804b1-4ac17b2c38bmr39334255e9.11.1793357340095;
        Fri, 30 Oct 2026 03:49:00 -0700 (PDT)
Received: from localhost ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm68659585e9.12.2026.10.30.03.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 03:48:59 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 11:48:58 +0100
Message-Id: <DMI44C1VHP3L.1B6WSA5BOI6BY@linaro.org>
Cc: <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] clk-816x: add sys_ck clock as sys_clkin_ck alias
From: "Ettore Chimenti" <ettore.chimenti@linaro.org>
To: "Ettore Chimenti" <ettore.chimenti@linaro.org>, "Tero Kristo"
 <kristo@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Tony
 Lindgren" <tony@atomide.com>, "Michael Turquette" <mturquette@linaro.org>,
 "Andrew Goodbody" <andrew.goodbody@linaro.org>, "Rouven Czerwinski"
 <rouven.czerwinski@linaro.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
 <20261028-patch-ektor5-dm8168-clk-v2-4-dc6bf0fabae4@linaro.org>
In-Reply-To: <20261028-patch-ektor5-dm8168-clk-v2-4-dc6bf0fabae4@linaro.org>

Hi,

On Wed Oct 28, 2026 at 4:53 PM CET, Ettore Chimenti wrote:
> This patch adds a new clock alias for the DM816x system, mapping
> 'sys_ck' to 'sys_clkin_ck'. This change is necessary because the voltage
> management driver searches for 'sys_ck' in these systems and fails
> without this alias. By including 'sys_ck' as an alias for
> 'sys_clkin_ck', we ensure compatibility with existing drivers that may
> reference 'sys_ck'.
>
> Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> ---
>  drivers/clk/ti/clk-816x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
> index 3b8e483aec92..fe6f66fc5a05 100644
> --- a/drivers/clk/ti/clk-816x.c
> +++ b/drivers/clk/ti/clk-816x.c
> @@ -57,6 +57,7 @@ static struct ti_dt_clk dm816x_clks[] =3D {
>  	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
>  	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
>  	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
> +	DT_CLK(NULL, "sys_ck", "sys_clkin_ck"),
>  	{ .node_name =3D NULL },
>  };
> =20

I'll drop this patch from the series. The proposed approach from Sashiko
seems sound and I just sent a separate patch that implements that.

Best regards,
Ettore
