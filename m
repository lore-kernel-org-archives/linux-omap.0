Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999403;
	b=RWlf+KVOQZh8trEKPGqvFYrJkp3n9QmZ5YeXtgObyChxpoDUG7UeLI8Q7XeOGE+8LEQs
	 4+KKONL4Aamkiq+yErNShoR+MQTh9os6EkeIZDr5yxgLNTKt2+R1lw7HgRpBd384pafbM
	 wGVHPTaboPLuU+24H74KcBOtIx7ZgBTWK4aQZS2TYesRWXg55lJv9MlGGrNRXaUfNzuO/
	 Vc24AbJrWLtLH5JHpFXhzLEw8tuCDBhpWC27ZWikMoL9Jy2G3dqVfOaZlGxdm21y/vHiM
	 eBkKoagmykHKoY3XXrKCxWjWD3025X1n8HNFH18Rkpk5W5vXyxyiluyikQj57lx6vSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gm0Qfj369v7uXPDM6N2vje8RwwrOggEoYcp57t3sBRQ=;
	b=2bQdeF8eZP8ZrDlcTSlfnVGl4uPVlBncpzatvqJvFps5Pkr4i91LBgtFYp1XkEabeaZj
	 4Fhh68C6Lwbr71LHFLunQCjW0MtUSakAj2VFd1crBjykeJiYN+WE5mzN0dM6bxyU3SAHN
	 mbz/vmQ4wbzZEEWk2sQZ1DhlPbXlEVe3dAaQf6huly7sNKjMzzbvJyLylUR2W1p1eH9l0
	 W5zzvaadDQk8RF+wsKxZAc16oXQjrFWWe2j+qclns/jGr8miKon7Fqgc6oNIrDnXmaSo9
	 qrGqc8BiS9dzxiQqdwUHIdxC7mPtB32md2sJhMOoNRMsl2lDqtVDvqL2LAJIS9UMasA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AbC9tHqi;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AA606A332
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 07:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 257AA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AbC9tHqi
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso1251043a91.2
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999402; x=1793604202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gm0Qfj369v7uXPDM6N2vje8RwwrOggEoYcp57t3sBRQ=;
        b=AbC9tHqiWLexdwdWZtIOTgzF2d8pLKJ1EObJ8p8mRtcbmiiDZNR9CpY+n3qXNWbNdv
         dZKwYY8AG3zY9khxWaWSk6TaC4W6O/BHPwf2MLL9GBcQ+/etbEDNjoJBO8pby5nxSOXC
         eDt9szoI+AEK0GlcKWiu3ctysnL/kahWgXV3n3Xr2O25PsJoZeRByF/Fth1c+Ylfopxf
         gfQzDfSX2yxqs5tNX6nmZeNwEBqAlp2dIJwCsVsB4gi7U2OBWc6BzxPsMa9KYD8zU4ng
         yA1AYAxJOC7weI6O/wWjpDVuCiFxzNOUPnH79kRdvLtmy3uuNAJHpDo9rTFakZCnTqPZ
         SlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999402; x=1793604202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gm0Qfj369v7uXPDM6N2vje8RwwrOggEoYcp57t3sBRQ=;
        b=sGKbwAG/BNT9DlXnjWBoz3OdfMKymhKTSIVVnsPP7ihVLrP0nLC7nscMJVTBAzTl8w
         q0rF8l3F0ogY0d5RUW8hej+uhzefVIU4u5MfWKyxCz3c32/qHbel9fDsvwcpuhL+euQT
         ik3/oIgC7hivO+gKSVGe70m0jmjr2BQ/9hRlXQK1a7XWFU5VoiVkTPNLI/Uou5P+XXTG
         zIbnPqVwqNIoTUvgREsZpcWQjTecYtz7U6sLvIGLvTo4pXuQPbzaxKS7+ZZiDStCTE+0
         82+fRJD3x2hMwwdCxk+43kzYVxEn7dEBtNlPvkcvjlid0IrkFSCP+zasMD3jbTHSWXlO
         2dbA==
X-Forwarded-Encrypted: i=1; AKwUvBwn7ANn6Rl7zz1Iv8fU4KuZ8P/ToY6HugxQPnt5W7eOQ/aaQYrXg8PEE+ARmbM71WCs08SJ/L6sl/Zc@vger.kernel.org
X-Gm-Message-State: AFq9FYIH+UK02O24XuDdX2yizp38PBCT7Ez8bpg51oeJDwlLpTp0Ux4N
	wMEdy3tptkeROD1xhh4gNsKIEtD2QTQYFV6rWtfZ7AhK5D/Yl9lUcUFz
