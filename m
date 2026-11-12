Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441671;
	b=AWDPfLf0KRrWLWqLbQI/y+ihqIVUt+IKfoWGHAagOssT1hT7dVyXMg9OXk1/PR8zbkFn
	 qerWZZjq3kR71WJ1QwNba4F8+gUtt/BeuMoXnKi1Iui7HJlNN9cBf/KfsrXgvdYTd3KN1
	 jarsawMRaMqirpPPicS37nS1O/Td1KFxI6X9jpOcX/WfXvFug52stItddVx306gcAbwMy
	 vGcHZnbUa41OxpvxPLYrnvrgAZygmf84KN0z8JXsMo4NKPHekwLCXjQrGKmSqFNHpE4qe
	 GI1QB7HovZZuoHqaKh/dMZfa1ftbo4qnweaPqkvgYf+lgcW3FBwXTHPglHGjJvGsE9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=BGxV5GaAPR9OQc9tbH3qdasAzMttEnvIDguQ3NY5O90=;
	b=q8x+V4wPB5l7aKk3Dy13yCMad10Zaa0X41k0lkTSDjT8uWLEykRWMZybfGg2tjX6vtuQ
	 2n5zqdoM7uQH96pWFm0pMgZbGzYbt+r0cZ7oRYpKR8oR8C03JeYKlYIR60lTylrGHSJLK
	 xj7rYY+p1C9D08cdv5mvk6OwtH8U2Z5PgZx2zapPbQ3Nti7C7b/ft3UCmZpV2CHo7feNI
	 ITojtaVqzjeFs3k9nlPROruNrAtiI5Pz5Fn7Cr9C6apT0stuu/6GR4vWUhVEbVDHOH+Rg
	 HnLRmiQSm/EWizirPGPnixVZzE7x2mGfGchZT8g/x9oGZukEd8hFIrs04FAHv2+B/Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QoMKgKL3;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A5606A326
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 00:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576A5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QoMKgKL3
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4901ac93584so1710980f8f.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2026 16:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794441669; x=1795046469; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BGxV5GaAPR9OQc9tbH3qdasAzMttEnvIDguQ3NY5O90=;
        b=QoMKgKL3rV955BcfmYWa+kz1zAoJHeg5BXr1efXWWPYY0JbYXMz/cLzcDP0gHSPTR3
         MYJSo/8RE+0AeuYBp0DSZtsXSsBOlcOLDipbvXLljn0nXcgAuqQsixCAsJR+nSMFQxKW
         Bam5Otsx3UyWqOBpwU02V+n3mAd1qT6q3xG351GpJENyyXmH5O2GpZ5gvUNHCK6/Uq7e
         ifeZom2gExj16fIjIb40SJmr695Iz93fEMPDj+84NcsI0dA719pMs/D8q9D/Iuuz+QDK
         Ci6vZVyBmE+lb3mEc0Kshgw8M4HoStp1RY90uP8Xv/gnFe2rwGyftshM9FuUFQ08xcr6
         Vzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794441669; x=1795046469;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGxV5GaAPR9OQc9tbH3qdasAzMttEnvIDguQ3NY5O90=;
        b=uJvtNVSY0Ye2eCcICiOibdF2CH7C0VfPrhU6yVhqH72ePNuWsWbYQJXl/J6YeOpnqp
         ImgO0+8G9Ekmf9hzB9d6OyAkZZKLP36BICfqwvBHLaIcyRYuINAV/+ev3Lo5DDmnN621
         QfByIVglWYAUv6K4Od2wNZfH9FOLK6zNTTd/14PQ+rV0johpHMoq8YTNyQLVFVn+BH3J
         mRH6z4eTXT8Dpg46qWlhQ5GNd0g66e5XZAz2410lqs1N9h8pQRCBggxES7BDgA76hMnj
         JS73c5tjLwHpjN4ZRWU+Kc6oZwzOvFJoE8pA8jetYNEcQYP8eQXIjsJMDY2burGy2VxL
         8tTw==
X-Forwarded-Encrypted: i=1; AL+hErEGXOHqgXaEP0gFXezAkk7WZ+WOeSq/iMVyO2AEb9bbd0VzdLY9i86Ilvid7wKT9V5Nsr/LP04mzkcw@vger.kernel.org
X-Gm-Message-State: APuU4Z+FZyqGM5ea8SzyB0QowyreyajkHARBhgKGTLfb3+KdcuxwgAbf
	2t45JhKUy7/i7Q6NU6q/HoUjCwPSxnqxZFHgNqQgVz7OSuTYZwBEa6wTAp/+0xN/tzO5OGkuYqF
	uxlhyO1AiryzT
