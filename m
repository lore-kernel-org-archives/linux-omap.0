From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v7 0/8] omap3: pm: TWL4030 power scripts and workaround
 for TWL errata 27
Date: Wed, 2 Mar 2011 11:27:16 +0530
Message-ID: <AANLkTim71_zV-QgQKA-L6sJG2Yz_pZF8rxEmKK70OO+0@mail.gmail.com>
References: <1298723139-1693-1-git-send-email-leslyam@ti.com>
	<87vd02fp61.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:50306 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751570Ab1CBF5R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 00:57:17 -0500
Received: by mail-vw0-f51.google.com with SMTP id 18so5101615vws.38
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 21:57:16 -0800 (PST)
In-Reply-To: <87vd02fp61.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Wed, Mar 2, 2011 at 4:01 AM, Kevin Hilman <khilman@ti.com> wrote:
> Lesly A M <leslyam@ti.com> writes:
>
>> Patch series for TWL4030 power scripts and workaround for TWL errata=
 27.
>>
>> Changes for implementing TWL4030 power scripts recommended by hardwa=
re team.
>> Introduced a new TWL4030 power script file, which can be used by dif=
ferent
>> OMAP3 board with the power companion chip TWL4030.
>>
>> Updated the changes for TWL4030 errata 27 & 28, and modified the
>> TWL4030 power script.
>> Workaround for TWL4030 errata 27 & 28 is required for
>> Si version less than or equal to TWL5030 ES1.1.
>>
>> TWL4030 script changes rebased on Kevin's PM tree in pm branch.
>>
>> Changes in v7:
>
>> =A0 =A0 =A0 changes to fix Nishanth Menon's comments
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 i) Added the TWL4030 Errata 27 fix
>>
>> =A0 =A0 =A0 split the first patch in v6
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 i) =A0fix for twl4030 script load
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ii) correct the warning print during scr=
ipt loading
>>
>> =A0 =A0 =A0 Added new patch files
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 i) changing sys_off signal polarity
>>
>> =A0 =A0 =A0 Updated the change logs
>>
>> Since the voltage layer is evolving to a new design, the voltage dep=
endant
>> changes required for the TRITON script are not incorporated in the p=
atch series.
>
> A v8 should've been done here to be clear that this is an updated
> series, since the first v7 was a 12-patch series and this one is an
> 8-patch series.
>

Ok, I will change this to v8.

Regards,
Lesly A M

< ... >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
