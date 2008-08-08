From: "chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 0/2]  McBSP preamble patch for 34xx support,
Date: Fri, 8 Aug 2008 11:32:55 +0530 (IST)
Message-ID: <63331.192.168.10.89.1218175375.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33926 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbYHHGDB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2008 02:03:01 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7862utW010508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 8 Aug 2008 01:03:01 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7862qGQ029665
	for <linux-omap@vger.kernel.org>; Fri, 8 Aug 2008 01:02:54 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This a preamble patch series for McBSP support on OAMP34xx. it adds few
register definitions and and base addresses for all the McBSP instances.
It also modifies read/write functions to do 16/32 ops depending on CPU.
It doesn't add any functionality.

Regards,
Chandra Shekhar


