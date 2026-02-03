Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DDC2F39B1
	for <linux-omap@vger.kernel.org>; Tue,  3 Feb 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085146; cv=none; b=pZC8I4QSF93z9t5RYITseh/Ex2io60qmZI7vL3ZAgASwfV3O6EL/Q9S11MLq+R/jmrzg6vWSXLUYIzs9OjyFfDFiTALF08IV26kjj+5ooJAWKtCZKI99UU0O5Hg0Koa6IhBEo8ljiN0km8fPLama6OsTT6oIWmpMUNCxrR4uW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085146; c=relaxed/simple;
	bh=A9J9Vbw3cZWxxdrLeN0e2dFSVHQM1IePSv58Izf3rdY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jVVSJq4bi2gH3tcMKaUahHmQR+Oy7z40EPR1VJRsEwnv7vf8wMEPP/58m0cYHG8Ck0ehygkO9pXLZpfiz3TbkZqFfEls40M60CAAHMrcdoCCIYmyuEynYPRsAm0r+uvkjkSPe02bu5ulIe9riuLB/UcpGW53waz2N0mI4Fk+tQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAtVnUHe; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAtVnUHe"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c6d76b9145so548074085a.2
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2026 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085143; x=1770689943; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vRFnWyzTvIVC5B3GNzk5VoRZ+dqVfddbc1ZSFOhpp0=;
        b=TAtVnUHeAuJVwei9ER/yWl66HCzMRfupuvKyWEkU2vnP+ifJ7KnQFFsBVcfJqCQWA3
         WcQJfn0mBq0wNhRjr1FA3EclDsSrTNn7u+jyziADkbHsYWHNclHhNpn8qair6U0mEEY8
         RHZsWORjrehGV11jMlFXmQ0QYd7AoJWAM/0nUCy4wslpzRman3iRiOCsRjr6M7YLQ0W1
         X9v1FS5+4q/Me+GOb6Hxh0kgJGTk6dehfjFjpBcTN4y0DltTCxpFtsZKgKHcB/yO5iF/
         u0p5pALfO2S4CAGmtmJfXbzlMhuBisG7Lw6STSzVRFrr8BSpkOvNwrHhaijW80PWdREp
         6+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085143; x=1770689943;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vRFnWyzTvIVC5B3GNzk5VoRZ+dqVfddbc1ZSFOhpp0=;
        b=bWX91t9PJkY/ZvaaYI+p9HC3UOvtgROpYEZSuaYpViTu29rdxJM9aPB6uMs3G05isX
         /kQ38fvpia4TVtL8ydFyuKAeMzuwIIuNMuKZCCrQ9tRHTUTVb2g4fvIY86lnQT18hEZR
         m30ZF0euESOLynWza4HKJsG0bBHBU2KNbCCuYiU6ly7AZAO0kY3t9HUIPQc+MYfTEex+
         LidSymY/Re5P2BaOS/R/U333TQhKolhuScpZajULzVPsG8pGv9TJ8dAbrCB6Tr6Nlr+R
         jJUJHjHmcsyNrTxWRFpiv/GoM0EIiXpJEpJI2g3YGRKjKAbyVAIhGFtV2HgJwbmK3Mh+
         D2/w==
X-Forwarded-Encrypted: i=1; AJvYcCXlCjyNqOhtCxM+roQBr7WXmkH0Hmi9jI/cyEE9BX3+YZPK1TiUe9FPaSfZPhFE5oGM9iH8w2grNqDV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2n8jGebjyNa0NTYscgItVfw0T1pqDiF14ES3Np+r4WridRP4H
	XL2lv7becv2UQbXC0p/WGkFw6Tez9ZsW1NmZ/Y/S2hFn06+akqU8bi3F
