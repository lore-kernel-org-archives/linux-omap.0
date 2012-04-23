From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] Fix build breakage in omap-usb-host.c
Date: Mon, 23 Apr 2012 20:49:29 +0200
Message-ID: <20120423204929.40e5b9bb@wker>
References: <1335084498-17918-1-git-send-email-Russ.Dill@ti.com>
	<CA+Bv8XbDZSsrF5NPXVE-zOWQ=NoZmWvtsoDTL42a70unFA8QFw@mail.gmail.com>
	<CAP05o4JQ2xFGMvqCY-V-=VVdLngofPR9QWB6r_m4BaoCHL02oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:53821 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602Ab2DWStn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 14:49:43 -0400
In-Reply-To: <CAP05o4JQ2xFGMvqCY-V-=VVdLngofPR9QWB6r_m4BaoCHL02oQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Mon, 23 Apr 2012 11:55:49 +0530
"Munegowda, Keshava" <keshava_mgowda@ti.com> wrote:

> On Sun, Apr 22, 2012 at 2:20 PM, Russ Dill <Russ.Dill@ti.com> wrote:
> > On Sun, Apr 22, 2012 at 1:48 AM, Russ Dill <Russ.Dill@ti.com> wrote:
> >> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' removes the include for
> >> linux/gpio.h from omap-usb-host.c. This include indirectly includes plat/cpu.h
> >> which is required by omap-usb-host.c. Fix the build breakage by including
> >> it directly.
> >
> > (Sorry, I should add some detail, this is a build breakage in linux-next)
> 
> Russ Dill and Anatolij Gustschin
> 
> Both patches fixes the same issue; But here , I am seeing Russ Dill
> has sent earlier (in my mailbox it shows 21 hours ago)

Great! I'm not on linux-omap list and didn't see this patch unfortunately.
Sure, the patch from Russ Dill should be applied.

Thanks,
Anatolij
