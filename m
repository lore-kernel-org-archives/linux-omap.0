From: David Brownell <david-b@pacbell.net>
Subject: twl4030-power scripts and wedge-on-reboot
Date: Fri, 3 Apr 2009 17:56:56 -0700
Message-ID: <200904031756.57062.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n23b.bullet.mail.mud.yahoo.com ([68.142.206.142]:20055 "HELO
	n23b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753309AbZDDA5B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 20:57:01 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

I find that it's not just Beagle which refuses to reboot
when the twl4030-power driver is configured ... 3430 SDP
does so now, too.  (Standard OMAP tree with no particular
PM-related patches applied.)

Does anyone know what the problem is?

- Dave

