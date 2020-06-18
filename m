Return-Path: <SRS0=LAuK=77=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB1FC433DF
	for <linux-omap@archiver.kernel.org>; Thu, 18 Jun 2020 02:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3794E2220E
	for <linux-omap@archiver.kernel.org>; Thu, 18 Jun 2020 02:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445745;
	bh=zsf3BNbMkMFZFRzExFDVzfc4J9xwxSZPT9wxEK4Rizs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z8SJChyrUD28N3q0pEOdJ0xLjMl6HU/A6W3UIMQLvmMYUF5l9YjqVA/wYbraVE0N4
	 M/HerDHkXOtFM2AW7D4EK5iZpO2yPSqIDxoOy26mRbCHlGJExxeAm/yoNwU1zHLT3t
	 Q+XI7wo4cSepPr4k16AEDFooYFGrw2vZUt3Cg9Y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbgFRCCT (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731073AbgFRBXv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4158020CC7;
        Thu, 18 Jun 2020 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443431;
        bh=zsf3BNbMkMFZFRzExFDVzfc4J9xwxSZPT9wxEK4Rizs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWwGbPpiivuJ0S2zc1PTCMRVwmovI1/28HyHufR1rOvqSiAK7ho4AwH5dl+S+9Sqs
         CSNmh2c2y1+dYU5LO/xLRO1HtpC/3OngMp8HwFmAbQiDApPFGGLvsjKxPXcJqy39u1
         BvuCb+5uLqY7QneNWLo935iCsKS/u7ymo7Ftq9t4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 070/172] thermal/drivers/ti-soc-thermal: Avoid dereferencing ERR_PTR
Date:   Wed, 17 Jun 2020 21:20:36 -0400
Message-Id: <20200618012218.607130-70-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

[ Upstream commit 7440f518dad9d861d76c64956641eeddd3586f75 ]

On error the function ti_bandgap_get_sensor_data() returns the error
code in ERR_PTR() but we only checked if the return value is NULL or
not. And, so we can dereference an error code inside ERR_PTR.
While at it, convert a check to IS_ERR_OR_NULL.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200424161944.6044-1-sudipm.mukherjee@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b4f981daeaf2..452e034aedc1 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -183,7 +183,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (!data || IS_ERR(data))
+	if (!IS_ERR_OR_NULL(data))
 		data = ti_thermal_build_data(bgp, id);
 
 	if (!data)
@@ -210,7 +210,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data && data->ti_thermal) {
+	if (!IS_ERR_OR_NULL(data) && data->ti_thermal) {
 		if (data->our_zone)
 			thermal_zone_device_unregister(data->ti_thermal);
 	}
@@ -276,7 +276,7 @@ int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data) {
+	if (!IS_ERR_OR_NULL(data)) {
 		cpufreq_cooling_unregister(data->cool_dev);
 		if (data->policy)
 			cpufreq_cpu_put(data->policy);
-- 
2.25.1

