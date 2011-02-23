From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Wed, 23 Feb 2011 11:45:17 +0200
Message-ID: <AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65350 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab1BWJpT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 04:45:19 -0500
Received: by wyg36 with SMTP id 36so649385wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 01:45:18 -0800 (PST)
In-Reply-To: <AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, Feb 23, 2011 at 3:17 AM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com> wrot=
e:
>> Add support to register an isr for IOMMU fault situations and adapt =
it
>> to allow such (*isr)() to be used as fault callback. Drivers using I=
OMMU
>> module might want to be informed when errors happen in order to debu=
g it
>> or react.
>>
>> Signed-off-by: David Cohen <dacohen@gmail.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/iommu2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 17 +++++++++-
>> =C2=A0arch/arm/plat-omap/include/plat/iommu.h | =C2=A0 14 ++++++++-
>> =C2=A0arch/arm/plat-omap/iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 52 ++++++++++++++++++++++---------
>> =C2=A03 files changed, 65 insertions(+), 18 deletions(-)
>>
> ....
>
>> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
>> =C2=A0}
>> =C2=A0EXPORT_SYMBOL_GPL(iommu_put);
>>
>> +int iommu_set_isr(const char *name,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*isr)=
(struct iommu *obj, u32 da, u32 iommu_errs,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *priv),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *isr_=
priv)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct device *dev;
>> + =C2=A0 =C2=A0 =C2=A0 struct iommu *obj;
>> +
>
> if the driver support multiple user for the same iommu why can only
> one callback be registered? should it support register multiple
> callback function (one per user)?

Can you define a scenario for that?
On OMAP3 ISP the multiple users are the multiple ISP submodule, but I
don't think it's necessary all submodule to have a specific callback.
ISP core layer should handle.

Br,

David

>
> Regards,
> Fernando.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
