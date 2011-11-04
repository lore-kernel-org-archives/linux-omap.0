From: "Mahaveer, Vishal" <vishalm@ti.com>
Subject: RE: [PATCH 1/1] OMAP: TWL: set clk32kg regulator on
Date: Fri, 4 Nov 2011 23:20:49 +0000
Message-ID: <59CD7F2B651AD44A9EFE2AFA6166395D083879@DFLE34.ent.ti.com>
References: <1320162052-32276-1-git-send-email-vishalm@ti.com>
	<1320162052-32276-2-git-send-email-vishalm@ti.com> <87zkgb1nta.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42856 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab1KDXUw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 19:20:52 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pA4NKpIC002040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Nov 2011 18:20:51 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pA4NKpo2008545
	for <linux-omap@vger.kernel.org>; Fri, 4 Nov 2011 18:20:51 -0500 (CDT)
In-Reply-To: <87zkgb1nta.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> omap4_clk32kg regulator is used by connectivity (WLAN/BT/GPS) chip on
>> omap4 platforms.
>> Set always_on flag to true for connectivity chip to operate.
>
> The driver/init for the connectivity chip should be using the regulator
> API to enable/disable the regulator as needed.

The connectivity chip is used for BT, WLAN, FM and GPS. So we want it on at all times.

