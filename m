From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: linux-omap pm branch
Date: Mon, 11 May 2009 17:38:46 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A873958F7E3@dlee01.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A873958F6A4@dlee01.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D77FB192@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759948AbZEKWiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 18:38:52 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4BMcmZY014148
	for <linux-omap@vger.kernel.org>; Mon, 11 May 2009 17:38:53 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4BMclaS011001
	for <linux-omap@vger.kernel.org>; Mon, 11 May 2009 17:38:48 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n4BMclkX015895
	for <linux-omap@vger.kernel.org>; Mon, 11 May 2009 17:38:47 -0500 (CDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301D77FB192@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Sanjeev,

> > 1). What omap3430 board(s) are being using to validate the pm
> > branch functionality?
> 
> [sp] I believe most common are omap3evm and beagle.

Do you know if we are doing any validation on the SDP3430 or Zoom boards? 

Using defconfig for the SDP3430 the kernel failed to boot. I found that this was due to the MUSB driver and SmartReflex. Disabling these allows it to boot.

> > 2). Is there a list of pm features are currently
> > supported/functional for omap3430? For example, cpuidle,
> > cpufreq, retention, off-mode, smart-reflex, suspend/restore, etc.
> 
> [sp] All of above - though all drivers may not support power
>      management. Hence you may see some failures scenarios
>      esp. with off mode.

Off mode does not appear to be working currently on the SDP. It hangs when enabled. Is off-mode stable on any of the boards?

 
> > 3). Are there any userspace tools (such as powertop) that are
> > recommended for monitoring power states?
> 
> [sp] You can definitely use powertop.

Is this what everyone is using or is there any other diagnostics available through the proc or sys file-systems? Powertop is fine but I am curious how people are validating which c-states are being entered. 

Cheers
Jon
