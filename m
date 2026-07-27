Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037523BF68D
	for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2026 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136241; cv=none; b=E/72kfLPOkGOVfOC7oq8cdbltZt7dH4rmDxjgPwAJIFkeGsPv4IeYO0lOrjo9WB9Hxmsf+VnV+65YGrbNKAaRi2dDm7M95v0eK0GsL8cN2B6rs2lw/ZI/aebFCNiUgPvuDBpxXUnwO6Yotl/2Bh35P85zSzwaVFCT7tlS6bZqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136241; c=relaxed/simple;
	bh=0ajQB+hPab2vIWSNK6YjKmU3k2ZE+ruh1odyGqqOzg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USFYVRBTeeXB/uBGZ6OEm1Tb+LwM6MO0d8d+jr9+6CNt8+YOx35WEoKhijpKVOiB08PMZof2XA8g54NIprJeRZ78hcZ4sY7Bl0Q1F5OC9zKV5bmI02w79sOgxeiulNva3pr5lDgJZDKPJ10zbEN1BheQXsbQvzPc9UexdpYlt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0HC5nN0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0HC5nN0"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e533aacf2so122666885a.2
        for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2026 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136239; x=1785741039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1OaiGLLoxTsUad13rL5qrpAU9a1lh1UZkttvZnhnlXg=;
        b=H0HC5nN0Cb//8P5+s9yAaKM5b+hx6wttQWPo4zFfT0WZfS6Eh3CtPI2oOoZwsSjidm
         KvDNUcUqTihE7Sdwk6RwykZvdSMqAuzSXZo21T4kGJPlG3WjZ4m2A7BahwleIwbxkCbc
         C6xq+VjBXYDSgB5j3Rhz3PvMYOmWmheFFAuZuMT72jSOhcWwxyBD6s65xMzRcrJC0GGt
         UggHh4Qc/0fFkCkxFDNM8zcgaR7mCHtH8IMKY0ur/GUxwAWa5fICCUpugAky5R04Y7BR
         LANNKJ1Wuti/O/u41RuapEQeNiu4AP3KuhiQ2d6D2KBWS/+Bemgt5o/bfjqQqLwQRVB3
         S0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136239; x=1785741039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1OaiGLLoxTsUad13rL5qrpAU9a1lh1UZkttvZnhnlXg=;
        b=lxr3GzqFIARLZt7htEQVivDAdBSlETKx3yFMUCFPhGyo8m9KB1j8gs5oijMJJ+Hbqq
         41awrbqnwG7/h0Fp6xNrKa6i2h2MQ1Wa+LSvOINy3HClh/XtNqis5U2r0q/FkneTZgcr
         Ugot6mEXatxN9cXZGIJSCfF8TNlb8jBtEWRuMTJvQwXqRMOC0lpikcpbmsMqGWuQ5oPy
         J6Diy5GRcjVHTRIcjX01Skj6SIQKXuXBaKTOgI2TIekwD7jcJ7zr0oHAA0jivNmKjIB+
         JSu+en8ElVRU3GD7/3r7/iT6WxUtJA9p/vc3+use+E6KbZHEELlh31juuBP6iiK9R8HW
         Jjcg==
X-Forwarded-Encrypted: i=1; AHgh+RqWyYVGfOlNk+796fE9xDLzO/fTJm6JGq78JwsxwTcP08H17UEPPhknA3lBc/h4L7RZwGLpBr0Io+VE@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhMwyCJ4ONZ3JXypXy1AxZaTty6Vja/q6Mkg5Br8Pp4ZgiIRv
	t3TjQio8Fvb8PGH6Q8In+27t5UhTc7UcaLyq3fk9dFDJ/WMka46/HXu3
X-Gm-Gg: AR+sD13BlrOXmpbuh+YgxSgyFANQ5xclVdXc2vbO0mUSI9mU7q3W447p23Moc0jcOXo
	UgYMMj/6VkxEP67sNWkCro18WhX7t9q1Rsr3X8YygCGitGc1ExkB5IFY8KehDo69gA4hC52DvSu
	QljK4sCcj7l9kYuvJMgQIimuWBeM+Z1ymBWbnYNV44kHP6UcMXtFyFSIpyd9kn4CwiiJNS7NeUT
	YjpAoWNLGbSoqj1KP5MrULmQRtX3Ou2j4/kkBKE2gVrtUtyjUsR7lFAQnFCKZT7EyDvYlkSj8AV
	bDTR0FTtPJHzvbbXdIcUZBUd+7t/NRogZTQMpcEhqf6TjvFBG3uS/rL06HdcgfsWYoNPnHryne1
	goqVZX5HOc1EgYBRFL1WgwohiJR70lp7H6CSUe0ZIycMqfuoi97WtXG6rIINz99MtL/xJDok955
	Hbkqh9YqqJjuNddQ==
X-Received: by 2002:a05:620a:26a5:b0:92d:a06c:de5a with SMTP id af79cd13be357-932df6e9ecamr702151285a.45.1785136238883;
        Mon, 27 Jul 2026 00:10:38 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de569a84sm557850885a.21.2026.07.27.00.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:10:38 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit
Date: Mon, 27 Jul 2026 15:10:29 +0800
Message-ID: <20260727071029.1355476-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_hsmmc_prepare_data() converts the command busy timeout to nanoseconds
with:

	timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;

busy_timeout is an unsigned int (milliseconds) and timeout is a u64, but
NSEC_PER_MSEC is 1000000L.  On 32-bit builds the multiplication is
performed in 32-bit arithmetic and wraps for busy_timeout values above
~4294 ms, before the result is assigned to the u64.

The driver does not set mmc->max_busy_timeout, so the core does not cap the
busy timeout, and commands such as erase or SANITIZE (MMC_SANITIZE_TIMEOUT_MS
is 240000 ms) can pass a busy_timeout far larger than 4294 ms.  The wrapped,
much smaller ns value is then programmed via set_data_timeout(), so the data
timeout is set too short and the operation can time out prematurely.

Cast busy_timeout to u64 before the multiplication so the conversion is done
in 64-bit arithmetic.

Fixes: 8cc9a3e73de1 ("mmc: host: omap_hsmmc: use generic_cmd6_time to program timeout value for CMD6")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58c881f2725b..3356ac5a1fa0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1357,7 +1357,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 	if (req->data == NULL) {
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
 		if (req->cmd->flags & MMC_RSP_BUSY) {
-			timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;
+			timeout = (u64)req->cmd->busy_timeout * NSEC_PER_MSEC;
 
 			/*
 			 * Set an arbitrary 100ms data timeout for commands with
-- 
2.43.0

