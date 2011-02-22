From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Nokia CBUS code
Date: Tue, 22 Feb 2011 11:48:12 +0100
Message-ID: <1298371692.6998.19.camel@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:53842 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927Ab1BVKsT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 05:48:19 -0500
Received: by bu3sch.de with esmtpsa (Exim 4.69)
	(envelope-from <mb@bu3sch.de>)
	id 1Prpn1-00053j-9h
	for linux-omap@vger.kernel.org; Tue, 22 Feb 2011 11:48:19 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi there,

I was wondering if somebody was working on mainline integration of the
cbus code.
That probably is a major effort, as it needs a rewrite in some parts,
but I'm certainly interested in getting it mainlined, because I'm
currently developing a driver on top of it.
It's a battery management driver. If somebody is interested, it can
be found here:
https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches-2.6.37/900-n810-battery-management.patch
It currently doesn't support charging, however, almost all information
for the charging hardware is available. Registers and bits are known.
The only thing that's missing is the interpreter of the
calibration data. That's going to be some major effort, though,
because bme uses software floating point for that. That's currently
screwing my brains, but it should be doable.

-- 
Greetings Michael.

