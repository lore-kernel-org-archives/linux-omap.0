From: Venkatraman S <svenkatr@ti.com>
Subject: Re: How to introduce omap_features (was Re: [PATCH RESEND] update
	omap3 features bitmap and API to generic names)
Date: Tue, 11 May 2010 17:49:46 +0530
Message-ID: <AANLkTimHN0XUlBsj3FvhpOkuMhrFHSvPu3MQI9ZtEqvc@mail.gmail.com>
References: <1273521338-2896-1-git-send-email-svenkatr@ti.com>
	 <AANLkTimNjnKG3WFK8mdpgHaLh-Xpv54fohFgEYYiVVcg@mail.gmail.com>
	 <0680EC522D0CC943BC586913CF3768C003B3209B23@dbde02.ent.ti.com>
	 <4BE9483C.7090308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42968 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0EKMT7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 08:19:59 -0400
Received: by pvb32 with SMTP id 32so497047pvb.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 05:19:57 -0700 (PDT)
In-Reply-To: <4BE9483C.7090308@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

 Nishanth Menon <menon.nishanth@gmail.com> wrote:
> -linux-arm
>
> On 05/10/2010 10:53 PM, S, Venkatraman wrote:
>>>
>>> -----Original Message-----
>>> From: menon.nishanth@gmail.com
>>> [mailto:menon.nishanth@gmail.com] On Behalf Of Menon, Nishanth
>>> Sent: Tuesday, May 11, 2010 5:02 AM
>>> To: S, Venkatraman
>>> Cc: linux-omap@vger.kernel.org;
>>> linux-arm-kernel@lists.infradead.org; Tony Lindgren;
>>> Chikkature Rajashekar, Madhusudhan
>>> Subject: Re: [PATCH RESEND] update omap3 features bitmap and
>>> API to generic names
>>>
>>> On Mon, May 10, 2010 at 2:55 PM, Venkatraman S
>>> <svenkatr@ti.com> =A0wrote:
>>>>
>>>> =A0 =A0 =A0 =A0OMAP3 features bitmap is used a method to check for=
 SoC
>>>> specific features. This patch renames the global variables and the
>>>> accessor functions to use a generic name from omap3_* to
>>>> omap_*
>>>>
>>>> Signed-off-by: Venkatraman S<svenkatr@ti.com>
>>>> CC: Nishant Menon<nm@ti.com>
>>>
>>> Just for the patchworks
>>> NAK - discussed before -
>>> http://marc.info/?l=3Dlinux-omap&m=3D127349696800651&w=3D2
>>
>> This patch doesn't have the descriptor load changes, and just the re=
name.
>> Did you take a look at it first?
>
> Arrgh - my bad - there was no reference to previous discussions or an=
ything
> in this patch, please do add references in diffstat section if you ar=
e
> refering to a previous discussed strategy to help the reviewers
> differentiate and understand you better.
>
> overall this still opens up a question for me -> can we blindly repla=
ce
> omap3-features with omap features? how do we think of omap1,2,3,4 are
> handled consistently with a 32 bit field?
>
> I agree on the need to have a omap independent field, but is omap3_fe=
atures
> the one we need to modify OR should we be introducing a new field?
>
> my vote goes for introducing a new field.
>

You are confusing the interface with implementation (or rather,
worrying about both of them simultaneously).

The interface has to be consistent and SoC independent, to the extent p=
ossible.
  So the macro changes are relevant and readable / extensible.

Regarding the variable name (implementation):-
   Given the minimal set that we have (5 -6 fields today, so there is
room for 25 more 'features" still), I don't think
we should over-engineer it now to accomodate all permutations and use
cases. It's not even found use
beyond 1 or 2 files. YAGNI ?

Regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
