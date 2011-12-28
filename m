From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: Problem booting Overo Tide at 720MHz
Date: Wed, 28 Dec 2011 16:26:32 +0100
Message-ID: <jdfcf8$7ii$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58557 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964Ab1L1P0w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Dec 2011 10:26:52 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RfvOx-0005yL-6c
	for linux-omap@vger.kernel.org; Wed, 28 Dec 2011 16:26:47 +0100
Received: from dslb-188-103-250-025.pools.arcor-ip.net ([188.103.250.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 28 Dec 2011 16:26:47 +0100
Received: from andre.puschmann by dslb-188-103-250-025.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 28 Dec 2011 16:26:47 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi list,

a couple of days ago I was posting a similar issue where Linux wouldn't
start after u-boot. I am trying to boot a recent kernel using Steve's
omap-3.2 branch on an Overo Tide based board.

A recent checkout doesn't boot and hangs after u-boot hands over to the
kernel. After some digging I figured out that this has something to do
with the OPP settings for running at 720MHz.

After commenting out omap3_opp_enable_720Mhz() in opp3xxx_data.c the
kernel boots fine.

Does this work for all others?

Regards,
Andre

