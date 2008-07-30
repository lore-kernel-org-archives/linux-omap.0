From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: OMAPFB problem on 3430SDP
Date: Wed, 30 Jul 2008 09:35:43 +0300
Message-ID: <1217399743.25700.7.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62008 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbYG3GgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jul 2008 02:36:08 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6U6Zwxk004994
	for <linux-omap@vger.kernel.org>; Wed, 30 Jul 2008 01:36:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

When running linux-omap kernel on 3430SDP board (version VG5.0.0), the
picture on the LCD is very green. It seems to show only green color
component, or something like that. TI's own kernel works ok.

I've been going through all the DSS registers with Trace32, comparing
them between working and non-working kernels, but I haven't been able to
find differences.

Does linux-omap kernel work ok on earlier SDP versions? This one has
750-2081-102(B) as a display board, (I think the earlier ones have 101).
Any ideas what could be missing?

 Tomi


