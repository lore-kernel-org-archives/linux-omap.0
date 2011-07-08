From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Fri, 08 Jul 2011 09:56:29 -0700
Message-ID: <4E1736BD.5070301@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com> <4E14B820.6070202@ti.com> <20110707055549.GC15815@atomide.com> <alpine.DEB.2.00.1107080031440.24181@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:47447 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751083Ab1GHQ4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 12:56:37 -0400
Received: by mail-gw0-f47.google.com with SMTP id 11so994180gwb.20
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 09:56:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1107080031440.24181@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 7/7/2011 11:39 PM, Paul Walmsley wrote:
> On Thu, 7 Jul 2011, Tony Lindgren wrote:
>
>> * Rajendra Nayak<rnayak@ti.com>  [110706 22:26]:
>>> On 7/6/2011 12:19 AM, Paul Walmsley wrote:
>>>>
>>>> Patch 16, to me, belongs best with the 4460 support series and so =
I'll see
>>>> if it makes sense to fit it in there somewhere.
>>>
>>> Paul,
>>>
>>> Do you want me to base the 4460 support series on one of your branc=
hes
>>> and re-post including the above patch?
>>
>> Do we really need to do that patching right now to add base 4460 sup=
port?
>>
>> If we're just doing a bunch of renames all over the place to add sup=
port
>> for a new processor variant, something is wrong. This is exactly the=
 kind
>> of "crazy churn" Linus was complaining about. In this case the crazy=
 churn
>> is "let's rename 4430 to 44XX all over the place".
>>
>> To me it's sane to assume that we can have most of 4430 features on =
4460
>> and don't need to rename 4430 to 44XX for that. Adding 4460 should b=
e
>> just add few new 4460 defines, then do an arch_initcall to fixup thi=
ngs
>> between 4430 and 4460.
>>
>> It would be nice to get the base 4460 support merged as the patches =
look
>> ready to go otherwise. Rajendra, I suggest you take a quick look and=
 see
>> if you can leave out the dependency to the 4430 to 44XX rename patch=
 to
>> add minimal 4460 support. Then we can patch in the missing features =
later
>> on, most likely we don't even need the arch_initcall fixup initially=
 either.
>>
>> This would also leave out the dependency between the various patch
>> series which will always lead into issues with merging code. Changes=
 to
>> the infrastructure issues like this should have been patched away ea=
rly.
>> The merge window is about to start and we're still waiting for the
>> dependencies to get sorted out.
>
> Rajendra's patch series doesn't require the 4430 ->  44XX changes in =
the
> PRM/CM macros (Beno=EEt's patch 16).  That patch can be put in a sepa=
rate
> series, if you like.

Paul, I could not find any 4430 ->  44XX changes in any PRM/CM macros
in Benoit's patch 16. Instead, I see he is updating the CHIP_IS_* macro=
s
similar to what I did in my series for Powerdomain/Clockdomain.

>
> It does require changing CHIP_IS_OMAP4430 to CHIP_IS_OMAP44XX in the
> powerdomains, clockdomains, etc.

And in hwmod, which is what Benoit's patch 16 does I guess.
If we drop all these, the only alternative is to change the way the
different SoC variant's are handled in these different frameworks
the way Tony suggested, by having SoC specific lists.

> To me, that seems reasonable since the
> 4460 isn't simply a die shrink, it has some other changes on it; but =
I
> guess you have a different view on that.
>
> I will add acks/reviewed-by:s on the 4460 patches, and maybe you can
> decide which ones you'd like to merge, if any.
>
>
> - Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
