From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/10] OMAP3 SRF: OMAP PM interface implemented using
     Shared resource Framework
Date: Mon, 11 Aug 2008 18:34:59 +0530 (IST)
Message-ID: <44828.192.168.10.89.1218459899.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44185 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbYHKNFG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Aug 2008 09:05:06 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7BD50bL001913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 11 Aug 2008 08:05:06 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7BD4vdt024748
	for <linux-omap@vger.kernel.org>; Mon, 11 Aug 2008 08:04:59 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

The patches which follow implement the API's defined by Paul Walmsley as part
of the OMAP PM Interface on OMAP3430sdp.
Shared resource f/w is used for the underlying implementation.

The following resources are modeled
1) MPU/CORE latency resources
2) Power Domain latency resources (One for each Power domain)
3) OPP/Freq resources (For DVFS)

The following patch posted on the l-o list by Paul W. is a pre-requisite for
these patches to apply.
[PATCH] OMAP2/3 PM: Add OMAP PM no-op layer

regards,
Rajendra



