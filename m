From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: dspbridge: rebasing missing patches from dspbridge-pm
Date: Mon, 5 Apr 2010 21:54:45 -0500
Message-ID: <4BBAA275.1000405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35714 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757228Ab0DFCyq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Apr 2010 22:54:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

Hi,

The following patches were rebased from dspbridge-pm to dspbridge branch:

DSPBRIDGE: Use dspbridge to initialize platform data
DSPBRIDGE: change to cpufreq_register_notifier for OPP changes

Now there is no need to keep dspbridge-pm so it has been removed.

Regards,

Omar
