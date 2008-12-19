From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: FYI: Retu RTC script for setting and storing system time in N8x0
Date: Fri, 19 Dec 2008 13:38:49 +0200
Message-ID: <20081219133849.c31b5258.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__19_Dec_2008_13_38_49_+0200_rZCIUVCuMZB3cSjF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53139 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbYLSLjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 06:39:11 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBJBcvKF011002
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 05:39:09 -0600
Received: from kikka3 (esdhcp042162.research.nokia.com [172.21.42.162])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with SMTP id mBJBcqbQ030465
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 13:38:52 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__19_Dec_2008_13_38_49_+0200_rZCIUVCuMZB3cSjF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi

I hacked once this Debian script for setting the N8x0 system time from
Retu RTC during the boot and saving the time stamp when doing shutdown.

Script can coexist with other hwclock and ntpdate scripts and can work
with read-only root as well. So if script cannot store the timestamp
diff then Retu RTC is not cleared.


Jarkko

--Multipart=_Fri__19_Dec_2008_13_38_49_+0200_rZCIUVCuMZB3cSjF
Content-Type: application/octet-stream;
 name="retuclock.tar.gz"
Content-Disposition: attachment;
 filename="retuclock.tar.gz"
Content-Transfer-Encoding: base64

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
KaSQQr6I/AMKVPT4ACgAAA==

--Multipart=_Fri__19_Dec_2008_13_38_49_+0200_rZCIUVCuMZB3cSjF--
