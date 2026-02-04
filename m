Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053461548C
	for <linux-omap@vger.kernel.org>; Wed,  4 Feb 2026 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770163798; cv=none; b=HecAGGcKg0JywdCMP4oaiRveFa3bGjtI52OtBS3lH9eWO5aOzH+9vrBdEnKBh6tva3ClJ3nfnQeD/H+0sv8SmKOOhvWhh/dGBG6GhYYF2KDSpP9zwB6Rp3VPlKquk1v6pbQML0m9N1VWQlNBRkeZkzTU8q2QPnfqkCm/rZElSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770163798; c=relaxed/simple;
	bh=r7f2YJ7miQLMROmcW15Cnr/tWaxkZgZRaVrAYVnvYQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWVvEZr9ldqLyUUm1eh/3Gp5b44ycGIJrP8gVBSOXXoWE2O/AOYUpc9VrAq+CeAbKfBBlPwhNPSt945JbuHRDmssOjrD2SbkZyaXWoIzf8wDrvEXp+kiUFCjqi498hOqXAUJPQqgjXkRx+J1CFst+WVQ2wu10o/D2+BeDlvZ588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6KBxrWq; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6KBxrWq"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70ce93afaso667080085a.0
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2026 16:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770163796; x=1770768596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7f2YJ7miQLMROmcW15Cnr/tWaxkZgZRaVrAYVnvYQ8=;
        b=L6KBxrWqNg6VdrFH3oLMOwDA8MmO3ZQTDo0FU9Zfr82iiqbsMOxzTmNZ1097aQX7Q6
         4iTLX+VwwrNSeUPC1RFQf/fyguwW9oKEjp1q8QT8greEpF2LsLbtVWasobBDHHFkztvS
         ZXlfV6pL9Am7ALKG11L3BGTykyE975ygDjZ7yDN4vAiuLWmVlnGPpgmZ36WRKK//TUKu
         seGbanMvDbuagTdh+lxvfjMbTUDhmlFgBno/cT4qQIH9gulUQnefUfTOYuob1IN2PqWG
         2jNFry3udIrGYOUQOj8HfJh/6uhnjzACciAAxnJ9HzjuALnF24LVqUE2c/+xjTlvNknb
         PfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770163796; x=1770768596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r7f2YJ7miQLMROmcW15Cnr/tWaxkZgZRaVrAYVnvYQ8=;
        b=kxqz+TOzFInuUVXmyanEcxwsdbVtkm5RSZpgHnq3oJlwlJzQylFTJr1+r/7GT6cWNy
         lWzZQVFhCPd/i3yF6ijmAAXRGH/2hNEunO2p3nVID1Bi4L3zyLyLDsl6zHXKNidKCb1v
         0aoHKsokWzGJHjWBbGO2DP6PtnfsI0vibu4icrWDutqOfO4bxSZTHYtNPxaHDbx2Hh2k
         bcx2ape72lBJEmjYw0wvLt6stzzvP5Go5rwkJMIzC6zRvhsHsf8n3VZKXE2gpLkE2hbk
         ntcRO+sGprSppoHGXFY6US/VQjyLXawRMYxTchLmbpQkTklmrO2LlchvoRkxMyL5Gq3y
         ZbJA==
X-Forwarded-Encrypted: i=1; AJvYcCU+oq2+pwdEVGAuOqYlfPBXiZvM9UPT8KMosW09+tBahhEpALRvcWkJ1RIkkmGzPM1NxZtkVk3vGxJB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15KYAdr4OHyKO+GFVQCN9mHjK/koBYmLMZFORcM3eskbHtPPZ
	M/ezBSKIy9wLR5nIAyrvZnCpBAZBwYIwNZHRS0lkT/nUxtL3aIwKNRFD
X-Gm-Gg: AZuq6aLMd2LBUM7hMzOw0UYrsjOYRbgsURc2VZ8jx18IsuAu2izwJKOpbIL0ClHZz3v
	M7NZkvoFSYrBZea6Ers337zLvUvJh2cu8W9GFLW9Ss8sk0G2cjuS80D0uforeV81YfuQD/19uwQ
	UUqCDSm0s+KgKKySytcP+p3/ngOyPCjjULpA0VGxhpr5mi7HspKdlbaHedO86qL/K5b7/wmTtFe
	MGu+eHl2/qtGWwi21HO0ddcky9M1m5BmrNrEp47HU7jGeNtpqnsfMsaXpcg6y5T9lGL/UIBCzAP
	28Q3AMNt/zfzeSUg+wggslOR3mxPo7rcN8PEDYFBhLZCA68iCfP7YwpGAXVILFl2bpkg02phZUq
	60xXIZHfXLL2DoxK6uEaqgxk6FjdGntBj/STe4AFNyVar9d2LoHE/lDWI2dDROHEhqzAeQz8y/W
	Fdj7WQ9DlAoC/7wpja0UakdV7eg/qIuX0S3f1Q2jgkIF1RpUjOmdfrtT+4PQ7GV/Cw8jfJ+m4=
X-Received: by 2002:a05:620a:4084:b0:8c6:a82e:16ba with SMTP id af79cd13be357-8ca2fa94d53mr165063385a.84.1770163795867;
        Tue, 03 Feb 2026 16:09:55 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd5382csm70897485a.50.2026.02.03.16.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 16:09:55 -0800 (PST)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: andreas@kemnade.info
Cc: aaro.koskinen@iki.fi,
	airlied@gmail.com,
	andrzej.hajda@intel.com,
	bavishimithil@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	jernej.skrabec@gmail.com,
	jesszhan0024@gmail.com,
	jonas@kwiboo.se,
	khilman@baylibre.com,
	krzk+dt@kernel.org,
	laurent.pinchart@ideasonboard.com,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	rfoss@kernel.org,
	robh@kernel.org,
	rogerq@kernel.org,
	simona@ffwll.ch,
	thierry.reding@gmail.com,
	tony@atomide.com,
	tzimmermann@suse.de
Subject: Re: [PATCH v5 5/8] ARM: dts: ti: omap: espresso-common: Add common device tree for Samsung Galaxy Tab 2 series
Date: Tue,  3 Feb 2026 19:09:53 -0500
Message-ID: <20260204000953.299628-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202090408.4c3757cb@kemnade.info>
References: <20260202090408.4c3757cb@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> We had the discussion. This should be done via pinctrl irq if possible instead of
> specifying WAKEUP_EN here, You had some trouble to understand how it can be done,
> and we agreed to add the wakeup functionality as a follow-up concentrating just
> on that detail and for now just remove WAKEUP_EN.

Alright, I misunderstood as keeping it and chaning it next time. I'll
remove it.

> still this strange matrix. This is no rotation matrix. Determinant is -1.
> Something is strange here, so also the idea in our earlier discussion was to
> also postpone it and maybe separately discuss it with iio.

Similarly, will remove it for v6.

Best,
Mithil
