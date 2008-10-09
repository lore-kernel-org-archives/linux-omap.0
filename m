From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH][omapzoom] BRIDGE Add preemption support to unprotected
 functions
Date: Thu, 09 Oct 2008 07:46:17 +0300 (EEST)
Message-ID: <20081009.074617.195054430.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A5344D13167@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58634 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbYJIEqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 00:46:25 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5344D13167@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x00omar@ti.com, h-kanigeri2@ti.com
Cc: vikram.pandita@ti.com, linux-omap@vger.kernel.org

Hi Omar and Hari,

From: "ext Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH][omapzoom] BRIDGE Add preemption support to unprotected functions
Date: Wed, 8 Oct 2008 17:07:15 -0500

> From: Hari Kanigeri <h-kanigeri2@ti.com>
> Date: Fri, 3 Oct 2008 12:20:45 -0500
> Subject: [PATCH] BRIDGE Add preemption support to unprotected functions
> 
> This patch protects the critical sections in bridge
> driver that otherwise might end in unexpected behavior.

Nice catch.

By the way, would it be possible to replace this "sync.c" with normal
in-kernel APIs like "mutex_lock()" and "wait_event()" families?

There's no point to have home brewed synchronization APIs, but it may
lose the readability of the code. If you need to add debug feature to
kernel synchronization mechanism, it should be done in generic APIs,
not in the driver specific code.

     Hiroshi DOYU


