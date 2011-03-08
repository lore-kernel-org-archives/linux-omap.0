From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v8 6/7] omap3430: Updating the board file to use TWL4030 scripts
Date: Tue, 8 Mar 2011 12:31:32 +0530
Message-ID: <AANLkTikp=1k40eOAcLJoxUeNVHdkH1=X9_DhOSBM+JY2@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
	<1299072653-13414-7-git-send-email-leslyam@ti.com>
	<87sjuy67l3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46630 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751314Ab1CHHBe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 02:01:34 -0500
Received: by vws13 with SMTP id 13so5073776vws.28
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 23:01:32 -0800 (PST)
In-Reply-To: <87sjuy67l3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Tue, Mar 8, 2011 at 1:12 AM, Kevin Hilman <khilman@ti.com> wrote:
> Lesly A M <leslyam@ti.com> writes:
>
>> Using TWL4030 power scripts to control the LDOs and DCDC regulators
>> while going to low power mode.
>>
>> Signed-off-by: Lesly A M <leslyam@ti.com>
>
> Minor: Re: Subject: OMAP is an acronym, please capitalize.
Ok

>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: David Derrick <dderrick@ti.com>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0| =A0 =A03 +-
>> =A0arch/arm/mach-omap2/board-3430sdp.c | =A0 93 +-------------------=
---------------
>> =A02 files changed, 4 insertions(+), 92 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 742ca67..bb11329 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -175,7 +175,8 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA) =A0+=3D board-o=
map3pandora.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0hsmmc.o
>> =A0obj-$(CONFIG_MACH_OMAP_3430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D b=
oard-3430sdp.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0hsmmc.o \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0board-flash.o
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0board-flash.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0twl4030.o
>
> This should not be board-specific in the Makefile, otherwise it will
> have to be added for every single board that uses it.
>
> Rather, it should probably be built as long as CONFIG_TWL4030_POWER=3D=
y.
> Also, please be sure to build test when that option is disabled as we=
ll.
Ok, I will make the changes as mentioned in next thread ...

Thanks & Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
