From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC PATCH 00/18] OMAP: GPIO: cleanup GPIO driver
Date: Mon, 25 Apr 2011 19:33:51 +0530
Message-ID: <BANLkTikUyA-TrFTqKEuxJ2rEcCK5H7w_Uw@mail.gmail.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com> <87oc3xvrt6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56349 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758411Ab1DYOEf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Apr 2011 10:04:35 -0400
Received: by mail-iy0-f182.google.com with SMTP id 12so2536060iyj.41
        for <linux-omap@vger.kernel.org>; Mon, 25 Apr 2011 07:04:31 -0700 (PDT)
In-Reply-To: <87oc3xvrt6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com

Kevin,

Thanks for your comments.

On Sat, Apr 23, 2011 at 04:04, Kevin Hilman <khilman@ti.com> wrote:
> Hi Charu,
>
> Charulatha V <charu@ti.com> writes:
>
>> Modifies the OMAP GPIO driver to avoid usage of cpu_is* checks
>> for different OMAP architectures. This is done by moving some
>> architecture specific code to mach-omap* and call them from
>> plat-omap* using function pointers. Also remove the register offset
>> macros from OMAP GPIO driver and handle the same in mach-omap*.
>
> Thanks for working on this cleanup, this driver really needs a cleanu=
p.
>
> You've hit on all the main areas for cleanup, but unfortunately, it's
> not really going in the direction I was hoping. =A0Rather than moving=
 code
> into the SoC specific parts, I was hoping to generalize the driver su=
ch
> that SoC-specific code would just pass in register offsets/options in=
to
> the common driver. =A0Your current approach isn't really reducing cod=
e,
> it's just moving it around.
>
> I had started on a similar cleanup as well, and will post that series
> shortly to demonstrate the direction I think the cleanups should be
> going. =A0I've tackled most of the same functions/areas that you have
> (except the IRQ triggering stuff), but have a rather different approa=
ch.
> I'll get to the IRQ triggering stuff next (after going on vacation fo=
r a
> week), but feel free to build on top of my series if you like.

Sure. I will wait for your series.

-V Charulatha

>
> The direction I'd like to go is towards having a generalized driver t=
hat
> can not only work across all OMAP SoCs, but also hopefully towards
> something that can be shared with other SoCs as well. =A0Of course, t=
he
> first step is cleaning up the OMAP driver, but the next step will be
> looking for other areas of consolidation. =A0Towards that end, I'm al=
so
> working towards converting the GPIO IRQs in this driver to use the ne=
w
> generic IRQ chip infrastructure posted by Thomas Gleixner. =A0In my
> series, you'll see that I started that for the MPUIO IRQs, but the GP=
IO
> IRQs will come next.
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
