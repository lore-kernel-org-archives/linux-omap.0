Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3124F5DF2
	for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698478; cv=none; b=HXnOevIdU0+GQd8LXGgiy/NlXiOgu5/rGr9pIGNYF2yXycZojUUpdORCDRn5AH0hX6XbvmUZjr3wTgHYbW2HtQ0mjVh+x6MOeIvnJaUrJhGKJBj3OS1gdztISxiJMm1FzloLP5DhPMGJru0KihrVioyUsyLOud0w17Cpf0ZY0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698478; c=relaxed/simple;
	bh=2qKarXk++NiBS2+5AKJidUXBeAghThgQE8g3f72zFz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CaTHHG1txVdpKBvkb8g9Tro5TnCfZKFVOGgwnMRFxxABvB2FW7eOTJJBH5alJJboe3nRvi68RhfiA6wKxanXN9uE7tpSBJ0F8amOM8g/EGags8SVgC1yPlM4uD6nOIxggThjPGErcfgWIpFi6BdoAA5Vn7lU7BD9kcy7iF895Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Twq0z20Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+ZPdVGP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Twq0z20Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+ZPdVGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790698475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bmtox2s6c4TjZwHbdS6FzVWAuk54pYg3rXVMuHHI2Ts=;
	b=Twq0z20Z0ZhOZvgPnjkMQKMZR8P3VL1HAnoJ+j5dKpDWLDKhgttqG2PyLbEMTYTJYAPtqi
	FM82hjHzdHGKIk4VZAHykE3i6WBkXnr/AhkQHlh4mxSx2ZIbPNEXYr/yEXEOubNhkYw49L
	JbgvHBtH4TilFkz88PjYHc5uw01suRc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-AshZEnAKMiOBrKS6dDXUlg-1; Tue, 29 Sep 2026 12:14:34 -0400
X-MC-Unique: AshZEnAKMiOBrKS6dDXUlg-1
X-Mimecast-MFC-AGG-ID: AshZEnAKMiOBrKS6dDXUlg_1790698474
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9123c523d0cso49886406d6.0
        for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2026 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790698474; x=1791303274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bmtox2s6c4TjZwHbdS6FzVWAuk54pYg3rXVMuHHI2Ts=;
        b=f+ZPdVGPm9TsbOIQjywD6IOf6qQSUfAXBtBpE5Uk1ipp6BdvN8fNxDRZnIeOSL2wv2
         Us+yOE069ntqWlY11lRiTxfTWGECqaTeqPTzpzq0FYwxYx4q0VNFdQpM8+bNRE1QqW6p
         0xGfP9DQVHskfvsQl6aANiXHRgZIDnpemVvpxk7vNFacmEU1Q97ExBDO3Y5PnILJFkqb
         bdUCOVivH6qfH/yfYMSUufzSxAKMudP/Tdi/hGGUogMJgyfMH7+7haOxhsIVRfHAg/SP
         LScf1NMpcV4n6CCTWJ2qNQM4JYmVZKNVy+z6prPm9EKr/ONI4T97jKtFScPMgQP4mF1l
         18cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698474; x=1791303274;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bmtox2s6c4TjZwHbdS6FzVWAuk54pYg3rXVMuHHI2Ts=;
        b=Y82VMxOrvtj+J71YHcdsTFV7kXQMd00s3J2Cv/YZFc+WQWAKj5ENd6TAfBEw2f6c2Z
         9O2+kiuwxrHEyR5QRShkwDYTrG5c+IKh7sEr9B+hDvo5H/JX/RG3rd/NFCTYFIHHNwus
         zpr0LNDmSaxaLZgf62twtped/2ztadgtr+PEOPIAG2hltxUnng9LYoqrYzTdmoPqCqqv
         pfVyAtt29vu+oniy0bQWMi+mAtG1riwmZKvDN+GVkcBpkituDnRsmGRJGGdyUHw1Dz4D
         a6rs8zmE2nPTZUDVuK0Wb0JcZnG3UP7kElB7QU0xaBr/wBA/8F9wMeoD0k5WndGV37vB
         /fgg==
X-Gm-Message-State: AFuF++meZkpDwxZrHJ4y8tumJ/vTAFhtDNOlOBuO0TlLK2azRyTIXTHX
	Z3+ffksFcIqLhcmZnutUwB6JENK9DLFuQCN7gmuO+pEM0pUF9Gd3BvQEpdlTT8r0xVSeA0tENOQ
	dl2m5vDOymrMh0VzCznhVu09FkGhfd406Begp30HM7qwvWpTLQ3zf6OTOHK6xUC4=
X-Gm-Gg: AYBFou0G47dWeDwy+1QfBgZf7X2am4g4kWs2NgnuHkHySGtZiPs1PadvOeBrQ4VO1Ya
	xyb+EgxxysmoQVE4/yCRKvZGbi4ofLkx50J3iuXCBQDnp66WBAIDZM/Q081GoYDsZ/KQDS8T9om
	z1W9bZlUaBh9opSFBtLj1wU59SCkfROA9pi8I2ARbLm8Og+jGz4158BDn1oOfZq7tFVzLzqhpYK
	02poG9snJp3FmaSJFMIGPihclS3m9/GXSuBvgLBRCFCaCy37M6wC7OSbp3d0CIkRaxz4nGHfA+s
	iHpjUMpt+hDOchA2RXjMZz5SnwHU4hyPV9ufz1RGlesV5jgS9wY3frF64nie9YSMkjfKYw4J6wS
	gioVIecryEMXLXlTywuCiGVWeW12UVM3ZrYt2UaoSzlHa+PtivxI=
X-Received: by 2002:a05:6214:29ce:b0:8ef:4ed2:316 with SMTP id 6a1803df08f44-917819e1cb7mr71156746d6.1.1790698473771;
        Tue, 29 Sep 2026 09:14:33 -0700 (PDT)
X-Received: by 2002:a05:6214:29ce:b0:8ef:4ed2:316 with SMTP id 6a1803df08f44-917819e1cb7mr71154666d6.1.1790698472201;
        Tue, 29 Sep 2026 09:14:32 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d326112sm13448196d6.23.2026.09.29.09.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:14:31 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: Tero Kristo <kristo@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Myeonghun Pak <mhun512@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20260626094134.71961-1-mhun512@gmail.com>
References: <20260626094134.71961-1-mhun512@gmail.com>
Subject: Re: [PATCH] clk: ti: adpll: unregister OF clock provider on remove
Message-Id: <179069843542.199845.6686423279941894529.b4-ty@b4>
Date: Tue, 29 Sep 2026 12:13:55 -0400
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=313; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=sd5tjkRycxPIdAX6vTAKeWmD87abOzSi5YgkalY7KF8=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJ2P36w9WTuFvH2Necu/j0fcb/T/q3D86WPc5y4Xz/v+
 7z6nexLq45SFgYxLgZZMUWWJblGBRGpq2zv3dFkgZnDygQyhIGLUwAmYv6IkWFO/fmvx1h/80sU
 vGP8/GzNzqPvLtisuyBjGV979unp/z+OMfzhjM7o8re+psN3fuux439enjRm3Vq9w+nHycUx+Yw
 ic6OYAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Fri, 26 Jun 2026 18:41:26 +0900, Myeonghun Pak wrote:
> clk: ti: adpll: unregister OF clock provider on remove

Applied, thanks!

[1/1] clk: ti: adpll: unregister OF clock provider on remove
      commit: 4c943ddfc24340f1b899762b1ff35c38306b7a35

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

