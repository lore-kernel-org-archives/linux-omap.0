From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/05] OMAP3: SR: Fixes in Smartreflex driver
Date: Wed, 18 Mar 2009 15:25:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAEDE846@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44501 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754262AbZCRJzW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 05:55:22 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2I9tDRO023911
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 04:55:19 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2I9tCcs021986
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 15:25:13 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

Hi,

This series fixes a set of defects/issues in Smartreflex driver. SR autocompensation is now
functional and is validated with these patches on a ES3.1 based SDP with the
N values in Efuse.
Patches apply and are validated on the latest pm branch (2.6.28).

regards,
Rajendra

PS: I am having issues getting mails posted on the list, hence in case you comment
on these patches, please copy my id as well.