Return-Path: <SRS0=Ij9V=7S=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF63CC433E0
	for <linux-omap@archiver.kernel.org>; Fri,  5 Jun 2020 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D674C2074B
	for <linux-omap@archiver.kernel.org>; Fri,  5 Jun 2020 17:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgFERkk (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:40:40 -0400
Received: from 46-22-124-5.ip.axbyte.se ([46.22.124.5]:43150 "EHLO
        mail01.ohdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgFERkj (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2020 13:40:39 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2020 13:40:38 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail01.ohdata.se (Postfix) with ESMTP id 542F421376;
        Fri,  5 Jun 2020 19:24:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail01.ohdata.se
Received: from mail01.ohdata.se ([127.0.0.1])
        by localhost (mail01.ohdata.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1t0JVADKSkHx; Fri,  5 Jun 2020 19:24:50 +0200 (CEST)
Received: from webmail.ohdata.se (unknown [10.0.38.61])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail01.ohdata.se (Postfix) with ESMTPSA id DFAF55EB3;
        Fri,  5 Jun 2020 19:24:49 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 05 Jun 2020 19:51:09 +0200
From:   Oskar Holmlund <info@ohdata.se>
To:     linux-omap@vger.kernel.org
Cc:     tony@atomide.com, bcousson@baylibre.com
Subject: PATCH: ARM: am33xx.dtsi ti,sysc-mask wrong softreset flag
Organization: OH Data
Message-ID: <d5f2bd51988130c1220179dbf54df62d@ohdata.se>
X-Sender: info@ohdata.se
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

AM335x TRM: Figure 16-23 define sysconfig register and soft_reset
are in first position corresponding to SYSC_OMAP4_SOFTRESET defined
in ti-sysc.h.

Diff created from am33xx.dtsi commit 
e20ef23dd6937c38df2cfddf15270668153c8177

Signed-off-by: Oskar Holmlund <oskar@ohdata.se>
--- arch/arm/boot/dts/am33xx.dtsi.orig	2020-06-05 18:58:39.720383275 
+0200
+++ arch/arm/boot/dts/am33xx.dtsi	2020-06-05 18:59:23.140945292 +0200
@@ -335,7 +335,7 @@
  			      <0x47400010 0x4>;
  			reg-names = "rev", "sysc";
  			ti,sysc-mask = <(SYSC_OMAP4_FREEEMU |
-					 SYSC_OMAP2_SOFTRESET)>;
+					 SYSC_OMAP4_SOFTRESET)>;
  			ti,sysc-midle = <SYSC_IDLE_FORCE>,
  					<SYSC_IDLE_NO>,
  					<SYSC_IDLE_SMART>;

-- 
Bästa Hälsningar
Oskar Holmlund
Tel 070-3220292
