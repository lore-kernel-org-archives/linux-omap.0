Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794725129;
	b=r0vqpCuxkV9Sxi+wO516sr7+8oJhAOnJdc7tK5SqTNdT9A+EGLQEUhxNWFeXIDbpnI72
	 yQAbbS3Yk5EBLmiUdgJErU7zZ+OcePjAZX+Nf6F1ZjzgUc01C7UA13Snxdtht84aTI07Y
	 39TMS7lf6SJ4ofb/R432Cq4lBLadFHVtIEJ0CoGBfJsKa8SHWzdmyVtRvH6nnKk+t776u
	 8uihOWLpj0/9NU7CGhMD06gcP8uYT28fdkFz6U0Qdoz/Ba/FOny3ripzXvbzQx3LyUWlQ
	 mykEwDEBVnshiPl9kSownndTcU5iYMF9/fRVzdEviJLhLn9qFuXnb+PP7ZptJcojmpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794725129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=0/3xq8hIlkDZKn/4BFbonv8yuwP3/TV4s/w1lmYLKlE=;
	b=ONI2rcpAIMp1WLh+2Xgs/da/Zb60FRmOHOF4Dcr5C4FlOdS6arztomHU15RKEjPnkvWi
	 cq2UpAQAOoXUyO7FtCyTzB41t96C+WGiVxZxYjRPyJnI02bynX6mmXGze5jpRgjy9aZV9
	 IxZHW3rZOdNGxgXvhVh++gZLTvIqMnmKc5vYzjx2VKLnDl9de8Pd44grwZb3kYDy2XM+3
	 ZdMZe+ntb8A5xGdoNhKJeCt9cT4uvcD/Fj8tWDAlAHM5Tf0rC/yYB8BxHYmYaDqD3nXLf
	 TCNkaYMrFZwtXNTYphZjp05vbmf2tH0FqjRQjcccCPRqJ2PFMi2surYSsVUgPkFKERA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BpwQH41B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F3606A32F
	for <linux-omap@vger.kernel.org>; Sun, 15 Nov 2026 06:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E63F3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BpwQH41B
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53644ab1f7bso27021291cf.3
        for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2026 22:45:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794725128; cv=none;
        d=google.com; s=arc-20260327;
        b=P17kpOlWM3K/5oNHTksRK0cwcCESP4B1oaT4yql6ioya0zfd4tSnkcgQm43RmCpGSG
         3L7LSlUraY3JG0/ZZvEm/aU/22bpMFXkC/UcTshOtg1BwgGw+4A9W55SOSxOhsQLN69u
         y/CPFTeqS2Mx4cZrwaCIblmontG3Xg75HYwQr4dHD8gRVmvbIPVDgYlw6FAuQBHaWF72
         QYSktnRWkBY3ktSZgUhoTXGvdDZnFNJwKtlJZs0LTehHB6IXOjpsh3V2VTqW3UFg3gCk
         Na7K6dXbQcPdbrPOSE5QvN0hprmmxI9ccn50H9f5CsnXDZ9imXIj6tGOPNalWLPuSx3o
         lXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0/3xq8hIlkDZKn/4BFbonv8yuwP3/TV4s/w1lmYLKlE=;
        fh=Sri1dxalKcFAeuEuDQf83LY8vDYqVP2CZQy5AJUmL/k=;
        b=CH46kPgbgTadJeihCzp3PZ9RExw6vOYRaWNPhrAHD3FAUBSdFAtA8YZkElEu7qVUny
         4K58QIkWcEv4+RcppsfkFZadnij/RMyKFlDfLgPe4nANZuLeISo77Mk9gxTFISh71EqE
         ahE/Q7iSakEdrLN5gTo6VzFCPYQa74TG0TK9WYp/DsNaQ6Y7h2mtt9FuhaFbODvXeB6s
         vj1zJKHArMTG2dRalch0QSlxDJe5+lGKChpIetG5XQViMMrQ1US7g6lq8ykcOWRknoMu
         7XkqXHSYduFj3CU+/HVBmNwsYNN/oWft3NvQTtlhc5L4uROWvvIxs4jvzJZv9r9PEsrt
         N36Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794725128; x=1795329928; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/3xq8hIlkDZKn/4BFbonv8yuwP3/TV4s/w1lmYLKlE=;
        b=BpwQH41BDH+rLTxQ4tc49OHpD9jtyrWfvS1Q/B4sGyBzKtnNjWjgaN9us2ROVra5Yi
         3EK+UWi+hCkYqvV59U8ZMjXVJU77NRjYrN5mBg5CPoFNLeOHpStMDVXSZtLa2SXDXxwz
         UzKj4ZdIj9ewAK+bUoV4XSUe4Xm5WWSgiM07gyozlFoQWbmWa6GUdLTuXoTLwSLceoLP
         plaBRT/1pWDidl7yagvZRRYEuaV5hj1HdNZ+y8NFgQMYcXXvE+ca1bnkWG5d5pP/3Oco
         R6LFCVHxuiflf2SfMsWiBMgrFsoRA2afIahCe7VAxCUJGynp1DmCksec5Tc/YE4BmBP/
         8aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794725128; x=1795329928;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0/3xq8hIlkDZKn/4BFbonv8yuwP3/TV4s/w1lmYLKlE=;
        b=aEOGUlF1Z9C/aA1FBZbr9dCQih8WTh56fAB0yEB0wOMTqgftUr5dK/B8ohnbSYLyEG
         BMK4TNss8HRqqmkiT42Ornd68D8RzHtmRkrgIP4kKKIdjj/RfsQJF9nDgiab3BD3CTe2
         FD9pAJVFI54x90UuF3et/WJDo7cuTA7ksAIIkmY+nem6fkmhN/RimLxCib1CcaS4Sx/+
         4LgtAPvrz6zUMFWtcSwwn0Xtz+GH7DwNyIx1Vp3Z58gEQFcUTvbTHyb2y36kTuXtBZ5m
         un7os1CBB2EkmG8PH36ye7QIsqFh2QbhWLInIzj+kZbq9Zo8wOSydUv/8C8EtnzizxTh
         W1aQ==
