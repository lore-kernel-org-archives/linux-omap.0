From: twebb <taliaferro62@gmail.com>
Subject: 8-bit mode for OMAP MMC2
Date: Wed, 25 Mar 2009 17:44:45 -0400
Message-ID: <dbdb2ea60903251444g53d1a57fi847f9a5a7e833e78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:54746 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbZCYVor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 17:44:47 -0400
Received: by qw-out-2122.google.com with SMTP id 8so282794qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 14:44:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Looking through the head of l-o git, I don't see how 8-bit mode is
turned on for an MMC port - specifically MMC2.  I see where .wires is
now in place to support 1, 4, or 8, but I can't see anywhere that Bit
5 (DW8) of OMAP_HSMMC_CON register is set.  Is support for DW8 in
place and I just can't find it?

Thanks,
twebb
