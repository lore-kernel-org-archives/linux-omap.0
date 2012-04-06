From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [rtc-linux] [PATCH] RTC: twl6030: correct usage of static
 register while reading time
Date: Fri, 6 Apr 2012 12:19:34 -0700
Message-ID: <20120406121934.0d6d3ffc.akpm@linux-foundation.org>
References: <1332970441-3495-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36743 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab2DFTTg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 15:19:36 -0400
In-Reply-To: <1332970441-3495-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: Nishanth Menon <nm@ti.com>, Konstantin Shlyakhovoy <x0155534@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, 28 Mar 2012 16:34:01 -0500
Nishanth Menon <nm@ti.com> wrote:

> From: Konstantin Shlyakhovoy <x0155534@ti.com>
> 
> RTC stores time and date in several registers. Due to the fact that
> these registers can't be read instantaneously, there is a chance
> that reading from counting registers gives an error of one minute,
> one hour, one day, etc.
> 
> To address this issue, the RTC has hardware support to copy the
> RTC counting registers to static shadowed registers.
> The current implementation does not use this feature, and in a
> stress test,  we can reproduce this error at a rate of around
> two times per 300000 readings.
> 
> Fix the implementation to ensure that the right snapshot of time
> is captured.

hey, nice changelog!

Please cc me on rtc patches - I tend to be a bit slow reading the
rtc-linux list.

> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: linux-omap <linux-omap@vger.kernel.org>
> Acked-by: Mykola Oleksiienko <x0174904@ti.com>
> Acked-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
> Acked-by: Graeme Gregory <gg@slimlogic.co.uk>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Konstantin Shlyakhovoy <x0155534@ti.com>

I rewrote your acked-by to Signed-off-by, because you were on the
delivery path of the patch. Documentation/SubmittingPatches has details.

Is this OK?