X-Gm-Gg: AZuq6aIDcYC8JJjXoG4e6oH41NAZedJ/JVEKbZkh6/1zawOslz/g1R74NjQWsgtcGcb
	auX+iWM85TSp2Hah8xjN8AnkjNCrXO6vpF/fJzY5l2do6pK5QowA9UU1gSV8s/Yh2BAY0D4D4mY
	WR+tT8fFn0HEoDci6/GIAZvngdN1IKXJmCjr7cEB0wWJdst4WfHwHDIz91A9NT4ctuy5fBDCooy
	NSOCdySAmff8AQdlb0rAAO3n2/f0Nc9ZsfbDTPRgDcLA6dMVwbQO304vmNnxQCw3M50IzNi/ew0
	AgTKuWAqBF5S2MtoAy1ROO8/InzQtOjFF4HDlJIHsJuCmwgycPaQAKffDoo813hFek7dXWS++PZ
	R/mUWCAwhZTJj87EU4ZP0YYKujOlxJOsrXfE314gYLlAQRcGaxxKDc8/i5ImFF006HJTMZxdFTG
	dojulbk8Y6686ig7bYdCvY
X-Received: by 2002:a05:620a:472b:b0:8b2:db27:425e with SMTP id af79cd13be357-8c9eb309af1mr1776216485a.50.1770085143102;
        Mon, 02 Feb 2026 18:19:03 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d5c34asm1337199885a.50.2026.02.02.18.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 18:19:02 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net v5 0/2] net: cpsw: Execute ndo_set_rx_mode callback in
 a work queue
Date: Tue, 03 Feb 2026 10:18:29 +0800
Message-Id: <20260203-bbb-v5-0-ea0ea217a85c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVagWkC/13MTQ6CMBAF4KuQrq2ZdloqrryHcdFfaCJgCiEaw
 t2tsEEyqzcz35vJ4FP0A7kWM0l+ikPsuxzkqSC20V3taXQ5Ew68BMaRGmOos1gqGUrFHJD8+Uo
 +xPfaciedH8kjL5s4jH36rM0TW09/JROjeVRpwCh2QeFudavj82z7dvUT3xu5Gf4zUqgQtLGVw
 6PBvVGbwWykVyygAMt8dTRiZxA2I7LhxgGAZtKi2JtlWb5HelIaNwEAAA==
X-Change-ID: 20260123-bbb-dc3675f671d0
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
X-Mailer: b4 0.14.2

These two patches resolve an RTNL assertion call trace issue in both the legacy
and new cpsw drivers.

Thanks,
Kevin

---
Changes in v5:
- Apply the same fix to the legacy cpsw driver as well.

- Use goto label in cpsw_ndo_set_rx_mode_work() for the undo path as
  suggested by Jakub.

- Move the disable_work_sync() call to after unregister_netdev() as
  suggested by Jakub.

- Link to v4: https://lore.kernel.org/r/20260130-bbb-v4-1-2bd000a15c34@gmail.com

Changes in v4:
- Using schedule_work() instead of creating a dedicated workqueue.

- Link to v3: https://lore.kernel.org/r/20260127-bbb-v3-1-5e71f340c1e9@gmail.com

Changes in v3:
- Resolve the deadlock issue identified in the AI review [2]
  by moving the netif_running() check under the RTNL lock and removing the
  cancel_work_sync() call in cpsw_ndo_stop().

- Link to v2: https://lore.kernel.org/r/20260125-bbb-v2-1-1547ffabc9d3@gmail.com

Changes in v2:
- Addresses the issue identified in the AI review [1]:
  - Adds a netif_running() check in cpsw_ndo_set_rx_mode_work()
  - Cancels the rx_mode_work in cpsw_ndo_stop()

- Link to v1: https://lore.kernel.org/r/20260123-bbb-v1-1-176b0b71834d@gmail.com

[1] https://netdev-ai.bots.linux.dev/ai-review.html?id=bd885e1e-1aed-4755-ad60-7150737ad0f5
[2] https://netdev-ai.bots.linux.dev/ai-review.html?id=c9fc3cf8-a06c-4cb8-b26b-910e775951a0

---
Kevin Hao (2):
      net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
      net: cpsw: Execute ndo_set_rx_mode callback in a work queue

 drivers/net/ethernet/ti/cpsw.c      | 41 +++++++++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_new.c  | 34 +++++++++++++++++++++++++-----
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 3 files changed, 65 insertions(+), 11 deletions(-)
---
base-commit: 193579fe01389bc21aff0051d13f24e8ea95b47d
change-id: 20260123-bbb-dc3675f671d0

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>

