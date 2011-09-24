From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 3/6] OMAP4460: Temperature sensor data
Date: Sat, 24 Sep 2011 14:32:18 +0530
Message-ID: <CAJ6a13ZODj3KO2fst2kMrcTTr2ND3c1LqctvUEkVDLDrMXZy-A@mail.gmail.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
	<1316705361-12175-4-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1109222319210.10719@utopia.booyaka.com>
	<CAJ6a13bKycJYKa9CG8sgPr8PMO62RYZJ=_UD3ZfjoYQm4GbN0A@mail.gmail.com>
	<alpine.DEB.2.00.1109240148180.22872@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48272 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751031Ab1IXJCU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 05:02:20 -0400
Received: by mail-fx0-f41.google.com with SMTP id 17so5138207fxh.0
        for <linux-omap@vger.kernel.org>; Sat, 24 Sep 2011 02:02:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109240148180.22872@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Sat, Sep 24, 2011 at 1:29 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Fri, 23 Sep 2011, J, KEERTHY wrote:
>
>> On Fri, Sep 23, 2011 at 11:33 AM, Paul Walmsley <paul@pwsan.com> wro=
te:
>>
>> > On Thu, 22 Sep 2011, Keerthy wrote:
>> >
>> >> diff --git a/arch/arm/mach-omap2/temp_sensor4460_data.c b/arch/ar=
m/mach-omap2/temp_sensor4460_data.c
>> >> new file mode 100644
>> >> index 0000000..2804615
>> >> --- /dev/null
>> >> +++ b/arch/arm/mach-omap2/temp_sensor4460_data.c
>> >
>> > Is there some reason why this shouldn't go into drivers/ in some f=
orm?
>>
>> This is used by mach-omap2.
>
> Why does something in mach-omap2 need this data?

The scm hwmod is populating the pointer to the register set which is
specific to OMAP4460.
So i have kept the OMAP4460 specific data file in mach-omap2.

>
>> >> diff --git a/arch/arm/plat-omap/include/plat/scm.h b/arch/arm/pla=
t-omap/include/plat/scm.h
>> >> new file mode 100644
>> >> index 0000000..47aa38f
>> >> --- /dev/null
>> >> +++ b/arch/arm/plat-omap/include/plat/scm.h
>> >
>> > If this is being used by a driver, then this header file should go=
 into
>> > the appropriate drivers/ subdirectory. =A0If it is being used by c=
ode in
>> > arch/arm/mach-omap2, then please use the existing
>> > arch/arm/mach-omap2/control.h instead.
>>
>> The header file has structures used both by drivers/ and mach-omap.
>> So kept it in plat-omap.
>
> The point is, if there are structure definitions and macros that are
> only needed by code in drivers/, then those should be split off into =
a
> separate file and placed in drivers/. =A0Similarly, if there are elem=
ents of
> this file that are only used in mach-omap2/, then those should go int=
o
> mach-omap2/control.h.
>
> About the only part off the top of my head that should go into a
> plat-omap header file should be the dev_attr structure. =A0And it's
> debatable whether this driver even needs a dev_attr, or whether all
> this data should just go into an omap4460_scm.c MFD driver that uses
> a bunch of common code for the parts that are shared with 4430, etc.
> Do you have any views on this issue?

There can be a common omap4_scm.c driver. The temperature sensor
is different from OMAP4430 and OMAP4460. So keeping the temperature
sensor as omap4460plus.

Coming to structure definitions. pdata structure is needed both by mach=
-omap
device file to populate it and also by the driver t extract it. So
keeping all of the
structure definitions in one header file in plat_omap. My question is w=
hich
is the ideal place to keep the common structure definition like pdata?

Since the temperature sensor does not have a separate hwmod of its own
i feel there is a necessity of dev_attr.

>
>
> - Paul



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
