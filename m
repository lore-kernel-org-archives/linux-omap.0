From: Gary Thomas <gary@mlbassoc.com>
Subject: DSS2 clocking
Date: Wed, 21 Oct 2009 06:42:41 -0600
Message-ID: <4ADF01C1.3020602@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:56490 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbZJUMmh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 08:42:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>

I'm using DSS2, currently just with a frame buffer to a
[VGA/RGB] monitor.

I'm trying to understand how to set the timing parameters
for my device.  The simple 'omapfb.mode=1024x768-24@75'
doesn't quite cut it for some of the devices I need to
use.

Questions:
  * How can I get different pixel clocks?  I seem to always
    end up with 61714285:
      # cat /tmp/dbg/omapdss/clk
      - dss -
      internal clk count      2
      dss_ick         83000000        1
      dss1_alwon_fck  123428570       1
      dss2_alwon_fck  13000000        0
      dss_tv_fck      54000000        0
      dss_96m_fck     96000000        0
      - dispc -
      dispc fclk source = dss1_alwon_fclk
      pixel clk = 123428570 / 1 / 2 = 61714285
  * How can I control the waveform?  In particular, the
    size and shape of the "porches"?  My display seems to
    need these settings:
      61714,1024/26/162/136,768/3/29/6
    I'd like to get this behaviour, either from the boot line
    or ideally by default.
  * The display also seems to want the sync pulses to be
    asserted low (inverted?).  Currently, I have this "hard-wired"
    into my display device, but I'd also like this to be adjustable.

Thanks for any pointers, etc.

Note: I'm using Tomi's tree from roughly late July
   http://www.bat.org/~tomba/git/linux-omap-dss.git
   7ae220f46384b34e72b8c3b0c2075a674a3f74fe

Thanks for any pointers

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
