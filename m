From: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Subject: Booting recent mainline on omap5-uevm
Date: Tue, 24 Sep 2013 20:20:36 +0000
Message-ID: <A2CA0424C0A6F04399FB9E1CD98E030458E05AA0@US01WEMBX2.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:61882 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab3IXUUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 16:20:41 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "lokeshvutla@ti.com" <lokeshvutla@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I have an OMAP5432 uEVM which I cannot get to boot with recent mainline
(tried 3.11 and 3.12-rc1). I have the TI GLSDK for this board (v6.0.0.7),
which comes with 3.8.4 which works fine.

I found this thread: http://marc.info/?l=fedora-arm&m=137717811815777 and
tried using git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
and merging in for_3.11/out_of_tree/omap5_clk_data from ssantosh's tree
as described, but with no luck.

In all cases the boot hangs after the "Starting kernel ..." message. I
enabled the low-level debugging options in the kernel but got no further
messages.

I'm using u-boot_2013.01.1.1 from the GLSDK, is that OK or do I need a
more recent version?

Is there a FAQ or wiki or something that describes what I need to do?

Thanks,
-- 
Paul

