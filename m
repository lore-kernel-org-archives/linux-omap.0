From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv3 0/6] omap3: Various fixes and improvements for IGEP v2 board.
Date: Fri,  1 Oct 2010 23:09:03 +0200
Message-ID: <1285967349-32767-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59129 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0JAVJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:09:16 -0400
Received: by wyb28 with SMTP id 28so3369724wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 14:09:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hello,

This is the version 3 of patch series to fix and improve the IGEP v2 board support.

Changes since v2:
 - [1/6] check the result value of gpio_request and gpio_direction_*
 - [2/6] align the igep2_gpio_leds with tabs.
 - cc linux-arm-kernel

Kind regards,

  Enric
