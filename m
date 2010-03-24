From: Arno Steffen <arno.steffen@googlemail.com>
Subject: OMAP3 EVM - strange MAC address ?
Date: Wed, 24 Mar 2010 09:28:35 +0100
Message-ID: <804f0d21003240128i36e5d49cwc2bd652a03f5fae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:53972 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145Ab0CXI2h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 04:28:37 -0400
Received: by wwe15 with SMTP id 15so4816569wwe.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 01:28:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tested 2.6.33 kernel with the EVM board (uboot2010-03rc2).
What I observed is, that MAC address shown and used in linux while
booting, is completly different from that one in uboot.
Do I have to handover the MAC as a commandline parameter? If so, what
are the magic params?
Regards
Arno
