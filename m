From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: v3.6-rc1 DSS issues/regression
Date: Mon, 6 Aug 2012 19:47:32 +0300
Message-ID: <20120806164732.GB1298@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:52700 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271Ab2HFQr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 12:47:57 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, archit@ti.com
Cc: tomi.valkeinen@ti.com

Hi,

I can't get the display on N900 (SDI, acx565akm) to work with v3.6-rc1
kernel, it's just full of flicker/noise.

According to git-bisect, the problem is introduced by the commit:

    commit f476ae9dab3234532d41d36beb4ba7be838fa786
    Author: Archit Taneja <archit@ti.com>
    Date:   Fri Jun 29 14:37:03 2012 +0530

    OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in interface

Any ideas?

Thanks,

A.
