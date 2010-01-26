From: "Andrew Murray" <amurray@mpc-data.co.uk>
Subject: PM: VDD2 OPPs
Date: Tue, 26 Jan 2010 20:34:23 -0000
Message-ID: <0C997DD87CC88A4F86C897F52650B52B02807701@MOLSON.mpc-data.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cvs.mpc-ogw.co.uk ([81.2.99.171]:9866 "EHLO
	molson.mpc-data.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751211Ab0AZUeZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:34:25 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

With regards to the OMAP2 (or at least the 3530 EVM) -the TRM and
various whitepapers suggest that they are 3 OPP levels available for
VDD2 (L3). However, from looking at the sources (linux-omap-pm / pm
branch) it seems that only 2 OPP levels are supported (@166Mhz and
@83Mhz) and used. I also notice that these rates are different to those
in a whitepaper (166, 100 and 41.5). Is there any particular reason why
only 2 OPPs are used? 

I understand that the OPP level of VDD2 may be set by changes to the OPP
level of VDD1 (i.e. resource34xx.c:set_opp) - and modifying VDD1's OPP
via cpufreq seems to be the only way to adjust the VDD2 OPP from
user-land - is this correct?

Thanks,

Andrew Murray

