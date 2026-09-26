Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CBE40DB43
	for <linux-omap@vger.kernel.org>; Sat, 26 Sep 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790426982; cv=none; b=ZiR+UmVjq5Nbvep4wFHL2n6XCzY0m4nt0/NW0l0jOJBQo+rZSJTWiaClRsgxVp5FpMdUh9CY/WflrCmgTYcUVTDVkKYgN84mCRpwHolykN8zyMJfwNp6SLofiq5izg//v9et8kJrod8zToxR/f89vQIDY4hswGl+OKeLsBPA/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790426982; c=relaxed/simple;
	bh=gKRD4NFUCHQezmtngowHc+jDAfxx84H1l2e/vlIJeyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBzDJgEfpn1XLdRdbJYufeXzAtAmBgm1b0bhnqdBaP8kfUFX6o3163NDHkHV1l6Ddk+aLUgBkPjzpNl9ZZHYn4AnbmWdrlAG0bxvoZm6ejJs+1n5CnrpbtQIfM33VDoTHRtg1dLdmx+cXTynf6O68fNmgCXaV+ZobwdegS3yY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrDcMejl; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrDcMejl"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc433d52421so626090a12.3
        for <linux-omap@vger.kernel.org>; Sat, 26 Sep 2026 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790426978; x=1791031778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ROHNiM6rfL1rKoboMKSIKGA/8OXG5JLeTtjVlvBfcA=;
        b=GrDcMejl8UC2yj18XtdZhPpnChsKsykL0wJGWR2+HY7mMcKCW+eCwfZb7mmrs6jOvP
         DC3rUCPfmQUe+pJThvyyGOoxUhgREvxpwUZY9UdUfkw0nbf6rjd7+enbM/z5RJcQfxFD
         xRLUK4BV4lDMPQWCtw5P8L1bIzeapuk+okCmvyFkgWqU5G3LV0MZmpptSr+KrZGvRhqf
         VtMr3zAfR9sTZwpRS0qfCqUYK4/3DDjpcJFx2L+C5e8iQAgjaUCzipyXxxeVrrE80oIg
         ZMFpCGAj9CMAZs1uAOA9z5C3B+ch3q6pnzAqAMqjeetd0sP6JUctNhqs6UVXCX/lSjjL
         XiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790426978; x=1791031778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ROHNiM6rfL1rKoboMKSIKGA/8OXG5JLeTtjVlvBfcA=;
        b=0MAU9lJ7/SOU8jzsOh6L2+5l2mOMmHafyNiARilxSh/IzjWMSAh+rwG5YylFJ2zh+f
         OvRnDV5pQiAN4kusQckaYxUH7fUF2ThjrJKhWPduAH+1p3ZTjMFd+SkEKiq6GzbnhI+W
         T57U5y1/2BA6F1RtidaAjeAQ9qNr6dBQGAFnw4XUsONeg0r4kBJpqI1G+hFHy/zVraYZ
         h9bz+N4bhClc22yXJ6BcoM3jCrMPZr6ryzSoOsaY00YJNTEfyPC4x4jffqrjbyXriKbz
         bF+5PSB/IQrI1FfBENuk7xK7WoxKRZ60meupN9XkU3UnWD0QAowpNCwx6RFxYqsm6kNm
         Gizw==
X-Forwarded-Encrypted: i=1; AKwUvBzQFH35tOcbgTtVuWz/g98IXuLAPiWq/L1ZDINuOJQeb2z6gB78ZlLiZ5znlOhylBtqkDU4pbN4cE1D@vger.kernel.org
X-Gm-Message-State: AFq9FYI6LwK00k4n3JO0dr9dbFZrc6C/JPrsb8LpVPkdbNXZF8S9N1Re
	eZeFKGUsBnMHpJAVMM8JRK6KyQgiEU2MJ5zOWBgGTu0K97n3CQZE6W/T
X-Gm-Gg: AYBFou0X3wID2pgpJFcUakcjEu0PchnDHoV547Y5wmkp6FHLlZ8/VzMk0PGIiv8WfYc
	rWooSz0tu9BF316/C1Y4259Zln/udxsKg3floPRzUUgG85+nJYP3cOXB5IeNRQ4Nl1qDmIaOzBQ
	q8CoUOd7aMoRreTfQm/J0YTPmXWuntwfhFvXoAE0USpqNiqENvti9MrO5tKV2WACtTR08wkXwAn
	tGZtVAXf5exTDtWeBQIrBV3gFYqBcvp59LZA3apJpE9ww7WWCW4oYr+Rdxs067tbbDZPIytYyUO
	UXa+3XeZzQaH8Zkrk81qMUSWhvU/eB5zSRc6KTQUvwTfZGUZs7nIkO/y2CaTtXZbNBoLVjcMbtK
	rUxfYcztDIIZiEk2+bYd6EK+jELrvcclxSl8f2dlp6NaHHs1ogYNslGFKArPVjy0cEVnfAQMfVs
	Yk8cL6UpJR8kz4za4GefyVuytMSBXODxe0DfK3/kV5fiqBsKlDJaKvJCmf+h/nE779dvnfD25u1
	GibNxMMRGOKKun67oH1oBVhjfk3wi1mYN6T+0EB3TWY4frrOuKxRKkB6BeTTElGcZ973sy+PhpW
	JisUa5u/boq/1iwMmOv1qwzVP5hLl7LgRX5nKA==
