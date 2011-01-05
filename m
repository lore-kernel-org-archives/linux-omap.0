From: "Gopinath, Thara" <thara@ti.com>
Subject: OMAP DVFS rebase
Date: Wed, 5 Jan 2011 21:13:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F204@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37742 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994Ab1AEPn5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 10:43:57 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p05FhsEZ013477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Jan 2011 09:43:56 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p05Fhsr9006481
	for <linux-omap@vger.kernel.org>; Wed, 5 Jan 2011 21:13:54 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello All,

I have rebased the available DVFS code for OMAP tree
against LO master which contains the latest OMAP voltage
layer and smartreflex changes and hosted it at
	http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=shortlog;h=refs/heads/pm-dvfs

	head - pm-dvfs

Regards
Thara	
