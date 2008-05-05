From: sharath kumar <sharath_dm@yahoo.com>
Subject: support for sys_vmode pin on linux-2.6.14-omap2-v5 PM
Date: Mon, 5 May 2008 03:47:32 -0700 (PDT)
Message-ID: <940082.45697.qm@web32806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web32806.mail.mud.yahoo.com ([68.142.206.36]:20101 "HELO
	web32806.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752889AbYEEKrd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2008 06:47:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
i am working on adding PM support for OMAP2530EVM

When we move linux to suspend( by command "echo
"standby" > /sys/power/state") the sys_vmode pin
should go low(PRCM_VOLTCTRL setting).

But this is not happening.
Any information on this?

Regards
Sharath




      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
