From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM address space.
Date: Wed, 9 May 2012 18:00:10 +0530
Message-ID: <CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508124116.GE17798@arm.com> <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
 <20120508215554.GA18980@n2100.arm.linux.org.uk> <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
 <20120509122348.GA30632@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:50756 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757155Ab2EIMac convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 08:30:32 -0400
Received: by qcsd16 with SMTP id d16so166643qcs.14
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 05:30:31 -0700 (PDT)
In-Reply-To: <20120509122348.GA30632@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Wed, May 9, 2012 at 5:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, May 09, 2012 at 02:20:28PM +0530, Shilimkar, Santosh wrote:
>> The only change done common code is =A0clearing 'XN' bit for DRAM
>> region in page table entries. The other change of setting the DACR
>> register is done in ARMv7 specific code.
>
> Yes, XN is an ARMv6+ thing. =A0Before ARMv5, it was implementation de=
fined.
>
> Some implementations used the bit to mean "allow writes to update the
> cache". =A0Other implementations labelled this bit as "should be zero=
"
> while others labelled it as "should be one".
>
Good to know.

> The upshot of this is, we know that having this bit as '1' means that
> all the CPUs we support today work. =A0I would be _very_ concerned to
> change this bit to zero as we _really_ don't know how the pre-ARMv6
> CPUs would react.
>
I agree.

> The solution to this is pretty simple - if ARMv6+ needs a different
> base section mapping value, then we need to extract that from the cod=
e
> and pass in the base section mapping value.
>
> I'll sort out a patch later today for this.
Great.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
