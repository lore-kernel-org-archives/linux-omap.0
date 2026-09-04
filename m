Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B44A43E0
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530138; cv=pass; b=HQKestnPvPIFg85S+Umrx9GVVBIdNUFSrfK8b6Pa07LsTwx4qHJxIgW5bsLB/FIPIHriX+bbWNXSTq8L4k9Wux3KF1inRRfcvML9ZPt4K3aGdecac2U0gXJgUgw/7/Ud9eLs1LJ7p1SBrGllMrvDLMZIEmBVGzoG0frrUotjITI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530138; c=relaxed/simple;
	bh=aYGTw43PGiruYrbCRK8lrDyOCcUgVMqsAo0cR/fDfeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mfw0ljRzhjqfTFEpT+fNIpsqFJb1nAK/+fCXSRYoyUeOGnhJh/ZEOlTUheyzzzaBrrQPAPgRGgk6wdG0HtdAvf3ADnOoyY4rJmWF0saKQ5p06pDqAPWOqzDUI/YVgmo9CCMKpDQo++dYrU+A+G+GOquKw3p3fxRSnN72W6ZMCZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCxxW9q4; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCxxW9q4"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c262204cc80so17355666b.3
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 06:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788530134; cv=none;
        d=google.com; s=arc-20260327;
        b=J0GMQ/kSp9z5usxFQXBG83vodpgJXyTFcQWa23nTkVkeH6zGMwRHarhHQYCENx9PhN
         +5EG68LHtBg4onNbnvgZaVAtAyBWSrHwai6f6JdtJbUnAl9mKdX7fb2KSYr7Ov+ozmR4
         OOperl2D1+OSp2i+1dNyxjXC3p01EzN54xs71tAyLD8YzYkoF4sA+DC52TBhti07l3A0
         12v8+6Z4U2Z1fzHnQvXAwGcswmxUzdbWIj0Dq88cu+nlzNJwdxliF8/by7pn3RuT3v7A
         5vmMqtYLSDb5SVeUDHvoxdeUq8/Fl8l9CiIUgOYBBrsQc1j4y2fWADN9C/eKMm9ud5Wh
         aO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pkjDjgzDaw86AXoG1909ddrRynkL4ufeKlwmjCrQJhQ=;
        fh=jMOZrJbIGRw95zqepVI99OTAVptDA2KCbOLHtpF7rTQ=;
        b=CglrEJxyXA6mp5wwF6qrkpIoHBabl679vKbTeMPteG/bhm7z3WoSLDPckJb2chDbik
         DfDvhYB+4U2IuQnem56RkC4Mu9uhpeylZiayxBnAchDkaqYbxh9nPNxVJmqKkQ5Rtpfh
         a4AL7SBmRzgc3Su1soNBmYLqKnwsYIxp9MwVOsBQfCA7wz58MkHmnTp7dcy7fW+fKQGy
         168tsFQCVVWFDpPJzSrMf81QJu5kFrQX61k4/TYVCizDOT1e87410WG5OrNFYvLqoNYi
         ZUs6mqDbg2idTlnwcHPnWvKffyIpl3JTxIkr32xypFg5qMCpUk7MIDtRRFmTNjyIxTUN
         ivuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788530134; x=1789134934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pkjDjgzDaw86AXoG1909ddrRynkL4ufeKlwmjCrQJhQ=;
        b=kCxxW9q41x6acDRBBZDVjfyTyqKRt/evee3/RMJ64zlf6SHrFgHtykPwYzwvAi3wVJ
         ZRIv7vOTkQh2Lr2n+smSk6EZDeGERL2XnUVdkdmbijX3sIq8nHQIT4bwdKQG9VlBvxBC
         8naCTVcUFcfSQHMrBLpJQGzu74JQ2aIQws7AXtvIxc14zHervNOo4KbpAp1FFOqd1BDh
         8sOIjGi6BVaoHydFmTO+nYefEIeAAEsXLvyc/0L2/jipTutRInYXfOINnr0YZQVJnXHl
         C2LFuM/tqHwSMwJQDQ8c+FIBz7PMpJ9MUu/9P80i1Y2oORNVkVuubgrLsPndLlRYakJI
         4DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530134; x=1789134934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkjDjgzDaw86AXoG1909ddrRynkL4ufeKlwmjCrQJhQ=;
        b=hsIhrqMiVZxpToPDtqOf4V2HOFvcHYGkOsi0+/MSi6D95+QOJVACBI4+iqffE31Nnj
         L3lyyQ9G85VlwhL7M1zqHXJqW/7wbfOy9Ui4DIIrs8B3wFWPmNrffOGzyfUU0jdAToBt
         RoufSgY32HMrronXkmvdVtPR03NT0bdHX8hDlH42g9VqpwGwtMrOSA9Y21Owm1ua/p8D
         5k/zbkPuVDm1qMIZv17qV7y6qDyPMHT+654c60xsKBJpqR+aj64hfA51WrKTwEUJT4m4
         KbJ1dwEn5q63EAksD6ZdcFC5V88jAGMnEpuT6xyKubUul0CAHbiomRQicZ5T2l+uTQwT
         eQow==
