From: "Vutla, Lokesh" <lokeshvutla@ti.com>
Subject: Re: [PATCH 3/4] ARM: OMAP: Move omap_reserve() locally to mach-omap1/2
Date: Mon, 1 Oct 2012 10:31:28 +0530
Message-ID: <CAJ1gdcZORu+bAS4m16y948znKOo1Bon3bb5VDHh=tR8ULq2_AA@mail.gmail.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
 <1348839609-10456-4-git-send-email-lokeshvutla@ti.com> <20120929193944.GB15246@n2100.arm.linux.org.uk>
 <CAMQu2gxN=gW_Gxr4awuJ4VT6RkZi_qHiTvmjwqbLKvCqb4RoyQ@mail.gmail.com> <20120930180542.GF4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:51029 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738Ab2JAFBu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 01:01:50 -0400
Received: by vbbff1 with SMTP id ff1so4957483vbb.19
        for <linux-omap@vger.kernel.org>; Sun, 30 Sep 2012 22:01:49 -0700 (PDT)
In-Reply-To: <20120930180542.GF4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Sun, Sep 30, 2012 at 11:35 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120930 01:21]:
>> On Sun, Sep 30, 2012 at 1:09 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> >
>> > On Fri, Sep 28, 2012 at 07:10:08PM +0530, Lokesh Vutla wrote:
>> > > omap_reserve() is a stub for omap1. So creating a
>> > > stub locally in mach-omap1. And moving the definition
>> > > to mach-omap2.
>> > > This helps in moving plat/omap_secure.h local to
>> > > mach-omap2
>> > >
>> > > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> > > Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > > ---
>> > >  arch/arm/mach-omap1/common.h             |    3 +++
>> > >  arch/arm/mach-omap2/common.c             |   20 ++++++++++++++++++++
>> > >  arch/arm/mach-omap2/common.h             |    1 +
>> > >  arch/arm/plat-omap/common.c              |   17 -----------------
>> > >  arch/arm/plat-omap/include/plat/common.h |    1 -
>> > >  5 files changed, 24 insertions(+), 18 deletions(-)
>> > >
>> > > diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
>> > > index c2552b2..f7b01f1 100644
>> > > --- a/arch/arm/mach-omap1/common.h
>> > > +++ b/arch/arm/mach-omap1/common.h
>> > > @@ -90,4 +90,7 @@ extern int ocpi_enable(void);
>> > >  static inline int ocpi_enable(void) { return 0; }
>> > >  #endif
>> > >
>> > > +static inline void omap_reserve(void)
>> > > +{ }
>> >
>> > This is the wrong approach.  If OMAP1 doesn't need to do any reservation,
>> > then OMAP1 platforms should not be calling omap_reserve() and OMAP1 should
>> > not have this defined.
>> >
>> > Just because OMAP2 does something one way does not mean OMAP1 needs to
>> > copy it in every detail.
>>
>> This patch just updated the code as is. I mean the empty  reserve
>> callback already
>> exist before this patch.
>>
>> But I do agree with you. I think we can drop the reserve callback completly from
>> OMAP1 board files and then its easier to just make the omap_reserve() local to
>> OMAP2+ machines.
>>
>> Tony,
>> Are you ok in dropping OMAP1 reserve callback from all OMAP1 machines ?
>
> Sure if it's not doing anything.
Ok, Ill drop omap_reserve() callback from all OMAP1 machines and
repost the patches..

Thanks
Lokesh
>
> Regards,
>
> Tony
