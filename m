From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: 3.5-rc3: PM/DSS broken (was vdd_mpu_iva warnings)
Date: Tue, 3 Jul 2012 18:01:42 +0530
Message-ID: <CAJe_Zhfvf7t3Q1dJ98RhwBVDKCDH7AJdQWtY_LZd0bNLNWqT=Q@mail.gmail.com>
References: <WC20120618103957.6103F2@terrafix.co.uk>
	<87zk7h5096.fsf@ti.com>
	<WC20120703083759.980337@terrafix.co.uk>
	<4FF2B476.6000900@ti.com>
	<WC20120703091232.480345@terrafix.co.uk>
	<4FF2D089.8030507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54308 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab2GCMbn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 08:31:43 -0400
Received: by lbbgm6 with SMTP id gm6so9396050lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 03 Jul 2012 05:31:42 -0700 (PDT)
In-Reply-To: <4FF2D089.8030507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Kevin Hilman <khilman@ti.com>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

On 3 July 2012 16:29, Archit Taneja <a0393947@ti.com> wrote:
>
> I was going through Tomi's queue for the 3.6 merge window:
>
> git://gitorious.org/linux-omap-dss2/linux.git master
>
> There is a commit called:
>
> 2b8501d777346ce1d4fe99167e9b3c0e42aae7a8
>
> OMAPDSS: Use PM notifiers for system suspend
>
> The commit message mentions the issue you see, and seems to resolve it.
> Could you give this a try?
>
> Tomi is out on vacation, and I don't know why this wasn't intended for the
> 3.5-rcs, maybe there are still some discussion going on about this?
>
> Copping Jassi who was involved with this commit.
>
I understand, we settled on that patch finally.

>>>
>>> The error returned from the runtime_resume call is -ENOACCES, which by
>>> looking at the code, is returned by rpm_resume() when:
>>>
>>>         dev->power.disable_depth>  0
>>>
>>> I don't know what that means, does someone have any idea?
>>>
That is because during suspend PM on DISPC is disabled, so any attempt
to enable it reports ACCESS error. I suggested a mechanism, but Tomi
instead wanted to suspend early and resume late the panels via
notifiers to avoid that scenario.
