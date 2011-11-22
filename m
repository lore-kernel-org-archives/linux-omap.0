From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 0/7] Introducing a generic AMP framework
Date: Tue, 22 Nov 2011 13:40:04 +0200
Message-ID: <CAK=WgbaF=yvGXvJdENrMoi4wWxaQa3UpbtsRm3mcA3cFdDCitA@mail.gmail.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com> <874nywpfkd.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <874nywpfkd.fsf@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 26, 2011 at 6:00 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Tue, 25 Oct 2011 11:48:19 +0200, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Modern SoCs typically employ a central symmetric multiprocessing (SMP)
>> application processor running Linux, with several other asymmetric
>> multiprocessing (AMP) heterogeneous processors running different instances
>> of operating system, whether Linux or any other flavor of real-time OS.
>
> OK, I'm not even sure who this should go through

We shortly discussed this in ELCE, and this can either go through the
arm-soc tree or directly to Linus; however Arnd prefers really.

The previous RFC iteration was reviewed quite extensively (especially
by Grant. thanks Grant!) but I was hoping to get some more review or
feedback on this iteration as well (any form of Acked-by, Reviewed-by,
+1-by or No-way-by are welcome).

At this point I know of at least four vendors (besides TI) who are
actively looking into supporting this, and it's getting a bit hard to
collaborate, so I plan to get this into linux-next later this week
(minus the virtio-spec.txt change which I'll send directly to you,
Rusty) in the hope of getting this merged into 3.3.

>, but no objections here

Can I add your Acked-by on the virtio parts (mainly patches 3 and 6) ?

Thanks!
Ohad.
