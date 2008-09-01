From: "Premi, Sanjeev" <premi@ti.com>
Subject: [PATCH0/3] Add support for OMAP35x processors
Date: Tue, 2 Sep 2008 01:26:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301A031B576@dbde02.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E0AFDBE42@dlee03.ent.ti.com>
 <20080806090708.GH19813@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593013CA23771@dbde02.ent.ti.com>
 <20080806101045.GL19813@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593013CA23868@dbde02.ent.ti.com>
 <20080808073956.GI24923@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35486 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbYIAT4l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 15:56:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81JuXZb023203
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 14:56:39 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m81JuW4M019495
	for <linux-omap@vger.kernel.org>; Tue, 2 Sep 2008 01:26:33 +0530 (IST)
In-Reply-To: <20080808073956.GI24923@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

These patches provide support for the OMAP35x processors.

This is essentially a re-submit after series of discusions
earliers in the list. Based on the comments received, this
patch includes following:
  1) Updates to Kconfig
  2) Runtime check for OMAP35x
  3) Updates to omap3_evm_defconfig

Best regards,
Sanjeev
