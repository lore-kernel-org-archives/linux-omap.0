From: Kevin Hilman <khilman@ti.com>
Subject: hwmod, postsetup_state, omap_device and !CONFIG_PM_RUNTIME
Date: Tue, 12 Jul 2011 16:51:22 -0700
Message-ID: <87bowzrrb9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:55636 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203Ab1GLXv1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 19:51:27 -0400
Received: by iym1 with SMTP id 1so10673865iym.1
        for <linux-omap@vger.kernel.org>; Tue, 12 Jul 2011 16:51:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

With CONFIG_PM_RUNTIME disabled, we have a few problems due to the
current way of handling the postsetup_state of each hwmod.

The primary one is that the omap_hwmod internal startup state does not
match the omap_device internal state.  For example, with
!CONFIG_PM_RUNTIME, all the hwmods are left enabled (and the bootup
state is OMAP_HWMOD_STATE_ENABLED.)

However, omap_device doesn't know this, so the first call
omap_device_enable() will generate the noisy warnings:

omap_device_enable()
    /* Here, the omap_device default state is 0x0: UNKNOWN */
    deactivate_func -> omap_device_enable_hwmods()
        omap_hwmod_enable()
            /* WARN is hit since state is already enabled */           


A second one is where device init code is directly calling
omap_hwmod_enable()  (e.g. in omap_dm_timer_init_one()).  This code has
no way of knowing that the device was left enabled due to the
postsetup_state, so calls like this to omap_hwmod_* fail with the noisy
warnings from the hwmod core.

I haven't dug too much into how to handle this, but wanted to post this
to see if anyone has any good ideas about how to handle it.

Kevin

