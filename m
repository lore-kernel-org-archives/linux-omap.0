From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [RFC][PATCH] ARM: OMAP: McBSP: Use register cache
Date: Fri, 04 Sep 2009 08:39:36 +0300
Message-ID: <1252042776.23177.39.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53017 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbZIDFj5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 01:39:57 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n845dGO7027304
	for <linux-omap@vger.kernel.org>; Fri, 4 Sep 2009 08:39:44 +0300
Received: from [172.23.119.28] (ouped11928.nmp.nokia.com [172.23.119.28])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n845dlRC026077
	for <linux-omap@vger.kernel.org>; Fri, 4 Sep 2009 08:39:48 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Register values should not get corrupted. Could you please point out the
registers that may get corrupted? Do they get corrupted during audio
play? I haven't seen corrupted register values.

- Eero

