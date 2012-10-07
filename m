From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] cpufreq: OMAP: fixes for v3.7-rc2
Date: Sun, 07 Oct 2012 22:13:51 +0200
Message-ID: <1505601.8trb51fSMV@vostro.rjw.lan>
References: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:35227 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897Ab2JGUKX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Oct 2012 16:10:23 -0400
In-Reply-To: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Wednesday 03 of October 2012 16:00:25 Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
> 
> Here's a series with a couple bug fixes and a couple fixes that
> make this driver support newer OMAP-based SoCs.
> 
> The 'get_cpu_device' patch is needed due to a change in the OMAP
> OMAP PM core code which enforces use of get_cpu_device() instead of
> a deprecated OMAP-specific API.
> 
> The usage of plat/*.h headers breaks single zImage, so platforms are
> cleaning up and/or removing plat/*.h so the driver needs to be fixed
> accordingly.
> 
> This series is based on the merge of Rafael's pm-for-3.7-rc1 tag into
> Linus' master branch: commit 16642a2e7be23bbda013fc32d8f6c68982eab603.
> 
> Tested CPUfreq on OMAP platforms: 3430/n900, 3530/Overo,
> 3730/OveroSTORM, 3730/Beagle-XM, 4430/Panda.
> 
> Rafael, if you're OK with this series, I'll get a pull request
> ASAP so it can be included for v3.7-rc2.

The patches are fine by me, but there may be a bit of a timing issue with
them, because I'll be travelling between October 12 and October 21 inclusive
and I won't be pushing stuff to kernel.org during that time.

So I think it would be better to merge this material through the arm-soc tree,
if that's not a problem.  If you decide to do so, please feel free to add my
ACK to the patches.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
