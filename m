From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: RE: ASoC audio not working on OMAP3 EVM
Date: Thu, 12 Feb 2009 09:39:53 +0200
Message-ID: <1234424393.13374.2.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58177 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbZBLHlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 02:41:47 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1C7fTVN031716
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 09:41:43 +0200
Received: from [172.23.118.146] (ouped118146.nmp.nokia.com [172.23.118.146])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n1C7f2oC022324
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 09:41:02 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

> Has anyone observed the same problems on other platforms as well? Do
> we have a fix for them?

Give this a try:

http://marc.info/?l=linux-omap&m=123269333910864&w=2

If you press down enter (or so), and the audio plays better,
this will help. I dont know whether this EVM uses McBSP though.
(if it doesn't apply, please merge manually)


- Eero

