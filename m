Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F93DFC6A
	for <linux-omap@vger.kernel.org>; Mon, 18 May 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085488; cv=none; b=ldhXwHcetGEBT7C5xrbntiNnI97/aclFYaQM1znZhl2el1/LTZ+hMSHhA+tHFHOnanaenoZX59SNFkLS1UM9xmBLbvPl0oITTaakH6phgSFbb7IHdWadxLv5hLOkDepvjiyTLQgpFLD00zcs6cZdXONVurHWd6NBsXAEKGFQvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085488; c=relaxed/simple;
	bh=TNwJr1jchWZc67pG29qjhg66q50p8XG7WgD9vWPGSnU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T7az0H5oymOMtmi931Kr9weqPnZmN7O9ZuU4Z8EdaKufQfoBSEUjOGYl/SAtmqc6BUyz9bWohKP3iRezVY7OFj38USKDkZJpvzXLUOWT7Ll6ZMzAsHoJ0VSMs66bdF8Ai9ekzooMPpqwXM91ZbqhNWWP4oz4gbSxnD+hwXinjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfeOIIp1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfeOIIp1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b788a98557so10225295ad.2
        for <linux-omap@vger.kernel.org>; Sun, 17 May 2026 23:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779085484; x=1779690284; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6rttZNdlncllwagKtpxOSQR52e6wAArMQpo2L8w5Pg=;
        b=qfeOIIp1xSXdXf+8Y5wjCVboqWseIkCHKWgi3qQjR3RzAIwt5eVDNdCxpbib1kERXv
         iSoG1TJajuWEuEDYNWriKaBI4DJ5YpQbfmmP3UC4wI5ii/VOjII1hNNCaSgFK4iBaUaX
         fFWHV6E0yMl9s3cSNGVk1zbkTGAypXcbDKzj65ylHqgH41zwlydiXsxSJYui3GcPHqYs
         pqb8F35vHUn3ZBvQ/BT8rMcCAakjJ9W4gd++se/fVJaMKjCX2//u+rBCbe39Rlvo/kpQ
         dpqz1OvhVg6eubVKOj0qJjr5pSczwzgsdLwhpUSGdfSUSIsSoT/GzrqbvZlSK3dGU6CM
         LvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779085484; x=1779690284;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6rttZNdlncllwagKtpxOSQR52e6wAArMQpo2L8w5Pg=;
        b=RpDuzX1vWwqc5Qd6MDXsepgnQn8j3p+eZXofePz05AVfKvUuM12WdaSlfWhFe/mCiR
         IJVjAex8XSWiS7Z47VgpuRYvgYBkGNenF1I6d5s7VS2DXp4QlNh8WXoQY9yAahYreoFM
         QYbio8VzSXHINERBI0/Ahe/ngcVvxXZzX3kk/i4Xb+Lqj5wJyWBcl7bjri7DL3t01Sca
         qGO7/qasenJZdP2f8b3ce8POu6RqnGXiLUrlisN7Qr4/bIyvXOam0g+piqqP1Qtn/8A/
         nAZJH8I2FljAU88i4OgFJ+RHmwBy0zPdeHQqJHMWqpSEkVPNUgAJMbhsPHGA9VRzO6s+
         c8WQ==
X-Gm-Message-State: AOJu0Yw8LIG1xdP1+4sIUpj2IezXsLeKdruirf+S8VL90CFlvXIC3uy0
	6NeBZhp2OFSJiORtwdRNzAYvp84vsp5xbYKOy+gxvELuzJybviSYY++H
X-Gm-Gg: Acq92OET2YRyGDNtz1e06ucogo4biGgmfzWKUYswvE5B7SnvQ6M76IKSBoGwWFsK/7b
	syts9Al3VGHAEUK23DbSTSCM7+zqYv6wTvlkEZNvRcfNB7NMyJ3fhRwdfMH6h98fcfQHn76Ubvs
	kByt3v41FDSNa6ViatVN0nhkh3fxWFExKo8/yIdJCY6RyFSMBFhkEHyZWZnVK+Z8mbpl+wSiNoZ
	DQkAoGC6RrG2o8n4uZc8kuW3M5RUZeEu7Ed5tBc+Efl8X7pdfIexvJgmCgfVA0Vo22m8kYmtfa8
	GYGwQOuGYgltoFPGvGAFX8ZQgXh0n5q//5MYR502o0Jg3p1v6XzGLzN3Guew6hDAH5mOeIZuXD7
	xnlf0/jtwujMu2mkCxWjx34aBkd9vRtb66UaSOobPGaXAwh+P7TShHjd6K0K1ve8LpYiykoBys9
	9oRNv4N/OALCbrZIwDKySVvsxpTN+5yk1bN1YMXs6pqNy/79hTx6I/+A8/LoX6lyXRLbEVnecO8
	MsRJYZRORW7l2X+Gb5ifKndiD2aym4zJUwjXK48vRlwiNrAGBw=
X-Received: by 2002:a17:903:1b4c:b0:2ba:7610:3f21 with SMTP id d9443c01a7336-2bd7e802964mr144520365ad.5.1779085483840;
        Sun, 17 May 2026 23:24:43 -0700 (PDT)
Received: from localhost ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d235e04sm140491375ad.80.2026.05.17.23.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 23:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 17 May 2026 23:24:42 -0700
Message-Id: <DILL63IHZU3T.15YECJHURQZSC@gmail.com>
Cc: <linux-omap@vger.kernel.org>, "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Kevin Hilman" <khilman@baylibre.com>, "Roger Quadros" <rogerq@kernel.org>,
 "Tony Lindgren" <tony@atomide.com>, "Lee Jones" <lee@kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: twl6030-irq: Use of_device_get_match_data()
From: "Rosen Penev" <rosenp@gmail.com>
To: "Andreas Kemnade" <andreas@kemnade.info>, "Rosen Penev"
 <rosenp@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260518041558.765958-1-rosenp@gmail.com>
 <20260518074631.532e25dd@kemnade.info>
In-Reply-To: <20260518074631.532e25dd@kemnade.info>

On Sun May 17, 2026 at 10:46 PM PDT, Andreas Kemnade wrote:
> On Sun, 17 May 2026 21:15:58 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
>
>> Use of_device_get_match_data() to fetch the IRQ mapping table directly i=
nstead of open-coding an of_match_device() lookup.
>>
>> This also lets the driver drop the of_device.h include.
>>
>> Assisted-by: Codex:GPT-5.5
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>  drivers/mfd/twl6030-irq.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
>> index 0ca00f618d4d..8831c81a1f90 100644
>> --- a/drivers/mfd/twl6030-irq.c
>> +++ b/drivers/mfd/twl6030-irq.c
>> @@ -27,7 +27,6 @@
>>  #include <linux/suspend.h>
>>  #include <linux/of.h>
>>  #include <linux/irqdomain.h>
>> -#include <linux/of_device.h>
>>
>>  #include "twl-core.h"
>>
>> @@ -293,10 +292,10 @@ int twl6030_init_irq(struct device *dev, int irq_n=
um)
>>  	int			nr_irqs;
>>  	int			status;
>>  	u8			mask[3];
>> -	const struct of_device_id *of_id;
>> +	const int *irq_mapping_tbl;
>>
>> -	of_id =3D of_match_device(twl6030_of_match, dev);
>
> twl6030_of_match is used only here.
>
>> -	if (!of_id || !of_id->data) {
>> +	irq_mapping_tbl =3D of_device_get_match_data(dev);
>
> so how should of_device_get_match_data() know about it?
Ah looks like this is wrong.
>
> Regards,
> Andreas

