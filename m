From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 0/3] OMAP3 Beagle: Enable nand support
Date: Sat, 31 May 2008 23:38:13 -0700
Message-ID: <5e088bd90805312338j540aef97s4735eba05c736448@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:30210 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbYFAGiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Jun 2008 02:38:14 -0400
Received: by rv-out-0506.google.com with SMTP id l9so526828rvb.1
        for <linux-omap@vger.kernel.org>; Sat, 31 May 2008 23:38:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This series of patches adds nand support to the beagle board.

The first patch in the series builds on work by Teerth Reddy
<teerth@ti.com> to extend the omap2 nand driver to work with both
omap2 and omap3 architectures (as well as adding/clarifying comments).

The second patch adds the beagle nand support, and the final patch
enables the nand driver and jffs2 support in the beagle defconfig.

The patch set was reviewed by Khasim Syed Mohammed <khasim@ti.com>
prior to this submission.  It was tested on a Rev B beagle board.
