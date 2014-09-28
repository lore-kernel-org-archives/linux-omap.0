From: nick <yocto6@gmail.com>
Subject: Legacy Code in gpmc-onenand.c
Date: Sat, 27 Sep 2014 22:37:02 -0400
Message-ID: <5427744E.4040409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:59793 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbaI1ChF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2014 22:37:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Greetings Kevin and others,
I am wondering if the below code is legacy I can remove it as stated it the fix me.
Cheers Nick 
else {
                /*
                * FIX ME: Appears to be legacy code from initial ONENAND commit.
                * Unclear what boards this is for and if this can be removed.
                 */
                if (!cpu_is_omap34xx())
                        onenand_sync.wait_on_read = true;
        }
