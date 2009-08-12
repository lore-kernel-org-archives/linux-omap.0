From: Mike Chan <mike@android.com>
Subject: Re: [PATCH] omap: pm: Fix overflow when doing powerdomain deps
	lookups.
Date: Wed, 12 Aug 2009 10:58:32 -0700
Message-ID: <8bb80c380908121058r66e7ad70vf77e91b1aebb569@mail.gmail.com>
References: <1249956052-21893-1-git-send-email-mike@android.com>
	 <87tz0e76vk.fsf@deeprootsystems.com>
	 <8bb80c380908111111m5a0a3417n3fea568cb8ea9124@mail.gmail.com>
	 <alpine.DEB.2.00.0908120029530.8886@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:40422 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZHLR6b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 13:58:31 -0400
Received: by vws2 with SMTP id 2so177974vws.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 10:58:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0908120029530.8886@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Tue, Aug 11, 2009 at 11:32 PM, Paul Walmsley<paul@pwsan.com> wrote:
> Hi Mike,
>
> On Tue, 11 Aug 2009, Mike Chan wrote:
>
>> On Tue, Aug 11, 2009 at 7:38 AM, Kevin
>> Hilman<khilman@deeprootsystems.com> wrote:
>> > Mike Chan <mike@android.com> writes:
>> >
>> >> Signed-off-by: Mike Chan <mike@android.com>
>> >> ---
>> >> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A02 +-
>> >> =A01 files changed, 1 insertions(+), 1 deletions(-)
>> >>
>> >> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-om=
ap2/powerdomain.c
>> >> index 0334609..6077629 100644
>> >> --- a/arch/arm/mach-omap2/powerdomain.c
>> >> +++ b/arch/arm/mach-omap2/powerdomain.c
>> >> @@ -90,7 +90,7 @@ static struct powerdomain *_pwrdm_deps_lookup(s=
truct powerdomain *pwrdm,
>> >> =A0 =A0 =A0 if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip=
))
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> >>
>> >> - =A0 =A0 for (pd =3D deps; pd; pd++) {
>> >> + =A0 =A0 for (pd =3D deps; pd->pwrdm_name; pd++) {
>> >
>> > Maybe should be:
>> >
>> > =A0 =A0 =A0 =A0for (pd =3D deps; pd && pd->pwrdm_name; pd++) {
>> >
>>
>> At the end of the list pd is a pointer to a NULL struct, so checking
>> if the address =3D=3D NULL doesn't help here. In fact the original c=
ode
>> will just keep running past the struct to read who knows what in
>> memory.
>>
>> This case manifests itself when from clkdms_setup() when enabling au=
to
>> idle for a clock domain and the clockdomain usecount is greater than
>> 0. When _clkdm_add_autodeps() tries to add the a dependency that doe=
s
>> not exist in the powerdomain->wkdep_srcs array the for loop will run
>> past the wkdep_srcs array.
>>
>> Currently in linux-omap you won't hit this because the not found cas=
e
>> is never executed, unless you start modifying powerdomains and their
>> wakeup/sleep deps.
>>
>> --Mike
>
> Thanks for the patch, this is correct. =A0But the patch also should m=
odify:
>
> =A0 =A0 =A0 =A0if (!pd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENOENT);
>
> after the loop to be
>
> =A0 =A0 =A0 =A0if (!pd->pwrdm_name)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
>
> Could you revise this and resend?
>
> thanks
>

Good catch, looks like this was already merged into the omap-pm branch =
:/
Sending a followup patch fine with everyone?

>
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
