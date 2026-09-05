Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD1B3DAAB7
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591849; cv=none; b=jMuEpQBc5hQZaFI0unobgNLl98E2c5mWrGj+CandNSHRMZhtnrxc0Wp7SlLcvHsJNxq5zfTB+e9eED6uiAo1/uL+wmfS/l46nifvCW6nKgrXXPuDDalVCIoT3HnXFRMtLJ9J1/o1hMbOHqlpJmMkNklzf9cQiOo+XIEQGpJtMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591849; c=relaxed/simple;
	bh=zqIZgn7Zgj5WSQepFgJtQ9GMMyKpvR8InLxOiqTa/8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8NUzdIivZxE71iQF0LDoDFxdT/DA1V4IEVCq9pQ0fXk88uY0P8wqzwgi8Z7PT3//ZY7cDzVVi23B/szDHTF2DWJoedJZ8Funv4m9Usb8IPCDqt7UDvxMFUT5/aupkO6Ra++gw0oYpCqsdvyhNEBuApxaTL8Mj8UwWns5WzCxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsSYwLwK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsSYwLwK"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso2672341a12.0
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591841; x=1789196641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=XsSYwLwKu7HA+M9qQDLAv4qyhXqLO3Y3B2nrMauWYL5U/x9gMoPFVblanGk8nChIvd
         le6ND8o0ZGm4oLALDhgc8N7ll0NDm2ZuPPkg3BJ06DJiogDlzQZ7zgsVhbbx8LbTWTMz
         mJUu/Jy2EurM5VuMdsk3Uh3EF78ZdYkgcASPo4/iFhmVEz3GAbWH7dHmqsvIEDnJUq5t
         lb/gNVUNWETamXJAzcASXkot7DuMJvhXDEsA1GTzHxHbB2VyBuB5mB8CDW0siMQqovX/
         k/fP1XF6rKWc+9P18y9oJQoOw4mcO+2An2bQ56vnNdwBBSq7VrcBgCOkAHtz/ZsR5Mq9
         3s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591841; x=1789196641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=F2QwQP+vdqKgsxIeYWRx6fg7SOrQhSeQ3yIkc2uI18Ub1JhBdas0X6L9Y3ilhDQn97
         ty3XTFLHXaDsZFnWP0sKv1HRAiVa+myELXhRHMTdyotOSuo9e8KrHLtSRRzt4MTr2Vsa
         Km6lLXSL0G6CZtDlOksUeGFz7fCw05JmgPKfsekhwRS/UyLxFXOPhdTzQ0FxdXznt56D
         Dm+1wdiUmrJrYGis2wu0GMbbu8buzhx95bffjsPH5eNB6XbHQpZdwv145tlmaimZevN3
         X4cl/b2DUhUSWgwU3nlpm1kBFUgRxrxbQz+HrKg7WTYA0phEWMkVPWamvVOJDw94CyEY
         3aEw==
X-Forwarded-Encrypted: i=1; AKwUvBzUfKlURA0bSTh9KfITxX6F+r4hpDwhGawiK8o3k8kcVxZIkX75PVfy1Cz7FCBrHRBX815hm/kfqPmT@vger.kernel.org
X-Gm-Message-State: AFuF++kzk4UEZY3J+tXSXPVz4lVh1VXW3lRXmL6TjHGM8JUur+xRjTa8
	3VO9Tli0xAg7ouW4N10bboeqCnpyHh69merE0bpVbzLRjuAepX3WoDJ1
X-Gm-Gg: AYBFou02zEpL1gloybOZM+3lxw82WSv+4JYo860dul1hBYXGm5WWIERkA+lbUyT9iWs
	zqz7Dth+ZwT6KcM9SUJTqsEOpveuJlcb08sOIYQqMJMhA/+DadWV/u9J/eB8ZVaBBOTF1w4+SQe
	vg/TDfWZ0YHlRotxrUQbHSda9fY3vfx4INo2gAOLbfu0zUaNutgmXmKMcEv1B0+ZDxb+3s2o8Ft
	gIBZaJatslWsbhD6uEDealo43HqyHpfkbNn6jwMiqSLSJ/y4esBu9Yiaa9aKM2Zm/i8drQAbnDH
	sj6aOab2JuS72TRfe9BLGLG4F+/f7vdP3FcuiZdhIyOpwGUg6QX1Vtb8OMvSPsgzStZK4iEI5PT
	QGmsRLq2bGq/8Y/U/oZvcDQFrx+/7TyyUkuQVxzqz4D0FsingTmJcOqs5gXX+AUe2lpCCZaVHim
	MHtE27bXU4Rx9wR1HikKn9keZBVR8vv8tMMwfk6jkE7ie97nIk89pWt3Lap1v/+Z0ziBvX4GA5a
	8YIfcB2pCPlQHqy9b0EJ7YlMhbbUc7hKqGrSuUP6Z5N7zaQVsv8eeqGU8i+e4bia53opTT7TmTn
	LE5RwFJp5wcbB5Yst0xz+SCwjAQTtaYLLJWeM4cRsy5jRShK6NeG9hoIwVJ0rcbOOoWPvdtf
X-Received: by 2002:a17:907:1c9f:b0:c26:1691:b374 with SMTP id a640c23a62f3a-c261691ba04mr359894966b.45.1788591840842;
        Sat, 05 Sep 2026 00:04:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH 3/9] docs: kernel-parameters: Drop the edac_report= entry
Date: Sat,  5 Sep 2026 09:03:41 +0200
Message-Id: <20260905070347.25902-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905070347.25902-1-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

edac_report= went away with commit fee27d7d9788 ("EDAC: Delete
edac_stub.c"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: fee27d7d9788 ("EDAC: Delete edac_stub.c")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 99d5bb68968a..2a8d862ef30f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1578,14 +1578,6 @@ Kernel parameters
 			PCI device even when its classcode is not of the
 			UART class.
 
-	edac_report=	[HW,EDAC] Control how to report EDAC event
-			Format: {"on" | "off" | "force"}
-			on: enable EDAC to report H/W event. May be overridden
-			by other higher priority error reporting module.
-			off: disable H/W event reporting through EDAC.
-			force: enforce the use of EDAC to report H/W event.
-			default: on.
-
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
-- 
2.53.0

