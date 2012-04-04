From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Wed, 4 Apr 2012 09:11:02 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50840 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257Ab2DDJLG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 05:11:06 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q349B4dQ019787
	for <linux-omap@vger.kernel.org>; Wed, 4 Apr 2012 04:11:05 -0500
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q349B384014796
	for <linux-omap@vger.kernel.org>; Wed, 4 Apr 2012 14:41:03 +0530 (IST)
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, Apr 04, 2012 at 11:06:39, Mohammed, Afzal wrote:
> OMAP3EVM is not booting on l-o master, with default configuration, HEAD
> @33fc21e Linux-omap rebuilt: Updated to v3.4-rc1, merged in most of pending branches.

Reverting merge commit

58adb29 Merge branch 'io_chain_devel_3.4' of git://git.pwsan.com/linux-2.6 into prm

makes OMAP3EVM boot.

Bisecting into this merge could not be done as build was breaking
for most of the individual commits in the merge (except when
HEAD is the last commit of the merge, as below). Assuming broken builds
to be good for bisect, it could get built for,

cca6430  ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle

but with it OMAP3EVM does not boot.


Regards
Afzal
