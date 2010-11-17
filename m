From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: RFC: hwmod, iclks, auto-idle and autodeps
Date: Wed, 17 Nov 2010 14:08:29 -0800
Message-ID: <87ipzv38o2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40563 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934863Ab0KQWIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 17:08:34 -0500
Received: by iwn35 with SMTP id 35so2638262iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Nov 2010 14:08:34 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Partha Basak <p-basak2@ti.com>, Charulatha Varadarajan <charu@ti.com>
Cc: linux-omap@vger.kernel.org

Hello,

There have been a few discussions over the few months about how to
properly use omap_hwmod to manage certain IPs that have the interface
clock as the functional clock (e.g. OMAP3 GPIOs.)  The goal of this RFC
is to come to a conclusion about what should be done, and how to go
about implementing it.

In the initial conversion of the GPIO core to omap_hwmod, main_clk was
left NULL so that hwmod was not managing the clock on every hwmod
enable/disable.  This behavior matched current mainline GPIO code, which
does not dynamically disable/enable GPIO iclks after init time.
Instead, it relies on the module-level auto idle feature in HW.

However, without dynamically managing the clock in hwmod, this meant
that there were no autodeps tracked for GPIO and thus the PER
powerdomain could transition independently of MPU/CORE.

The initial solution to this was to set the iclk to be the main_clk of
the hwmod, such that autodeps were managed dynamically as well.  This
led to a change in functionality in current code, since the iclk was now
being manually enabled/disabled at runtime instead of being left for HW
to manage by module autoidle.  It also led to problems in correctly
handling asynchronous GPIO wakeups.

In some off-list discussions, one proposal to address this was to change
the omap_hwmod core to check the module autoidle before disabling the
clock.  If the module autoidle is enabled, then hwmod would not directly
manage the clock during hwmod_enable/disable.

The question is: is this an acceptable solution?  the clock framework
currently has no knowledge of module auto-idle, where the hwmod core
does, so it seems hwmod is (currently) the best place to handle this.

Alternatively, would it make sense to do something different with
autodeps, such that modules like this that don't have a separate
functional clock still have autodeps handled, possibly by using an
optional clock?

Does extending autodeps make sense since, IIUC, we won't really need
them after all devices are using hwmod?

Anyways... this is to get the discussion going so we can come to a
conclusion on this matter and finialize the hwmod conversions for some
of these "special" IPs.

Thanks,

Kevin