X-Received: by 2002:a17:90b:2247:b0:3a0:ca03:3e1f with SMTP id 98e67ed59e1d1-3a0ca03447amr2399868a91.32.1790426978417;
        Sat, 26 Sep 2026 05:49:38 -0700 (PDT)
Received: from dell-pro-max-tower-t2.cse.unsw.EDU.AU (pag-t2-pc.cse.unsw.EDU.AU. [129.94.173.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78794331fsm2450885a12.20.2026.09.26.05.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 05:49:37 -0700 (PDT)
From: Weigang He <geoffreyhe2@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>
Subject: [PATCH] thermal/drivers/ti-soc-thermal: Cancel pending alert work on remove
Date: Sat, 26 Sep 2026 22:49:31 +1000
Message-ID: <20260926124931.3599746-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a threshold crossing, the talert IRQ handler calls
ti_thermal_report_sensor_temperature(), which queues the work embedded
in the sensor's ti_thermal_data on the system workqueue. Nothing ever
cancels or flushes that work.

ti_bandgap_remove() frees the talert IRQ last. free_irq() waits for a
running handler, but not for the work the handler has queued. When
remove returns, devres unregisters and frees the thermal zones and then
frees the devm-allocated ti_thermal_data, so a work item that is still
pending runs ti_thermal_work() on freed memory:

	ti_thermal_work()
	  data = container_of(work, struct ti_thermal_data, thermal_wq);
	  thermal_zone_device_update(data->ti_thermal, ...);

Free the talert IRQ before removing the sensors, so that no new work
can be queued, and cancel the work in ti_thermal_remove_sensor().

This needs an OMAP4460/4470 or OMAP5 SoC (DRA7 has TALERT but no
->report_temperature, so it never queues the work), a threshold crossing
just before the driver is unbound or unloaded, and the work still
pending when devres frees the data.

Found by static analysis tool CodeQL.

Fixes: 445eaf871bf9 ("staging: omap-thermal: common code to expose driver to thermal framework")
Assisted-by: LLM codeql
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---

Notes:
    Compile-tested only (ARCH=arm64 and ARCH=x86_64 allmodconfig, and
    ARCH=arm multi_v7_defconfig, W=1). Not tested on hardware: I have no
    OMAP4460/4470 or OMAP5 board, and there is no reproducer. Unbinding or
    unloading the driver needs root, so this is sent as a regular bug; no
    stable Cc, but please add one if you think it is warranted.
    
    Found while reviewing a CodeQL report for this driver.

 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 7 ++++---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ba43399d0b384..507fe67eaffae 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1077,6 +1077,10 @@ void ti_bandgap_remove(struct platform_device *pdev)
 	if (!soc_device_match(soc_no_cpu_notifier))
 		cpu_pm_unregister_notifier(&bgp->nb);
 
+	/* Stop the alerts first: they queue work on the sensors' data */
+	if (TI_BANDGAP_HAS(bgp, TALERT))
+		free_irq(bgp->irq, bgp);
+
 	/* Remove sensor interfaces */
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
 		if (bgp->conf->sensors[i].unregister_cooling)
@@ -1093,9 +1097,6 @@ void ti_bandgap_remove(struct platform_device *pdev)
 	clk_put(bgp->fclock);
 	clk_put(bgp->div_clk);
 
-	if (TI_BANDGAP_HAS(bgp, TALERT))
-		free_irq(bgp->irq, bgp);
-
 	if (TI_BANDGAP_HAS(bgp, TSHUT))
 		free_irq(gpiod_to_irq(bgp->tshut_gpiod), NULL);
 }
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 6e1bbdee53637..3073d4d9e4f36 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -195,6 +195,10 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
+	/* Work queued by the talert IRQ must not outlive the data */
+	if (!IS_ERR_OR_NULL(data))
+		cancel_work_sync(&data->thermal_wq);
+
 	if (!IS_ERR_OR_NULL(data) && data->ti_thermal) {
 		if (data->our_zone)
 			thermal_zone_device_unregister(data->ti_thermal);

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.43.0

