From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Query: MUSB clock management code
Date: Mon, 24 Aug 2009 16:39:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CEF2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43061 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbZHXLJu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 07:09:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7OB9jm8005537
	for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 06:09:51 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n7OB9i5V002778
	for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 16:39:45 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

Is there a reason to have a wrapper code around the clock
enable/disable code in arch/arm/mach-omap2/usb-musb.c?
Is it not okay for the glue-layer code in
drivers/usb/musb/omap2430.c to do this?

Thanks in advance,
Anand