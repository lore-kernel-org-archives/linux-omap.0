From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Error detecting mmc card on zoom3
Date: Wed, 18 Nov 2009 15:35:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309DAC22C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48869 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbZKRKFI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 05:05:08 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAIA5BqR009769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 04:05:13 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAIA5AVM026253
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 15:35:10 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm unable to use MMC on a zoom3 board with current linux-omap kernel.
I see the following error in the bootlogs.

  mmci-omap-hs mmci-omap-hs.0: err -19 configuring card detect


I'll take a stab at this in a couple of hours unless someone beats me to it.

- Anand
