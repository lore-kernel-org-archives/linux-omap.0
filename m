From: Gary Thomas <gary@mlbassoc.com>
Subject: DVSDK on OMAP/3530
Date: Fri, 16 Apr 2010 13:27:19 -0600
Message-ID: <4BC8BA17.5060200@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:46158 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758536Ab0DPT1V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 15:27:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP Linux discussion <linux-omap@vger.kernel.org>

I'm trying to run the DVSDK 3.01.00.03 on an OMAP/3530 board which is
not the OMAP3EVM (close, but from a different manufacturer).
I've ported my board specifics to the kernel that comes with
the DVSDK and everything seems to work.

Except for the video demos :-(  When I try to run 'decode',
it attempts to open the device '/dev/video1' which I've deduced
is a display in video mode.  However, I can't figure out where
or how that device is supposed to be created.

I've compared my kernel config with the standard EVM config
and all of the VIDEO/DSS/FB options match.

Can someone give me some help/guidance?

note: I'm not sure the best place to ask this - the DVSDK
getting started guide refers to omap3530_dvevm_beta@list.ti.com
but I cannot find it...

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
