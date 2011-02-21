From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Mon, 21 Feb 2011 17:25:56 -0600
Message-ID: <AANLkTi=ETUza9vYLxucB4hs-7x9+tDTY8mxUPziWvnig@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikbjZ7GH7+bx94r6saYuGzCt9aito-Y8NS94SoQ@mail.gmail.com>
	<AANLkTi=rJZo2KwryYznFp6Qq25Oh0+F44OKV-khuQyte@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40535 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750777Ab1BUX0B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 18:26:01 -0500
Received: by mail-yw0-f45.google.com with SMTP id 41so773919ywl.18
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 15:25:56 -0800 (PST)
In-Reply-To: <AANLkTi=rJZo2KwryYznFp6Qq25Oh0+F44OKV-khuQyte@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Felipe Balbi <balbi@ti.com>

Hi,

On Mon, Feb 21, 2011 at 3:12 PM, David Cohen <dacohen@gmail.com> wrote:
> Generic errors codes make easier to threat possible IOMMU users which
> have (partially or totally) common drivers for different OMAP
> versions.

Agree then.

>>> + =A0 =A0 =A0 /* Fault callback or TLB/PTE Dynamic loading */
>>> + =A0 =A0 =A0 if (obj->isr && !obj->isr(obj, da, errs, obj->isr_pri=
v))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_HANDLED;
>>
>> BTW, why not changing the name isr for cb, it is confusing since the=
re
>> is another fault_isr called by mmu, AFAIK nobody uses obj->isr
>
> The main purpose of this function is to be an ISR, not only callback.

Yep, I just thought it was a bit too much of:
(1) The real isr: iommu_fault_handler, set on request_irq
(2) A plugged fault_isr for mach specific code: omap2_iommu_fault_isr,
for error reporting.
(3) And then a plugged custom isr, to be set by the user.

=46eel free to ignore.

>> So I think the following will be bad practice:
>>
>> =A0 =A0 =A0 =A0mmu =3D iommu_get("iva2");
>> =A0 =A0 =A0 =A0if (!IS_ERR(mmu))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmu->isr =3D mmu_fault_callback;
>>
>> Shall we think anything to prevent such mis-usage?
>
> Well, the IOMMU user has access to IOMMU obj, so it can not only
> change the (*isr)() but to mess with a lot of other stuff. The only
> way to prevent it is to avoid user to have obj. But then, this fix (o=
r
> issue) does not belong to this patch.

Agree, just pointing out.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
