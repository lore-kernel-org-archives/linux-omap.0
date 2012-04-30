From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] Fix build breakage in omap-usb-host.c
Date: Mon, 30 Apr 2012 10:22:22 +0200
Message-ID: <20120430082222.GA31528@sortiz-mobl>
References: <1335084498-17918-1-git-send-email-Russ.Dill@ti.com>
 <CA+Bv8XbDZSsrF5NPXVE-zOWQ=NoZmWvtsoDTL42a70unFA8QFw@mail.gmail.com>
 <CAP05o4JQ2xFGMvqCY-V-=VVdLngofPR9QWB6r_m4BaoCHL02oQ@mail.gmail.com>
 <87ty0452ur.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32515 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab2D3IWZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 04:22:25 -0400
Content-Disposition: inline
In-Reply-To: <87ty0452ur.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, Russ Dill <Russ.Dill@ti.com>, Anatolij Gustschin <agust@denx.de>, linux-omap@vger.kernel.org

Hi Kevin,

On Fri, Apr 27, 2012 at 01:36:28PM -0700, Kevin Hilman wrote:
> Samuel,
> 
> "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
> 
> > On Sun, Apr 22, 2012 at 2:20 PM, Russ Dill <Russ.Dill@ti.com> wrote:
> >> On Sun, Apr 22, 2012 at 1:48 AM, Russ Dill <Russ.Dill@ti.com> wrote:
> >>> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' removes the include for
> >>> linux/gpio.h from omap-usb-host.c. This include indirectly includes plat/cpu.h
> >>> which is required by omap-usb-host.c. Fix the build breakage by including
> >>> it directly.
> >>
> >> (Sorry, I should add some detail, this is a build breakage in linux-next)
> >
> > Russ Dill and Anatolij Gustschin
> >
> > Both patches fixes the same issue; But here , I am seeing Russ Dill
> > has sent earlier (in my mailbox it shows 21 hours ago)
> > Here my ack by:
> >
> > Acked-by:  Keshava Munegowda <keshava_mgowda@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Can you pick this up for v3.4-rc5?  The breakage was introduced in
> v3.4-rc4.
I will, yes.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
