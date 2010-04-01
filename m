From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH] OMAP GPTimer for OProfile(Errata#628216)
Date: Thu, 1 Apr 2010 18:32:14 +0300
Message-ID: <201004011832.14879.siarhei.siamashka@nokia.com>
References: <1270135448-11604-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64757 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697Ab0DAPgn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 11:36:43 -0400
In-Reply-To: <1270135448-11604-1-git-send-email-manjugk@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Manjunatha GK <manjugk@ti.com>, "Koskinen Aaro (Nokia-D/Helsinki)" <aaro.koskinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Thursday 01 April 2010 18:24:08 ext Manjunatha GK wrote:
> From: DebBarma, Tarun Kanti <tarun.kanti@ti.com>
>
> [ARM Cortex-A8 Errata 628216]
> If a Perf Counter OVFL occurs simultaneously with an update to a CP14 or
> CP15 register, the OVFL status can be lost.
>
> In order to workaround problem in Cortex-A8 Performance Counter, OMAP
> GPTIMER is used by OProfile.

Thanks for digging this up. But even though GPTIMER has a lower overhead,
there is actually a better (more portable) fix which is on the way into
mainline kernel:
http://marc.info/?l=oprofile-list&m=126754919315010&w=2

Samples collection frequency can be adjusted by another patch (the default
128Hz used on most ARM boards/devices is way too low).

oprofile kernel module can be loaded with 'timer=1' parameter to override
the use of buggy Cortex-A8 PMU.

-- 
Best regards,
Siarhei Siamashka