X-Forwarded-Encrypted: i=1; AKwUvBwX0g/4xU9GAK1nw9wtkR88QmzMzQUzVRH1k0AfATec8cIX+HN/PT6rUfMYRLx4bj1Mr4ldpjkd818i@vger.kernel.org
X-Gm-Message-State: AFuF++k1Wrr1POJKV5u0lwVAnnHAVz1UaOHVcl9T8YUgZslJUZO8C6vM
	/gCL3MJlVN2sYNe8V9xRjLz4P6jtsFEegPC7t68D0czHvjMAa3stB1U2HGCi7yoCo2H5dw2tZtn
	0zL12vkKPjtMzCK/lSP4gg7cXb8MfLZ4=
X-Gm-Gg: AYBFou3nXjH06/n3mdVHNYRiA/osXO2U/fbwUFy146fVu0+5uJc91FDFE9NLn/lbsn0
	4PGjuRozFjLwfyG7uEMgGps+/NSQKf1AIMQZ7hD/q4eMEMiB+na+1PGMXmYPV+1or8L5t2hN+Vj
	OiadeGiSbvXEolxW2YJsxcMp4NDZagYhjzsdIgCkO5mTsbaHzBxe4GtGfLYxYOddpFVFwImgu9c
	fzhoXCoie9qqWdkI9zxPAwSwHtFInkfGzWUYKeeDdszF9nqGBZ0T3qZGu4e8nfL1++K1qBY0oaN
	QNFjq3Cb4KKmNI7TNCwv04votr/3FZxdN90NiiZXfKTb1FCfI0x3AP4+TGZH
X-Received: by 2002:a17:907:720f:b0:c25:5d2:acf0 with SMTP id
 a640c23a62f3a-c260c8c21d3mr311924666b.8.1788530134042; Fri, 04 Sep 2026
 06:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-21-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-21-s-vadapalli@ti.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 4 Sep 2026 10:55:19 -0300
X-Gm-Features: AcwNN1WkMLBcSKjjx-549nVRZ1ZETkJHm5sDyQYa7o61EdbIDExabOintEMeFfo
Message-ID: <CAJq09z44PfcEKsoH9eP+c5rxmzQ52hQO33k8sO-e6po1bpE6rQ@mail.gmail.com>
Subject: Re: [PATCH net-next 20/33] net: dsa: realtek: rtl8365mb: Remove comma
 after sentinel-entry in match-table
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de, 
	mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com, 
	jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kurt@linutronix.de, hauke@hauke-m.de, chester.a.unal@arinc9.com, 
	daniel@makrotopia.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, 
	linusw@kernel.org, alvin.sipraga@analog.com, clement.leger@bootlin.com, 
	justin.chen@broadcom.com, dlan@kernel.org, rogerq@kernel.org, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	opendmb@gmail.com, andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn, 
	amadeus@jmu.edu.cn, kees@kernel.org, tmshlvck@gmail.com, c-vankar@ti.com, 
	horms@kernel.org, vadim.fedorenko@linux.dev, daniel.zahka@gmail.com, 
	nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com, 
	haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com, 
	lgs201920130244@gmail.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em sex., 4 de set. de 2026 =C3=A0s 01:39, Siddharth Vadapalli
<s-vadapalli@ti.com> escreveu:
>
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/r=
ealtek/rtl8365mb_main.c
> index 4c305756116c..f8220d832e46 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -3352,7 +3352,7 @@ const struct realtek_variant rtl8365mb_variant =3D =
{
>
>  static const struct of_device_id rtl8365mb_of_match[] =3D {
>         { .compatible =3D "realtek,rtl8365mb", .data =3D &rtl8365mb_varia=
nt, },
> -       { /* sentinel */ },
> +       { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rtl8365mb_of_match);
>
> --
> 2.51.1
>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
