From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4, panda: 3.11, dtb and wifi
Date: Fri, 13 Sep 2013 10:56:52 -0700
Message-ID: <20130913175651.GQ7189@atomide.com>
References: <20130913153602.GA17111@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37132 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab3IMR4y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 13:56:54 -0400
Content-Disposition: inline
In-Reply-To: <20130913153602.GA17111@luxor.wired.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: linux-omap@vger.kernel.org

* Paolo Pisati <p.pisati@gmail.com> [130913 08:43]:
> i know we switched to dtb-only booting, but what's happened to wifi?
> 
> 3.5.x:
> flag@flag-desktop:~$ ls -la /sys/bus/platform/devices/wl12xx/
> total 0
> drwxr-xr-x 5 root root    0 set 13 17:26 .
> drwxr-xr-x 4 root root    0 set 13 17:26 ..
> -rw-r--r-- 1 root root 4096 set 13 17:28 bt_coex_state
> lrwxrwxrwx 1 root root    0 set 13 17:27 driver -> ../../../../../../../../bus/platform/drivers/wl12xx_driver
> -r-------- 1 root root    0 set 13 17:28 fwlog
> -r--r--r-- 1 root root 4096 set 13 17:28 hw_pg_ver
> drwxr-xr-x 3 root root    0 set 13 17:27 ieee80211
> -r--r--r-- 1 root root 4096 set 13 17:28 modalias
> drwxr-xr-x 3 root root    0 set 13 17:27 net
> drwxr-xr-x 2 root root    0 set 13 17:28 power
> lrwxrwxrwx 1 root root    0 set 13 17:27 subsystem -> ../../../../../../../../bus/platform
> -rw-r--r-- 1 root root 4096 set 13 17:26 uevent
> 
> 3.11.x:
> flag@flag-desktop:~$ ls -la /sys/bus/platform/devices/wl*
> ls: cannot access /sys/bus/platform/devices/wl*: No such file or directory

Hmm it seems we're still missing the .dts entries. I'll post
two patches shortly, one for panda and one for 4430sdp.

Regards,

Tony
