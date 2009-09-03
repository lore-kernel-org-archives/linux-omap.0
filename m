From: "vimal singh" <vimalsingh@ti.com>
Subject: [PATCH 0/2] mfd: restoring twl4030 power-off and power-button
     capabilities
Date: Thu, 3 Sep 2009 20:41:41 +0530 (IST)
Message-ID: <52241.192.168.10.89.1251990701.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42016 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687AbZICPLo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Sep 2009 11:11:44 -0400
References: 
In-Reply-To: 
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

This patch series restores the TWL Power-button and Power-off capabilities.
Which were removed in "REMOVE OMAP LEGACY CODE" patches.

Patches are compile tested only.

[PATCH 1/2]: twl4030: register twl4030-pwrbuttonas a child of twl4030-core.c
[PATCH 2/2]: twl4030: initialization of pm_power_off in twl4030-core.c

Both patches are based on Felipe Balbi's patches posted earlier.
http://lkml.org/lkml/2009/2/28/88
http://markmail.org/message/ts4if3553qnauket

--
Vimal




