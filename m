From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: OMAP2430 build breakage and git bisect issues
Date: Tue, 8 Apr 2008 19:49:27 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08805C3073E@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:41869 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbYDHOTf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 10:19:35 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m38EJTYD015571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Apr 2008 09:19:34 -0500
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m38EJSmK024407
	for <linux-omap@vger.kernel.org>; Tue, 8 Apr 2008 09:19:29 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

omap_2430sdp_defconfig and omap_2430osk_defconfig builds seem to be broken. (also reported at [1])

I tried to use git bisect to narrow down the exact patch that caused this and it looks like some patches that got merged don't compile individually. This causes the git bisect process to fail.

For instance, this happens when git bisect lands me in the middle of a mainline merge. Then I can't do a make omap_*_defconfig.

In other cases than a mainline merge, some patches are not individually compilable.
For instance commit [2b2d5f705f1f5fad4275401d695697c06ad1e886] ARM: OMAP: More fixes for cm and prm assembly access

How do I recover from this? Or move to a compilable patch near to the bisect point?

Regards,
Anand

[1] http://opensource.indt.org/omapbuilds/
