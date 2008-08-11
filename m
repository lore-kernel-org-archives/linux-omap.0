From: Tony Lindgren <tony@atomide.com>
Subject: Git tree updated to v2.6.27-rc2, help needed
Date: Mon, 11 Aug 2008 18:26:21 +0300
Message-ID: <20080811152620.GO25784@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59387 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbYHKP1I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 11:27:08 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Eduardo Valentin <edubezval@gmail.com>

Hi all,

I've updated our git tree to v2.6.27-rc2, and looks like we still
have a bunch of issues to solve:

- DSP compile is broken as now device_create() is same as
  device_create_drvdata(). So device_create() expects some
  some drvdata to be set also in drivers/dsp/dspgateway/task.c
  and drivers/dsp/dspgateway/dsp_ctl_core.c.
  
  Hiroshi, care to take a look at the DSP issue?

- V4L drivers init needs to be fixed as the configuration is
  now passed in some other struct. This affects at least
  omap24xxcam.c and radio-tea5761.c.
  
  Sakari & Eduardo, can you look at these issues?

- Booting fails early on 3430sdp for some reason

- Alignment error on omap2/3. This seems to happen also with
  718fc6cd4db902aa2242a736cc3feb8744a4c71a reverted?

- Pending patches to isp1301_omap.c need to be tested on H2 and H4
  USB

- Cpufreq is oopses on at least omap1

I'll continue looking at the 3430sdp boot issues on Tuesday and then
update to current mainline with the header changes.

Cheers,

Tony
