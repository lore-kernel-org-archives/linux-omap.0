From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Tue, 22 Feb 2011 01:48:23 +0200
Message-ID: <AANLkTi=ZY_GidTi8b1HGn342H3Us3r0bYNY2Qto7LTjq@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikbjZ7GH7+bx94r6saYuGzCt9aito-Y8NS94SoQ@mail.gmail.com>
	<AANLkTi=rJZo2KwryYznFp6Qq25Oh0+F44OKV-khuQyte@mail.gmail.com>
	<AANLkTi=ETUza9vYLxucB4hs-7x9+tDTY8mxUPziWvnig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40146 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab1BUXsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 18:48:25 -0500
Received: by wyb38 with SMTP id 38so1699854wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 15:48:24 -0800 (PST)
In-Reply-To: <AANLkTi=ETUza9vYLxucB4hs-7x9+tDTY8mxUPziWvnig@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Felipe Balbi <balbi@ti.com>

On Tue, Feb 22, 2011 at 1:25 AM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> Hi,
>
> On Mon, Feb 21, 2011 at 3:12 PM, David Cohen <dacohen@gmail.com> wrot=
e:
>> Generic errors codes make easier to threat possible IOMMU users whic=
h
>> have (partially or totally) common drivers for different OMAP
>> versions.
>
> Agree then.

Good we agreed on that.

>
>>>> + =C2=A0 =C2=A0 =C2=A0 /* Fault callback or TLB/PTE Dynamic loadin=
g */
>>>> + =C2=A0 =C2=A0 =C2=A0 if (obj->isr && !obj->isr(obj, da, errs, ob=
j->isr_priv))
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_=
HANDLED;
>>>
>>> BTW, why not changing the name isr for cb, it is confusing since th=
ere
>>> is another fault_isr called by mmu, AFAIK nobody uses obj->isr
>>
>> The main purpose of this function is to be an ISR, not only callback=
=2E
>
> Yep, I just thought it was a bit too much of:
> (1) The real isr: iommu_fault_handler, set on request_irq
> (2) A plugged fault_isr for mach specific code: omap2_iommu_fault_isr=
,
> for error reporting.
> (3) And then a plugged custom isr, to be set by the user.
>
> Feel free to ignore.

(1) does nothing but to call (2) and then (3) if it exists and print
error message.
(2) as you said, it's mach specific and necessary for the generic upper=
 layer.
(3) does what the IOMMU user wants and may replace (1) if it returns 0.

They belong to different layers and should coexist.

>
>>> So I think the following will be bad practice:
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmu =3D iommu_get("iva2");
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ERR(mmu))
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmu->isr =3D=
 mmu_fault_callback;
>>>
>>> Shall we think anything to prevent such mis-usage?
>>
>> Well, the IOMMU user has access to IOMMU obj, so it can not only
>> change the (*isr)() but to mess with a lot of other stuff. The only
>> way to prevent it is to avoid user to have obj. But then, this fix (=
or
>> issue) does not belong to this patch.
>
> Agree, just pointing out.

That's a valid point, but it requires an intrusive approach to prevent
such mis-usage. For now we must trust the user won't mess with obj.

Br,

David

>
> Regards,
>
> Omar
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
