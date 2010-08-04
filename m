From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: PM branch updated to v2.6.35, SRF dropped
Date: Wed, 04 Aug 2010 15:50:47 -0700
Message-ID: <8739uu9em0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:58249 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757714Ab0HDWuu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 18:50:50 -0400
Received: by pxi14 with SMTP id 14so2239792pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Aug 2010 15:50:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

It's been a while since a PM branch update, thanks to a nice summer
vacation for me. :)

The PM branch has now been updated to v2.6.35 plus Tony's for-next
branch.  

This is mostly a rebase, but the most important change is that I'm
finally dropping SRF as promised[1].  The new DVFS infrastructure is now
in the RFC/PATCH phase so I'm no longer going to keep dragging SRF
along.  Note that this means that ***DVFS no longer works in the PM branch***. 
If this bothers you, then please consider helping review and test the
new DVFS infrastructure recently posted by Thara so we can get the new,
upstream-ready DVFS code upstream ASAP.

I've only tested the new PM branch on a couple boards to avoid any
further delay getting this version out, update, so hopefully others will
help test.

I've tested RET on idle & suspend, OFF in idle & suspend on:

3430/omap3evm: works

3630/Zoom3: works
- Known problem: console hangs on UART wakeup when  wakeups are enabled using
  echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
  but I haven't debugged this further.

Kevin


[1] http://marc.info/?l=linux-omap&m=127206504624556&w=2
