Return-Path: <SRS0=+Yrj=6W=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF3C47257
	for <linux-omap@archiver.kernel.org>; Fri,  8 May 2020 13:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53592495E
	for <linux-omap@archiver.kernel.org>; Fri,  8 May 2020 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943057;
	bh=SbeMZvBA0eJK7/TX5gEO/2xhRpT05ICuzaksMey8lCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nAQEo0n+4gw7NcqANRkRyoC7vxDgu0oTL+j28sj/Oabru07i/3aY+kjnYcz5pCduX
	 S8ft3AIxk0NGKG8LIWVrv9GFljO84CD6spsrZWtEExu4cCkReNolgIzygjWU6I91Xl
	 rZhgLbcHLohJMtEmEjN9BztQAE1POU3aO1k2bliU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgEHMtM (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 8 May 2020 08:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbgEHMtL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 8 May 2020 08:49:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 964432495C;
        Fri,  8 May 2020 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942151;
        bh=SbeMZvBA0eJK7/TX5gEO/2xhRpT05ICuzaksMey8lCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBCshXrKJ6YNO7gy828VWvcW/P91o2Jv36yEKgbyR4pSoB2eTO2BemK+8zI3AKK4Q
         SpmbWuzl/ZTzHEUu7d6Nfk0RIB50Y/fm2Gb/9+ZRZRK/5M4QFUeGzmnzpXGmolcfXZ
         GaE5hE6pwZek2wg3e4EWr6e0JHhton52w3RxSJmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-omap@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 278/312] net: ethernet: ti: cpsw: fix device and of_node leaks
Date:   Fri,  8 May 2020 14:34:29 +0200
Message-Id: <20200508123143.975041602@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit c7262aaace1b17a650598063e3b9ee1785fde377 upstream.

Make sure to drop the references taken by of_get_child_by_name() and
bus_find_device() before returning from cpsw_phy_sel().

Note that holding a reference to the cpsw-phy-sel device does not
prevent the devres-managed private data from going away.

Fixes: 5892cd135e16 ("drivers: net: cpsw-phy-sel: Add new driver...")
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/ti/cpsw-phy-sel.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -154,9 +154,12 @@ void cpsw_phy_sel(struct device *dev, ph
 	}
 
 	dev = bus_find_device(&platform_bus_type, NULL, node, match);
+	of_node_put(node);
 	priv = dev_get_drvdata(dev);
 
 	priv->cpsw_phy_sel(priv, phy_mode, slave);
+
+	put_device(dev);
 }
 EXPORT_SYMBOL_GPL(cpsw_phy_sel);
 


