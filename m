From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] Fix build breakage in omap-usb-host.c
Date: Mon, 23 Apr 2012 11:55:49 +0530
Message-ID: <CAP05o4JQ2xFGMvqCY-V-=VVdLngofPR9QWB6r_m4BaoCHL02oQ@mail.gmail.com>
References: <1335084498-17918-1-git-send-email-Russ.Dill@ti.com>
	<CA+Bv8XbDZSsrF5NPXVE-zOWQ=NoZmWvtsoDTL42a70unFA8QFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:47122 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751218Ab2DWGZv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 02:25:51 -0400
Received: by obbta14 with SMTP id ta14so17207586obb.33
        for <linux-omap@vger.kernel.org>; Sun, 22 Apr 2012 23:25:49 -0700 (PDT)
In-Reply-To: <CA+Bv8XbDZSsrF5NPXVE-zOWQ=NoZmWvtsoDTL42a70unFA8QFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>, Anatolij Gustschin <agust@denx.de>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Sun, Apr 22, 2012 at 2:20 PM, Russ Dill <Russ.Dill@ti.com> wrote:
> On Sun, Apr 22, 2012 at 1:48 AM, Russ Dill <Russ.Dill@ti.com> wrote:
>> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' removes the include for
>> linux/gpio.h from omap-usb-host.c. This include indirectly includes plat/cpu.h
>> which is required by omap-usb-host.c. Fix the build breakage by including
>> it directly.
>
> (Sorry, I should add some detail, this is a build breakage in linux-next)

Russ Dill and Anatolij Gustschin

Both patches fixes the same issue; But here , I am seeing Russ Dill
has sent earlier (in my mailbox it shows 21 hours ago)
Here my ack by:

Acked-by:  Keshava Munegowda <keshava_mgowda@ti.com>

Regards
Keshava
