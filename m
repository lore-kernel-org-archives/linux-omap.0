Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795239050;
	b=BvKZ352nq9hymdULhL76uXoQR35cKhH78aBaormUs0VT/YB9fmoVQae5RwUZCGkqjnSG
	 ZthXh3DcE7SGgN9Z+929P5Rh4LtE0UhDz+BrwSYWWsXD4A7W89L+AjSMlMNvYXgh9VzK/
	 T+2QMDOx4X1Shr19zDfV+DAWyVBidQnazfeRTuoSBHAWYZeBjEYm1+Sgx+j1g0pU5iTga
	 tzrdn7oIFgRUF5RNA1KjIJZdDVID8PItNwfvCjNLREvE+8mic/LP1jSnlzqjol9rKZYJT
	 ZLuJ2P5r13o0cUPnCs3qignAASqTV7n6D+mjkha7ZIqGFjgVUfR3LQ+hKCsog5ZrwfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795239050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6h7S1Z/Yg4pL1JyrxjPN4A6nDLlEh5v9NxEZIV677W4=;
	b=gPcEcUWfVWG/JHJKErQwlsmbWfA2C0DjKw+03FISzXPwcx3LKYTNONzB9w2/AFH1i0Wr
	 UeGTSABfbfcXx4dCJx7PEphQemX6/2TbLu/2P1s0Px1hGBe7/a+j06Cj82TRpiog3vjI3
	 CFm7o8BD1AweVsxepcEVic+SzAEuz5HrVWks0Y3Irzhc4JML1qTvRIE4nEjP7Ph/x8fSu
	 ssZz8IPVUoEq/50fsbzLYG3fsmTnhnIfjDWnK0X4t4f8Jns4EEFk7qCPhuBzUC1LwMDvd
	 kjzLwrGWqRpvv6LhCobeSD5hesSxaJk/I/WDXH3KBLvrSkG38muU036u2j6EOOod/0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDGIGh8X;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A2606A6AB
	for <linux-omap@vger.kernel.org>; Sat, 21 Nov 2026 05:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 139A2606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDGIGh8X
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f046b0adc0so7112735ad.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 21:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795239049; x=1795843849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6h7S1Z/Yg4pL1JyrxjPN4A6nDLlEh5v9NxEZIV677W4=;
        b=HDGIGh8XXuu6yFs5aKL2Y/+U8+5jXNrGXkzEe0/GwzpL/UTmJWLhS7qFFSs8ym2AfQ
         DbHqnJ5ZwZHpzx0eNkroFT9fd4xzei1MuSH5OL6YnyzbxsFUj9CDnjQO5rqbG3PNPXtk
         KRsryNkz7TqJ9bTVw4zPmpzSm9Qr/y74HZSfMAccWQwylHRQUoRVbFhwFc6RlPqvOHLU
         YXLu2BoGm8Z5UervBGgFhGiRjcriO+KbWDi0ggPNI8+ycvFEw8mSALPMRKrTRrQku3P6
         qP6sqX5lLXmE0ZW98Qdt+ZaIKpAdeVEWdqh4uSIeD5qh4EB1cotryl2Fcc/x5gmynWS9
         +CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795239049; x=1795843849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6h7S1Z/Yg4pL1JyrxjPN4A6nDLlEh5v9NxEZIV677W4=;
        b=omRKA7DDibSJlwMPIR0dDBQ49yBu7XuFMWmFh+jAvRNsjNNV6qVe0bz2uZ3/KzOgWk
         hZivAqmsnTJ9BPxSsB8+hZE8pE95s3FU+jCouYX8kQ2bHN6NMYZ0jKzY80ev8HqY3IUk
         FP19HvcrAqLesNBYX7sihI2uPBo85UpoDEIo6r7oIxcSYq0O44nMZ8FAY4vMAQaa2s/e
         Xl0W22srjOk8/oWwi1crksKIAbR4Wla96cGbJNnxD/4nN5oE8mwELdyV0azP1SHEwscO
         bn11vNMa7zmBtEHMapxG9ZdY9gdlpm4QKxtugvPy5mRYyQfKhX1ta6WihPyPzy31UeKU
         r62Q==
X-Forwarded-Encrypted: i=1; AL+hErG+o6ougtfL09EpjCYV35S8PCtLZoJEfoBs00wOwynLijlX1LbDS0b7u924tBmHPGOFLfUAEi1zPjp8@vger.kernel.org
X-Gm-Message-State: APuU4Z9E/f2xAajpTBZ16+Nm0ANWREYsiVpvDuKyblOpBYMguzAW2vX5
	PTsvZtmxO5u6NwZEPYjNT0tM7ARmn8Ta29v/SbvOMUIRngWUHLooOmtm
