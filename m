From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Git tree updated to v2.6.27-rc2, help needed
Date: Tue, 12 Aug 2008 20:42:26 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593013CAF8C60@dbde02.ent.ti.com>
References: <20080811152620.GO25784@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:58001 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748AbYHLPMq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 11:12:46 -0400
In-Reply-To: <20080811152620.GO25784@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Eduardo

The omap3_evm_defconfig needs to be updated.
Else, build fails with:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
arm-none-linux-gnueabi-ld: no machine record defined
arm-none-linux-gnueabi-ld: no machine record defined
make: *** [.tmp_vmlinux1] Error 1

"make oldconfig" did not help either.

I 'hacked' a defconfig with using omap_3430sdp_defconfig as reference for the build to be successful.
Will need to review it later in the night before I send a patch...

Best regards,
Sanjeev 

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
Sent: Monday, August 11, 2008 8:56 PM
To: linux-omap@vger.kernel.org; Sakari Ailus; Hiroshi DOYU; Eduardo Valentin
Subject: Git tree updated to v2.6.27-rc2, help needed

Hi all,

I've updated our git tree to v2.6.27-rc2, and looks like we still have a bunch of issues to solve:

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

I'll continue looking at the 3430sdp boot issues on Tuesday and then update to current mainline with the header changes.

Cheers,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

