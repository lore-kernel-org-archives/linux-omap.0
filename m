From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to dev_dbg()
Date: Tue, 15 Feb 2011 16:01:35 +0200
Message-ID: <AANLkTi=TU95FgdiNBG8sdWbU3OJq9romUubTHzsRHs7G@mail.gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
	<AANLkTinQX59iyX1La=99Urgh5_JF0iZacBDqQz1VQfhi@mail.gmail.com>
	<4D5A85F4.5060103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53760 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab1BOOBh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 09:01:37 -0500
Received: by wwa36 with SMTP id 36so209490wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 06:01:35 -0800 (PST)
In-Reply-To: <4D5A85F4.5060103@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Hiroshi.DOYU@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 3:56 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> On 15-02-2011 16:44, David Cohen wrote:
>
>>>> IOMMU upper layer is already printing error message. OMAP2+ specif=
ic
>>>> layer may print error message only for debug purpose.
>
>>>> Signed-off-by: David Cohen<dacohen@gmail.com>
>>>> ---
>>>> =C2=A0arch/arm/mach-omap2/iommu2.c | =C2=A0 =C2=A06 +++---
>>>> =C2=A01 files changed, 3 insertions(+), 3 deletions(-)
>
>>>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/io=
mmu2.c
>>>> index 14ee686..4244a07 100644
>>>> --- a/arch/arm/mach-omap2/iommu2.c
>>>> +++ b/arch/arm/mach-omap2/iommu2.c
>>>> @@ -163,13 +163,13 @@ static u32 omap2_iommu_fault_isr(struct iomm=
u
>>>> *obj,
>>>> u32 *ra)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0da =3D iommu_read_reg(obj, MMU_FAULT_AD=
);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*ra =3D da;
>>>>
>>>> - =C2=A0 =C2=A0 =C2=A0 dev_err(obj->dev, "%s:\tda:%08x ", __func__=
, da);
>>>> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(obj->dev, "%s:\tda:%08x ", __func__=
, da);
>
>>> =C2=A0 Note that dev_dbg() will only print something if either DEBU=
G or
>>> CONFIG_DYNAMIC_DEBUG are defined...
>
>> That's my plan.
>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < ARRAY_SIZE(err_msg); =
i++) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stat& =C2=
=A0(1<< =C2=A0 =C2=A0i))
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 printk("%s ", err_msg[i]);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 printk(KERN_DEBUG "%s ", err_msg[i]);
>
>>> =C2=A0 ... unlike printk(KERN_DEBUG...). You probably want to use p=
r_debug()
>>> instead.
>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>> - =C2=A0 =C2=A0 =C2=A0 printk("\n");
>>>> + =C2=A0 =C2=A0 =C2=A0 printk(KERN_DEBUG "\n");
>
>>> =C2=A0 Here too... Although wait, it should be KERN_CONT instead! D=
ebug levels
>>> are only attributed to the whole lines.
>
>> But your observation is correct. I'll resend it with KERN_CONT inste=
ad.
>
> =C2=A0 This won't play out correctly anyway. If DEBUG is not #define'=
d, the
> beginning of line won't be printed but the continuations will. You ju=
st
> can't do it correctly with dev_dbg(), unless you break the single lin=
e into
> several ones.

Yes, I got this situation. I'm coming with a proper solution on next ve=
rsion.

Br,

David

>
>> Regards,
>
>> David
>
> WBR, Sergei
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
