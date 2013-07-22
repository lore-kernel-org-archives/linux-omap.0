From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Mon, 22 Jul 2013 18:07:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47640 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab3GVSHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 14:07:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi,

After Linus's commit fb2af0020a51709ad87ea8055c325d3fbde04158 ("Merge 
branch 'for-linus' of git://git.linaro.org/people/rmk/linux-arm"), the 
OMAP2430 SDP here stopped booting.

Here's the bootlog at the commit before the merge, commit 790eac5640:

http://www.pwsan.com/omap/testlogs/bisect_2430sdp_hang_v3.11-rc/20130722015454/

and here's a log at commit fb2af0020a5:

http://www.pwsan.com/omap/testlogs/bisect_2430sdp_hang_v3.11-rc/20130722005921/

Any ideas as to what might have caused this?


- Paul
