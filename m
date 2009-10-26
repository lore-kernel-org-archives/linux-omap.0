From: Felix Xiaozhu Lin <xzl@rice.edu>
Subject: update: n8x0 idle power problem
Date: Mon, 26 Oct 2009 17:36:25 -0500
Message-ID: <f25d86460910261536k5003954ehec9f30a936a6766@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:34717 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbZJZWgU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 18:36:20 -0400
Received: by yxe17 with SMTP id 17so10243780yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 15:36:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, All,

Regarding the idle power problem I've mentioned in a mail last weekend:

http://marc.info/?l=linux-omap&m=125634121921583&w=2

I have spent more efforts on this problem. By comparing with PM debug
messages from Maemo kernel, it seems full-retention in linux-omap
2.6.28 has no problem on n810. Moreover, I've observed that l-o kernel
consumes more power in other power states (e.g. when USB is plugged
and the screen is dim but not off, Maemo kernel takes ~90mA@3.8V while
l-o kernel takes ~180mA@3.8V). As a result, I think the extra power
may not be consumed by OMAP processor core but by some device.

I try to disable some devices in kernel configuration (BT/MMC/USB),
but it does not work - l-o power consumption is still significantly
higher than Maemo kernel.

Would you please offer some suggestions? Thanks

Best Regards,
--
Felix