X-Gm-Gg: AZFdTZd2Xys6OGXbE3DGulHVHXky59FcD2uoyG0pp/L56YKAjJLzI+EXy3HgYgYvfSW
	80A0e2rwW7mqt3uMcR8I1B1QScI0zXdj1v2dOl+VWosM1FR9dNjSxT2dvouDECI7c2499KH2pGs
	im30DJA3QY6dUgbRq04PFCBL0LqpoNoKJgsKS8qadz7hvLqUkebkJahwFejk5zLhpvfTidITrAG
	kOHriHd8Fs/NpofBW94YxhMvzVB8U0Vka7QUMAcE0cK1OAeffQDj/tFU83kBzly9bvNVHgGucbF
	i7f35RGd5mqWeKdK/C+TIssI8P2cenyaZsQ2HOXQ6gTrjKLrvredWofRV61n18VLdq7YbD9mrbj
	HDxA3/s4989D35Vo4DJP/tDGtEejwegRcl0kIZ5e4IJU4AQ0vOPZzoPASCYkwe5A0KOKDAIaM5r
	/uL05tPeKxgWKvpyplyIkE5ggrP/1Gn83VpI4eOga+fxcNZ7/zR/hOCDz9hMlycYfxc499QmcJn
	B/csHTAgfm9a/+oXYvUqGKouNTCdPBAcWG+yDhbS+SlnmN4oIdSfRZ2Uico6kiR3hXOrZaR0Ia7
	/jCi9gbgRyjyvJhvynb2ASWVZxqnk+pu3O/TiKf3FDVsl5Q2
X-Received: by 2002:a17:903:298c:b0:2e9:5714:6075 with SMTP id d9443c01a7336-2f03f117c82mr51260805ad.17.1795239049247;
        Fri, 20 Nov 2026 21:30:49 -0800 (PST)
Received: from localhost.localdomain ([115.73.20.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0433a3a43sm18751085ad.62.2026.11.20.21.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 21:30:48 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Lars Poeschel <poeschel@lemonage.de>,
	linux-watchdog@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nhat Tran <nhat.tranminhk2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] watchdog: core: Don't report time left for a stopped watchdog
Date: Sat, 21 Nov 2026 12:29:50 +0700
Message-Id: <20261121052950.287506-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

watchdog_get_timeleft() calls the driver's ->get_timeleft() regardless
of whether the watchdog is running. It is reachable through the sysfs
timeleft attribute, which is world readable with CONFIG_WATCHDOG_SYSFS=y,
and through WDIOC_GETTIMELEFT, also after the watchdog was stopped with
WDIOS_DISABLECARD while the device is still open.

Drivers may not be able to access the hardware while the watchdog is
stopped. omap_wdt only holds a runtime PM reference while the watchdog
is running, so on a BeagleBone Black (AM335x) reading the counter of a
stopped watchdog triggers an external abort. Any unprivileged user can
hit it through sysfs:

  $ cat /sys/class/watchdog/watchdog0/timeleft
  Unhandled fault: external abort on non-linefetch (0x1028) at 0xf9e35028
  Internal error: : 1028 [#1] SMP ARM
  PC is at omap_wdt_get_timeleft+0x4/0x14
  LR is at watchdog_get_timeleft+0x24/0x130
  Call trace:
   omap_wdt_get_timeleft from watchdog_get_timeleft+0x24/0x130
   watchdog_get_timeleft from timeleft_show+0x3c/0x80
   timeleft_show from dev_attr_show+0x18/0x4c
   dev_attr_show from sysfs_kf_seq_show+0xa0/0x138
   ...

and the same happens with WDIOS_DISABLECARD followed by
WDIOC_GETTIMELEFT on the open device, once the module has idled:

  Call trace:
   omap_wdt_get_timeleft from watchdog_get_timeleft+0x24/0x130
   watchdog_get_timeleft from watchdog_ioctl+0x494/0x668
   watchdog_ioctl from sys_ioctl+0x128/0xbcc
   sys_ioctl from ret_fast_syscall+0x0/0x54

If the ioctl comes before the module has idled, the read succeeds but
reports 59 seconds left for a watchdog that is stopped.

A stopped watchdog will not reboot the system, so report 0 time left
when neither WDOG_ACTIVE nor WDOG_HW_RUNNING is set, without calling
into the driver. This matches the software fallback for drivers without
->get_timeleft(), which already decays to 0 once the watchdog is no
longer pinged.

Tested on a BeagleBone Black: with the watchdog stopped, both the sysfs
attribute and WDIOC_GETTIMELEFT after WDIOS_DISABLECARD return 0; with
the watchdog started through /dev/watchdog0, timeleft counts down as
before (59, then 56 three seconds later).

Fixes: 452fafed839e ("watchdog: omap_wdt: implement get_timeleft")
Cc: stable@vger.kernel.org
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
v1->v2:
- Moved the check from omap_wdt into watchdog_get_timeleft(), as
  suggested by Guenter, so it covers all drivers
- Return 0 for a stopped watchdog; this also covers WDIOC_GETTIMELEFT
  after WDIOS_DISABLECARD on an open device

v1: https://lore.kernel.org/all/20261120124009.24264-1-nhat.tranminhk2@gmail.com/
---
 drivers/watchdog/watchdog_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e8c1fcb53c56..b67a68316bda 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -435,6 +435,9 @@ static void watchdog_get_timeleft(struct watchdog_device *wdd,
 {
 	*timeleft = 0;
 
+	if (!watchdog_active(wdd) && !watchdog_hw_running(wdd))
+		return;
+
 	if (wdd->ops->get_timeleft) {
 		*timeleft = wdd->ops->get_timeleft(wdd);
 	} else {
-- 
2.25.1

