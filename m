From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: Git tree updated to v2.6.27-rc2, help needed
Date: Tue, 12 Aug 2008 10:09:22 +0300 (EEST)
Message-ID: <20080812.100922.07708606.Hiroshi.DOYU@nokia.com>
References: <20080811152620.GO25784@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32116 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYHLHKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 03:10:03 -0400
In-Reply-To: <20080811152620.GO25784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, sakari.ailus@nokia.com, edubezval@gmail.com

From: "ext Tony Lindgren" <tony@atomide.com>
Subject: Git tree updated to v2.6.27-rc2, help needed
Date: Mon, 11 Aug 2008 18:26:21 +0300

> Hi all,
> 
> I've updated our git tree to v2.6.27-rc2, and looks like we still
> have a bunch of issues to solve:
> 
> - DSP compile is broken as now device_create() is same as
>   device_create_drvdata(). So device_create() expects some
>   some drvdata to be set also in drivers/dsp/dspgateway/task.c
>   and drivers/dsp/dspgateway/dsp_ctl_core.c.
>   
>   Hiroshi, care to take a look at the DSP issue?

Got it. I will send the patch in another e-mail.

    Hiroshi DOYU


