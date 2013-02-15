From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Guidelines to move mach-omap2/gpmc to drivers/memory-controller
Date: Fri, 15 Feb 2013 13:58:41 -0300
Message-ID: <20130215165840.GB2442@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60588 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab3BOQ6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 11:58:47 -0500
Received: from localhost (20.222.3.200.ros.express.com.ar [200.3.222.20])
	by mail.free-electrons.com (Postfix) with ESMTPSA id A4501816
	for <linux-omap@vger.kernel.org>; Fri, 15 Feb 2013 17:58:44 +0100 (CET)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'd like to know which are the current constraints
preventing us from moving OMAP's GPMC memory controller driver
from mach-omap2/ to drivers/memory-controller.

I imagine one of the biggest issues is GPMC's dependency on
hwmod code. Can anyone shed some light on how to handle this?

Is there any way to move hwmod to some place under drivers/...?

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
