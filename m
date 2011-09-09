From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: Polling support in omap uart driver
Date: Sat, 10 Sep 2011 00:23:18 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4B42F62@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38002 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759685Ab1IISxY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 14:53:24 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p89IrLgg022300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Sep 2011 13:53:23 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p89IrKdt004478
	for <linux-omap@vger.kernel.org>; Sat, 10 Sep 2011 00:23:20 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

Does omap serial driver (omap-serial.c) support polling?

Without this, kgdboc won't work, is that correct? 

Thanks.

   Hemant