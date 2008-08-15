From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 0/4][GIT 3/4+] Dspbridge cleanup patches
Date: Fri, 15 Aug 2008 02:21:39 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530825E140@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:39005 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbYHOHVq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 03:21:46 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7F7LfLP013893
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 02:21:46 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7F7LeiR023741
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 02:21:40 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I updated Gforge site with some more patches they are now a total of 17 uploaded, the ones that were added are applied on top of the previous ones, you can find them at:

http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseView&release_id=119

I remind you to update your API and samples code when using the latest patches or when pulling from OmapZoom GIT, since the previous one will not longer work due to bool type changes in bridge sources, you can find these tarballs at:

http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseView&release_id=117

-omar