X-Gm-Message-State: APuU4Z9oMWGjGNlENslXVOnzoXFtPKAk3YB0Im9IwDHX2Qisxq/4JHLl
	vGs/uXCb3CWOTDyXqwgOl62ofve5L/d0AfkkqZcYuWMQ3urpk5WrunNUvOrWUpnLP/NaksOPMSB
	eG6zdzguphjBGEEnv5wvdZPL+8QbJmCY=
X-Gm-Gg: AYBFou0w/BFIEJyAdMpBKEaPJzBIgyOKe+U0OEUDDCdKNFUwc675U/mh40dJWOpzbml
	LKsJXtDIr6R2tdZOH4cR6gUUQYgZgqKL8R/Ynh8E49LuyjRGg53aCfCajCc/tjovNvWz1DP57Rr
	QoevBWb/u4uu/VetJncZz7+P+gPYr+Wrm1RyPUx3rdoFvridnVN2BwW6Ftz02TPWOIBZ9NUFjrq
	jv1Y+vdUwY2646xtZ5niOlrJLszhiHBE+aPQGPcyEdh4i31/2ijE+Caj19iiun4TBWwFf/PRlyo
	zYuOCxTk+ABn5wRpFRJuXS66H2AD5OsJdEbjd3nJpuZejOHD2KBNhB0ud6K/RWRyq/yd8oME6HF
	siLMRvEf+P4/8eHTskB9ZxEpBTg60yTo19GxZYbfkJCZu6gcNKWuHse6i4rBKQcyk6x2u
X-Received: by 2002:ac8:5ac2:0:b0:536:2fd8:a4d8 with SMTP id
 d75a77b69052e-55ac667dfbamr119243201cf.15.1794725127927; Sat, 14 Nov 2026
 22:45:27 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Alex Guo <alexguo1023@gmail.com>
Date: Sun, 15 Nov 2026 14:45:16 +0800
X-Gm-Features: AclHuK_kcIbKAU4I18MjmNReJSn41ne32WepJS2MRE7kyM3HewwZkuZHAF6Bz20
Message-ID: <CAAi4Z-e6cZ6wxFTO1rk7JmN-zdTo6=boWUwPeAOKSjuVQ6NbHQ@mail.gmail.com>
Subject: [PATCH] bus: omap_l3_smx: Check IRQ lookup results
To: aaro.koskinen@iki.fi, andreas@kemnade.info, khilman@baylibre.com, 
	rogerq@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

omap3_l3_probe() passes both platform_get_irq() results to request_irq()
without checking them. A failed lookup can be reported as -EINVAL,
losing the original error and preventing a retry if the lookup returned
-EPROBE_DEFER.

Check each result before requesting the interrupt. Use the existing
cleanup paths so a failed application IRQ lookup also releases the debug
IRQ.

A similar issue was fixed in commit 47c3e06ed95a
("spi: tegra210-quad: Fix missing IRQ check in tegra_qspi_probe").

Fixes: e2fa61d40919 ("OMAP3: l3: Introduce l3-interconnect error
handling driver")
Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
Build-tested the affected driver object with Clang 18 for arm.
No hardware test was performed.

 drivers/bus/omap_l3_smx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index ee260c1fc087..7245be425f13 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -235,6 +235,11 @@ static int omap3_l3_probe(struct platform_device *pdev)
        }

        l3->debug_irq = platform_get_irq(pdev, 0);
+       if (l3->debug_irq < 0) {
+               ret = l3->debug_irq;
+               goto err1;
+       }
+
        ret = request_irq(l3->debug_irq, omap3_l3_app_irq, IRQF_TRIGGER_RISING,
                          "l3-debug-irq", l3);
        if (ret) {
@@ -243,6 +248,11 @@ static int omap3_l3_probe(struct platform_device *pdev)
        }

        l3->app_irq = platform_get_irq(pdev, 1);
+       if (l3->app_irq < 0) {
+               ret = l3->app_irq;
+               goto err2;
+       }
+
        ret = request_irq(l3->app_irq, omap3_l3_app_irq, IRQF_TRIGGER_RISING,
                          "l3-app-irq", l3);
        if (ret) {
--
2.43.0
