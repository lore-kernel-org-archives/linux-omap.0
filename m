From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Thu, 28 Jul 2011 10:40:48 +0200
Message-ID: <CAORVsuXsZXU+rH7ujYJuYDvYjWkCVnZrvkkinFPd9DEBYtdduQ@mail.gmail.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-4-git-send-email-khilman@ti.com>
	<20110722085716.GI32058@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53891 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab1G1Ikt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 04:40:49 -0400
Received: by qyk29 with SMTP id 29so2613302qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 01:40:48 -0700 (PDT)
In-Reply-To: <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi,

On Fri, Jul 22, 2011 at 10:57 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Jul 21, 2011 at 04:52:13PM -0700, Kevin Hilman wrote:
>> Board code should not touch omap_device internals. =A0To get the MPU=
/IVA devices,
>> use existing APIs: omap2_get_mpu_device(), omap2_get_iva_device().
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 23 ++++++++++------=
-------
>> =A01 files changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach=
-omap2/board-omap3beagle.c
>> index 32f5f89..3ae16b4 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -491,23 +491,22 @@ static void __init beagle_opp_init(void)
>>
>> =A0 =A0 =A0 /* Custom OPP enabled for all xM versions */
>> =A0 =A0 =A0 if (cpu_is_omap3630()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct omap_hwmod *mh =3D omap_hwmod_looku=
p("mpu");
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct omap_hwmod *dh =3D omap_hwmod_looku=
p("iva");
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct device *dev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct device *mpu_dev, *iva_dev;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!mh || !dh) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mpu_dev =3D omap2_get_mpuss_device();
>> + =A0 =A0 =A0 =A0 =A0 =A0 iva_dev =3D omap2_get_iva_device();
>
> out of curiosity again, nothing to do with this patch.
>
> Maybe it would be nicer to have an api such as:
>
> omap2_get_device(name);
>
> there are already four devices to be gotten, if that number grows any
> bigger, so will the number of helper functions.

I agree with this.
The API is also helpful for the PM QoS devices constraints API, which
requires the pointers to devices structs. At the present time only a
few devices can be used and it would be good to have a generic
implementation.

Regards,
Jean

>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
