From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Fri, 10 Feb 2012 18:05:59 +0200
Message-ID: <CAMP44s29yn-vYThbr6cDsvvFgKVELW1nA=onkkVHwp4h2yi_hQ@mail.gmail.com>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
	<20120201011239.GA797@suse.de>
	<CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
	<20120201034445.GA2979@kroah.com>
	<CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
	<20120209173528.GA31726@kroah.com>
	<CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
	<20120209185923.GB10284@kroah.com>
	<CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
	<CAB-zwWj0z9N_2RRHBBNcHPLYWRii2T8q+gMgBnA3+ux8Ojg9JA@mail.gmail.com>
	<20120210051849.GE1565@kroah.com>
	<20120210073554.e9047c25c3fff71028f03fb2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:54424 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758859Ab2BJQGB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 11:06:01 -0500
Received: by lbom4 with SMTP id m4so1397456lbo.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 08:06:00 -0800 (PST)
In-Reply-To: <20120210073554.e9047c25c3fff71028f03fb2@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org

On Fri, Feb 10, 2012 at 5:35 PM, Justin P. Mattock
<justinmattock@gmail.com> wrote:
> On Thu, 9 Feb 2012 21:18:49 -0800
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
>> On Thu, Feb 09, 2012 at 04:45:00PM -0800, Ramirez Luna, Omar wrote:
>> > Hi,
>> >
>> > On Thu, Feb 9, 2012 at 3:30 PM, Felipe Contreras
>> > <felipe.contreras@gmail.com> wrote:
>> > >> Again, I'm totally confused as to _WHY_ this needs to be y. =C2=
=A0What is
>> > >> causing this oops without it? =C2=A0If an oops is happening, th=
en shouldn't
>> > >> this be a strict dependancy? =C2=A0Why allow it to be disabled =
at all if it
>> > >> can break your box if you don't enable it?
>> > >
>> > > It's not an oops, it's a warning, and again, it depends on the
>> > > firmware being used. We don't have control over that, and we hav=
e no
>> > > way to detect if this feature is there. It's up to the user.
>> >
>> > I have been thinking more into it, how about looking for a WDT sym=
bol
>> > inside the baseimage to decide whether to turn ON/OFF WDT3, this w=
ould
>> > mean that the code is always compiled in, but the decision to turn=
 it
>> > on/off is made at runtime.
>>
>> I totally don't understand, why not just silence the warning properl=
y
>> then?
>>
>> I fail to understand why this warning happens, why it depends on the
>> firmware, and why you can't detect it at runtime to not do it. =C2=A0=
And how
>> it all ties into a kconfig option...
>>
>> confused,
>>
>> greg k-h
>
> so there are _two_ issues that need to be fixed here:
>
> 1) the warning fix.
>
> 2) the whole default y thing that Mr. Torvalds is talking about.
> (the first fix(in my mind)would need to go first before anything else=
)
>
> Now reading through, greg had mentioned something about dependency, s=
o if this is just dependency then add the proper
> Kconfig option, but if this is more than just a _dependency_ then som=
ebody(who knows this code)is going to
> have to supply the proper fix for the warning(my C skills only take m=
e so far!)
>
> below is my go at sending a _dependency_ fix for this, but could be t=
otally wrong..
>
> From 5c7ad6c00d051d5444474007cdbecdf14bf3d0cb Mon Sep 17 00:00:00 200=
1
> From: "Justin P. Mattock" <justinmattock@gmail.com>
> Date: Fri, 10 Feb 2012 07:19:45 -0800
> Subject: [PATCH] Add dependency TIDSBRIDGE_WDT3 to TIDSBRIDGE.
>
> This would add the missing _dependency_ to tidsbridge to prevent a wa=
rning from happening.
>
> Note: my Kconfig skills are not the greatest so the below may or may =
not work.
> I can't test this because I dont have the hardware.

Your patch *always* turns on TIDSPBRIDGE_WDT3, which is not what we
want. Depending on the firmware, some people might want it off.

Basically, right now on the typical firmware, people have to either
manually turn TIDSPBRIDGE_WDT3 on, or they will see the warning.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
