From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [BUG?] drivers: net:ethernet: cpsw: add support for VLAN
Date: Thu, 23 Apr 2015 00:28:22 +0200
Message-ID: <1429741702.29353.28.camel@mars>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34774 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbbDVW20 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2015 18:28:26 -0400
Received: by wicmx19 with SMTP id mx19so4516616wic.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2015 15:28:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>, Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

 has commit 3b72c2fe0c6bbec42e ("drivers: net:ethernet: cpsw: add
support for VLAN") introduced a bug by defining CPSW_VLAN_AWARE as
BIT(1) instead of BIT(2)?

+#define CPSW_VLAN_AWARE		BIT(1)
<snip>
 	/* switch to vlan unaware mode */
-	cpsw_ale_control_set(priv->ale, 0, ALE_VLAN_AWARE, 0);
+	cpsw_ale_control_set(priv->ale, priv->host_port, ALE_VLAN_AWARE,
+			     CPSW_ALE_VLAN_AWARE);
+	control_reg = readl(&priv->regs->control);
+	control_reg |= CPSW_VLAN_AWARE;
+	writel(control_reg, &priv->regs->control);

See TRM [1] page 1980 (14.5.1.2 CONTROL Register), there bit
CPSW_VLAN_AWARE is number 2.

I didn't do any tests, just stumbled upon.

[1]: http://www.ti.com/lit/ug/spruh73l/spruh73l.pdf

Thanks
 -- Christoph

