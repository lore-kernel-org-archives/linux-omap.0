From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix gpmc request_irq
Date: Fri, 18 May 2012 12:49:53 +0530
Message-ID: <CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
 <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:60017 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757238Ab2ERHUP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 03:20:15 -0400
Received: by qcsd16 with SMTP id d16so2119897qcs.0
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 00:20:13 -0700 (PDT)
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

On Fri, May 18, 2012 at 12:46 PM, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Santosh,
>
> On Fri, May 18, 2012 at 12:33:16, Shilimkar, Santosh wrote:
>> + Afzal who has been doing quite a bit of GMPC work recently.
>>
>> On Fri, May 18, 2012 at 10:13 AM, Ming Lei <ming.lei@canonical.com> wrote:
>> > The IRQ52 on OMAP2+ is not a shared interrupt line. If IRQF_SHARED
>> > is passed to request_irq and dev_id is set as NULL, request_irq will
>> > return -EINVAL.
>> >
>> GPMC IRQ line can shared between the multiple devices you
>> connect on it.
> :
>> Are you sure it fails ?
>> I just tried booting OMAP4 with 3.4-rc4 and don't see the irq
>> failure error message. What I am missing ?
>
> Issue happens on l-o master, this was mentioned in [1], now I feel
> right solution is to keep dev-id.
>
Thanks for the reference. removing SHARED flag is not solution and
yes, you might have to keep the dev-id if that was the issue.

Regards
Santosh
