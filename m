From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: DSS2 and old omapfb patches
Date: Fri, 11 Dec 2009 14:31:31 +0200
Message-ID: <1260534691.10417.14.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18692 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZLKMbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 07:31:41 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nBBCVdMY024022
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 06:31:47 -0600
Received: from [172.21.40.63] (esdhcp04063.research.nokia.com [172.21.40.63])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nBBCVVC9007287
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 14:31:32 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

DSS2 has now been merged to the mainline, and I can finally start to
collect the board and panel patches. So base the patches on top of the
mainline kernel, and send the patches to me (cc l-o and/or fbdev).

Remember to run checkpatch and sparse for the patches. Also prepend the
patch name similarly to the following examples (I'm open to suggestions
if you have better ideas for prefixes):

OMAP: DSS: DSI: dsi stuff
OMAP: DSS: Taal: taal panel driver stuff
OMAP: OMAPFB: omapfb stuff

I will also maintain the older omapfb driver, as Imre is too busy with
other stuff. Hopefully there will not be many old omapfb patches =).

My DSS tree is at git://gitorious.org/linux-omap-dss2/linux.git, and I
will be adding the patches to the master branch. But note that I will
rebase the branch from time to time.

 Tomi


