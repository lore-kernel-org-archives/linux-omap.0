From: sharath kumar <sharath_dm@yahoo.com>
Subject: clock rate configuration through kernel configuration
Date: Tue, 22 Apr 2008 22:54:59 -0700 (PDT)
Message-ID: <182325.98011.qm@web32807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web32807.mail.mud.yahoo.com ([68.142.206.37]:39319 "HELO
	web32807.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751614AbYDWGBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2008 02:01:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
i am working on OMAP2430
i want to provide clock speed selection of dpll,
ARM speed and L3/ddr speed through make menuconfig

in the function "omap2_select_table_rate" in file
arch/arm/mach-omap2/clock24xx.c, if the current dpll
speed is twice or half of the currenlty programmed
dpll
value, is calls "omap2_reprogram_sdrc" function. 
Else only it configures the value given in rate table.

So even if i want to change the L3 clock with
different speed with dpll and arm at same speed i am
not able to(x-load/u-boot has initialized dpll at 660
and arm at 330) 

Also what is the purpose of function
"omap2_reprogram_sdrc"

Any suggestion on fix

Regards
Sharath




      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
