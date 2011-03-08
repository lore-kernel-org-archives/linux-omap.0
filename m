From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v8 0/8] omap3: pm: TWL4030 power scripts and workaround
 for TWL errata 27
Date: Tue, 8 Mar 2011 13:00:34 +0530
Message-ID: <AANLkTik2946DiOxvFz0utDogm8LJftp6ctrAhdiGyHv2@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
	<87lj0q39oq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42644 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753337Ab1CHHag convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 02:30:36 -0500
Received: by vws12 with SMTP id 12so5515513vws.5
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 23:30:35 -0800 (PST)
In-Reply-To: <87lj0q39oq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Tue, Mar 8, 2011 at 2:55 AM, Kevin Hilman <khilman@ti.com> wrote:
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
>
> This doesn't apply to the current PM branch. =A0I dropped the old scr=
ipts
> from the PM branch some time back. =A0It should be a simple rebase, a=
nd
> only affects PATCH 6/8. =A0After the rebase, it will only add the new
> stuff to the 3430SDP board file instead of also delete the old script=
s.
>
> Also, minor nit: please consistenly capitlize acronyms: API, OMAP, et=
c,
> and the singular for errata is erattum. =A0This affects subjects,
> changelogs comments etc.

Ok, I wil fix it.

>
>> Changes in v7:
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
>> Changes in v8:
>> =A0 =A0 =A0 updated the change logs
>> =A0 =A0 =A0 moving the TWL IDCODE checking to twl-core.c
>>
>> Since the voltage layer is evolving to a new design, the voltage dep=
endant
>> changes required for the TRITON script are not incorporated in the p=
atch series.
>> So this TRITON script patch series can be tested with a separate pat=
ch for
>> voltage layer changes.
>>
>> =A0 =A0 =A0 lnk: http://pastebin.mozilla.org/1118306
>
> I'm OK with leaving the voltage layer changes for a separate series, =
but
> in order to test this should also be rebased against my current PM br=
anch.
>
> For future reference, my pm-core branch includes only patches/series
> that are already queued for upstream, or will be queued for the next
> merge window.

Ok, I will rebase the patches.

Thanks & Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