X-Gm-Gg: AYBFou3IBR7URRR6t1N5lmTfsZWOcmkAAvSvcG/EkVi6pp6ZZOf9LdJg9hm4NNJU3pv
	dbH+hWIc7yPYH2lJmxInW8kBSA/u6wDJcQayZKdPJw6XMuoGsP9tp07msKPSDlpCrGsUP38rlCS
	PuiFE94JbmW9GTALHUyjKmUmPzQJpj9cJx8YN67Krqvwpka653h395pyMbf4CJJWkF2cY5j9e1K
	ldOvRujMwaVRXQMT2Cb6NOzPArifYgOLK3BA++gnxcpOBSyjDrpKTVADW+JBsl5ohTy4TsN1hf9
	gRiYWeJLZKg5sDxPx5ajGt7AEVi6JiT7UKgqE93lhyTuiSwzK6At6U/avk6nDcCIJio9cqukTAH
	cpA8wsH3VoxXEP0mc0Luy4mlfyL94uCsKnKHwZB4iU++KFDNmPNzD0HZMx4Ou7ZTqJOu2TFf5xB
	D+kjBik1EieaJemDzFq4WZDHrRUl/+aq97unxrQBAkmfJdkVJRosjYIGk6QCKglU7FK2/KQWdwp
	AizROOC25UPpIcqJ560ryQXmP5G/UPdAyJB4ky0IKnGgZjeaCCN0Ve79WRczo+jhlc3rWL3krKK
	HHaiepbomQ2KWPmHJfDSn2oAa2kmYk0DgcVoMvcSR9oO1Ccm0BH382OoFFFWLgBcCtPZT1zCkoq
	OPCBCG9Uj41tEEvCpNLpIY2Opuauapo8Ao58=
X-Received: by 2002:a17:90b:2252:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3adeafb596amr5624976a91.41.1792999402381;
        Mon, 26 Oct 2026 00:23:22 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm7112987a91.4.2026.10.26.00.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:23:22 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: [PATCH net] net: ethernet: ti: cpts: drop stale events before the misc IRQ can fire
Date: Mon, 26 Oct 2026 15:23:14 +0800
Message-ID: <20261026072314.663980-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
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

cpsw requests its misc IRQ at probe, but the CPTS event pool is only set
up later, in cpts_register() from ndo_open. That is fine from a cold boot,
where the CPTS comes out of reset stopped with its interrupt masked. After
a kexec it is not: the previous kernel leaves the CPTS running with
TS_PEND_EN set and events in its FIFO, so the interrupt fires as soon as
it is requested and cpts_fifo_read() takes an entry from the still empty
pool list:

  Unable to handle kernel NULL pointer dereference at virtual address 00000010 when write
  PC is at cpts_fifo_read+0xa4/0x3c8
  Call trace:
   cpts_fifo_read from cpsw_misc_interrupt+0x30/0x4c
   cpsw_misc_interrupt from __handle_irq_event_percpu+0x74/0x378
   ...
   __setup_irq from request_threaded_irq+0xbc/0x170
   request_threaded_irq from devm_request_threaded_irq+0x70/0x104

On a BeagleBone Black the CPTS registers read control=0x1, int_enable=0x1
and intstat_raw=0x1 in cpts_create() after the kexec, with one event
queued.

Mask the CPTS interrupt and drain the FIFO in cpts_create(), before
either cpsw driver requests the IRQ. cpts_register() unmasks it again
once the pool exists. The CPTS is left enabled: clearing CPTS_EN at this
point made TS_PEND_RAW read back as set, which would hand the handler a
bogus event.

Masking alone is not enough, as the interrupt may already be latched by
then, and clearing the wrapper's misc_en before requesting the IRQ does
not help either, since cpsw_misc_interrupt() sets it again on the way
out.

Fixes: 84ea9c0a95d7 ("net: ethernet: ti: cpsw: enable cpts irq")
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
Tested on a BeagleBone Black (AM335x, cpsw_new) on top of net 7076f684d5:

 - Cold boot from U-Boot: probe and link come up and /dev/ptp0 is
   registered, as before.
 - kexec_load from a kernel without this patch into one with it, and from
   a patched kernel into itself: no oops, link comes up, /dev/ptp0 is
   registered and its time advances.

Without the patch the kexec'd kernel oopses as quoted above on every boot.

Not tested: the legacy cpsw driver, and Keystone netcp_ethss, which also
calls cpts_create(). The CPTS_EN behaviour described above was only
observed on AM335x.

How this was made: the investigation, the fix and this description were
done with an AI coding assistant (Claude Code) driving my board. Three
earlier attempts (clearing misc_en at probe, clearing CPTS_EN, draining and
then clearing CPTS_EN) were tried on the hardware and dropped; the register
values quoted above come from a debug print added for that. I have
reviewed the patch and can answer for it.

 drivers/net/ethernet/ti/cpts.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 2ba4c8795d..3cc908ac90 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -747,7 +747,8 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
 			 struct device_node *node, u32 n_ext_ts)
 {
 	struct cpts *cpts;
-	int ret;
+	u32 high, low;
+	int ret, i;
 
 	cpts = devm_kzalloc(dev, sizeof(*cpts), GFP_KERNEL);
 	if (!cpts)
@@ -779,6 +780,17 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
 	if (ret)
 		return ERR_PTR(ret);
 
+	/* After a kexec the CPTS may still be running from the previous
+	 * kernel, with its interrupt enabled and events in the FIFO. The misc
+	 * IRQ is requested before cpts_register() sets up the event pool, so
+	 * mask the interrupt and drop the stale events now.
+	 */
+	cpts_write32(cpts, 0, int_enable);
+	for (i = 0; i < CPTS_FIFO_DEPTH; i++) {
+		if (cpts_fifo_pop(cpts, &high, &low))
+			break;
+	}
+
 	cpts->cc.read = cpts_systim_read;
 	cpts->cc.mask = CLOCKSOURCE_MASK(32);
 	cpts->info = cpts_info;
-- 
2.43.0