X-Gm-Gg: AYBFou1bLSC5TbpmeJTuB+jWej5qncpKxIgsZEJKlamUOmb6bnzOzoAvmDX0lW/TlaJ
	8lwhxbTxdylpN2uVawvfXfYbNVuiimfnY/CX22PCNy7UJeL/1x2sU68DZm/+o4T6DXtwOKTYSdK
	Uk0bFTNgqikrIcOwWNBHC7ptk9DjZWNiwd/f5SrN9m5gUpw60kBJ6nod6Mv5rrc0ynpObffdPfR
	LC1DO0FJua9a+9f4aE/pR9k2mBvetLTjTX5WxGslK6RMIwIZVRhTYiLhgCQ3J+l3URSPhEwyIIc
	SN14jn3yQe4ALNNmVyD9k/D0Ss6ue5EFWOxvxeshx7nqISJJf7f2+4iWCL3ACbtq5zie5Awpe5t
	k06NBRmO0Sew6+/a6l6iQUFSXF6X7zC+Pyc0M/aYY7vW+TEVBN95Pr2m+GtHfzaFRx2U3C4bgLe
	2kYTgnW5OwJ1tqSU95tB/d1XamnwsifIYwbhFklYMYbqd5oH7byEfNKVDszz0KgfPFzNrW8Bt1d
	plZnA88khaY/zBQKyWgoYV/JRGPRB2piW22QBgmeZv1FZ+PsSZpr4xDWyXz0ygUCF+VHDh3EblM
	0XmYat06xBj9O90zHQXXVyL1LSCTKKcdzlrvOoT/wHtdD4FSfQ8DtIfGklUTu6EWbu2mx4bwMB2
	i+/VH6lv5mjT+PO6/PQDyUVssYvmm7v17eDzTikM1Jg==
X-Received: by 2002:a05:6000:2002:b0:48e:f10:ceb8 with SMTP id ffacd0b85a97d-499c8982645mr6741108f8f.11.1794441669255;
        Wed, 11 Nov 2026 16:01:09 -0800 (PST)
Received: from localhost ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbeedsm13418776f8f.43.2026.11.11.16.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 16:01:08 -0800 (PST)
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
Date: Thu, 12 Nov 2026 01:01:07 +0100
Message-Id: <DMSSHDUVX4J2.1YGT58MPOQYD0@linaro.org>
To: "Brian Masney" <masneyb@kernel.org>, "Ettore Chimenti"
 <ettore.chimenti@linaro.org>
Cc: "Tero Kristo" <kristo@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>,
 "Brian Masney" <bmasney+clk@redhat.com>, "Jerome Brunet"
 <jbrunet+clk@baylibre.com>, "Tony Lindgren" <tony@atomide.com>, "Michael
 Turquette" <mturquette@linaro.org>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Rouven Czerwinski"
 <rouven.czerwinski@linaro.org>, <linux-omap@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] clk-816x: add sys_ck clock as sys_clkin_ck alias
From: "Ettore Chimenti" <ettore.chimenti@linaro.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
 <20261028-patch-ektor5-dm8168-clk-v2-4-dc6bf0fabae4@linaro.org>
 <DMI44C1VHP3L.1B6WSA5BOI6BY@linaro.org>
 <179442321741.1131744.1980930320808367339.b4-reply@b4>
In-Reply-To: <179442321741.1131744.1980930320808367339.b4-reply@b4>

Hi Brian,

On Wed Nov 11, 2026 at 7:53 PM CET, Brian Masney wrote:
> Hi Ettore,
>
> On 2026-10-30 11:48:58+01:00, Ettore Chimenti wrote:
>> On Wed Oct 28, 2026 at 4:53 PM CET, Ettore Chimenti wrote:
>>=20
>> > This patch adds a new clock alias for the DM816x system, mapping
>> > 'sys_ck' to 'sys_clkin_ck'. This change is necessary because the volta=
ge
>> > management driver searches for 'sys_ck' in these systems and fails
>> > without this alias. By including 'sys_ck' as an alias for
>> > 'sys_clkin_ck', we ensure compatibility with existing drivers that may
>> > reference 'sys_ck'.
>> >
>> > Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> > Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
>> > ---
>> >  drivers/clk/ti/clk-816x.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
>> > index 3b8e483aec92..fe6f66fc5a05 100644
>> > --- a/drivers/clk/ti/clk-816x.c
>> > +++ b/drivers/clk/ti/clk-816x.c
>> > @@ -57,6 +57,7 @@ static struct ti_dt_clk dm816x_clks[] =3D {
>> >  	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
>> >  	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
>> >  	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
>> > +	DT_CLK(NULL, "sys_ck", "sys_clkin_ck"),
>> >  	{ .node_name =3D NULL },
>> >  };
>>=20
>> I'll drop this patch from the series. The proposed approach from Sashiko
>> seems sound and I just sent a separate patch that implements that.
>
> Will there be a follow up to this series for the clk subsystem? I don't
> see any. I haven't gone through the other patches in this series. Or are
> just the first 3 patches here what needs to be reviewed / possibly
> merged?

Actually, I was waiting for reviews on the other patches before sending
a v3 to collect R-b's.=20

However, this patch (4/4) can be skipped reviewing. It will be dropped
as I've already sent [1] (it belongs to another subsystem, so you might
have missed it).

[1]: https://lore.kernel.org/all/20261030-patch-ektor5-dm81xx-vd-v1-1-8ba90=
608c25b@linaro.org/

>
> Brian

Thanks,
Ettore

