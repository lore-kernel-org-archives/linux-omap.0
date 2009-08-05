From: twebb <taliaferro62@gmail.com>
Subject: how to implement and use the Software Booting Configuration Structure
	in OMAP3530
Date: Wed, 5 Aug 2009 16:34:28 -0400
Message-ID: <dbdb2ea60908051334g241faf1fy41d02b735e343a7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:10388 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbZHEUe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 16:34:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so157656qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 13:34:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omapandroid-discussion@omapzoom.org, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Can someone offer some insight or point to an example in code (kernel
or u-boot) regarding how software sets up the SW Booting Configuration
Structure (as described in TRM 25.4.4.4)?  Particularly, must the
structure itself be stored in a particular area in scratchpad memory?
Is the value at 0x48002910 supposed to be a pointer to the SW Booting
Config Structure or the start of the structure itself?

Thanks,
twebb
