From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: pm: Fix overflow when doing powerdomain deps  lookups.
Date: Tue, 11 Aug 2009 17:14:00 -0700
Message-ID: <87zla551o7.fsf@deeprootsystems.com>
References: <1249956052-21893-1-git-send-email-mike@android.com>
	<87tz0e76vk.fsf@deeprootsystems.com>
	<8bb80c380908111111m5a0a3417n3fea568cb8ea9124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:59186 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbZHLAOF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 20:14:05 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1559807qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 17:14:05 -0700 (PDT)
In-Reply-To: <8bb80c380908111111m5a0a3417n3fea568cb8ea9124@mail.gmail.com> (Mike Chan's message of "Tue\, 11 Aug 2009 11\:11\:43 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org

Mike Chan <mike@android.com> writes:

> On Tue, Aug 11, 2009 at 7:38 AM, Kevin
> Hilman<khilman@deeprootsystems.com> wrote:
>> Mike Chan <mike@android.com> writes:
>>
>>> Signed-off-by: Mike Chan <mike@android.com>
>>> ---
>>> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A02 +-
>>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap=
2/powerdomain.c
>>> index 0334609..6077629 100644
>>> --- a/arch/arm/mach-omap2/powerdomain.c
>>> +++ b/arch/arm/mach-omap2/powerdomain.c
>>> @@ -90,7 +90,7 @@ static struct powerdomain *_pwrdm_deps_lookup(str=
uct powerdomain *pwrdm,
>>> =A0 =A0 =A0 if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>>>
>>> - =A0 =A0 for (pd =3D deps; pd; pd++) {
>>> + =A0 =A0 for (pd =3D deps; pd->pwrdm_name; pd++) {
>>
>> Maybe should be:
>>
>> =A0 =A0 =A0 =A0for (pd =3D deps; pd && pd->pwrdm_name; pd++) {
>>
>
> At the end of the list pd is a pointer to a NULL struct, so checking
> if the address =3D=3D NULL doesn't help here. In fact the original co=
de
> will just keep running past the struct to read who knows what in
> memory.

I see that now, didn't notice the NULL struct terminators.

> This case manifests itself when from clkdms_setup() when enabling aut=
o
> idle for a clock domain and the clockdomain usecount is greater than
> 0. When _clkdm_add_autodeps() tries to add the a dependency that does
> not exist in the powerdomain->wkdep_srcs array the for loop will run
> past the wkdep_srcs array.

Thanks, will add this as changelog and push to PM branch as well as
pm-2.6.29.

Kevin

> Currently in linux-omap you won't hit this because the not found case
> is never executed, unless you start modifying powerdomains and their
> wakeup/sleep deps.
>
> --Mike
>
>> ?
>>
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!omap_chip_is(pd->omap_chip))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>
>> Also, a descriptive changelog would be helpful here describing the
>> conditions where you saw overflow etc.
>>
>> Kevin
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
