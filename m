Return-Path: <SRS0=0/1+=6A=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496ABC2BA2B
	for <linux-omap@archiver.kernel.org>; Thu, 16 Apr 2020 20:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EF4E206A2
	for <linux-omap@archiver.kernel.org>; Thu, 16 Apr 2020 20:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgDPUau (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:30:50 -0400
Received: from muru.com ([72.249.23.125]:49840 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgDPUau (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 16 Apr 2020 16:30:50 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 41409804F
        for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2020 20:31:37 +0000 (UTC)
Date:   Thu, 16 Apr 2020 13:30:45 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Subject: Important PM change for omap folks in v5.7-rc1
Message-ID: <20200416203045.GJ37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

FYI, starting with v5.7-rc1, kernel serial console now must be detached
for the UARTs to idle. This has changed starting with commit a3cb39d258ef
("serial: core: Allow detach and attach serial device for console").

So folks may want to run something similar to the following on boot to
detach serial console and idle the UARTs for PM.

Regards,

Tony

8< -------------
#!/bin/sh

# Detach kernel serial console
consoles=$(find /sys/bus/platform/devices/4*.serial/ -name console)
for console in ${consoles}; do
	echo N > ${console}
done

# Configure PM runtime autosuspend
uarts=$(find /sys/bus/platform/devices/4*.serial/power/ -type d)
for uart in ${uarts}; do
	echo 1500 > ${uart}/autosuspend_delay_ms
	echo enabled > ${uart}/wakeup
	echo auto > ${uart}/control
done

# Configure wake-up from suspend
uarts=$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
for uart in ${uarts}; do
	echo enabled > ${uart}/wakeup
done

# Enable off mode during idle if supported
echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
