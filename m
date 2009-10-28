From: Mike Rapoport <mike@compulab.co.il>
Subject: [RFC PATCH 0/3] mux framework rework
Date: Wed, 28 Oct 2009 15:07:42 +0200
Message-ID: <cover.1256734115.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:55723 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbZJ1NRi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 09:17:38 -0400
Received: from mail.linux-boards.com ([192.114.83.142] helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1N38PG-0007S0-AS
	for linux-omap@vger.kernel.org; Wed, 28 Oct 2009 08:17:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 4FC309A035A
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 15:17:41 +0200 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

This is an attempt to start rework of the mux framework keeping as
much backward compatibility as possible.
The patch serie introduces a new mux configuration interface that
follows the ideas of PXA MFP implementation ([1] and [2]).
The mux configuration interface is implemented for OMAP3 and partially
for OMAP2 processors.
The OMAP2 implementation is far from being complete. Unfortunately I
do not have OMAP2 docs, so I've added only configration for pins
defined in omap24xx_pins table.

The older opam_cfg_reg interface is still present and can be used to
avoid too many broken things in steps 2 & 3 as of Tony's plans ([3]).

[1] Documentation/arm/pxa/mfp.txt
[2] http://elinux.org/OMAP_wishlist#References
[3] http://elinux.org/OMAP_wishlist#Initial_plans_.28from_Tony.2C_for_next_merge_window.29

Changes since commit 0bbf5337f2f2957775051a3caf60b66d3306c815
  Tony Lindgren
  	Fix compile for 1510 innovator

Mike Rapoport (3):
  omap2: mux: intoduce omap_mux_{read,write}
  omap: mux: add interface for encoded mux configration
  omap2: mux: implement encoded mux configuration

 arch/arm/mach-omap2/include/mach/mux.h     |  452 +++++++++++++++
 arch/arm/mach-omap2/include/mach/mux24xx.h |  128 ++++
 arch/arm/mach-omap2/include/mach/mux34xx.h |  862 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c                  |  158 +++++-
 arch/arm/plat-omap/include/plat/mux.h      |   62 +--
 arch/arm/plat-omap/mux.c                   |   17 +
 6 files changed, 1614 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/mux.h
 create mode 100644 arch/arm/mach-omap2/include/mach/mux24xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/mux34xx.h

