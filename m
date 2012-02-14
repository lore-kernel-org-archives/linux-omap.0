From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Tue, 14 Feb 2012 18:23:26 +0200
Message-ID: <CAMP44s3sNH2qRsMHxgCbemefVye=z5E8XFLnSPvUtgA94SoV=A@mail.gmail.com>
References: <20120201011239.GA797@suse.de>
	<CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
	<20120201034445.GA2979@kroah.com>
	<CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
	<20120209173528.GA31726@kroah.com>
	<CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
	<20120209185923.GB10284@kroah.com>
	<CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
	<20120210180015.GF4141@mwanda>
	<CAMP44s2HUApzGH_rExqS1bOnq0nHj4Y0vEojZN4vXNPAxC1oKA@mail.gmail.com>
	<20120210203537.GG4141@mwanda>
	<CAMP44s2OEvn7RVpwJ2zkdkxrzwrbD3+PFQbzYiOG-hvnrc4UhA@mail.gmail.com>
	<CAB-zwWhSoiMNVGQ=u=6-Umte-AaP9Qih8QMJFTyk8pjXaXysLg@mail.gmail.com>
	<CAMP44s1yY8N4z_uF1b=DKdEMGXORJUhkytEpbK2AoCSTbmiJNw@mail.gmail.com>
	<CAB-zwWjtPcdwAfQGW6iB-pLWVuM1S0YJS7ioVv_voYZH2wNM9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:41832 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751236Ab2BNQX1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 11:23:27 -0500
Received: by lbom4 with SMTP id m4so3147885lbo.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 08:23:26 -0800 (PST)
In-Reply-To: <CAB-zwWjtPcdwAfQGW6iB-pLWVuM1S0YJS7ioVv_voYZH2wNM9Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <gregkh@linuxfoundation.org>

On Tue, Feb 14, 2012 at 3:06 AM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> On Feb 11, 2012 3:03 PM, "Felipe Contreras" <felipe.contreras@gmail.c=
om> wrote:
>>
>> On Sat, Feb 11, 2012 at 9:19 PM, Ramirez Luna, Omar <omar.ramirez@ti=
=2Ecom> wrote:
>> >
>> > On Feb 10, 2012 12:44 PM, "Felipe Contreras" <felipe.contreras@gma=
il.com>
>> > wrote:
>> >>
>> >> On Fri, Feb 10, 2012 at 10:35 PM, Dan Carpenter
>> >> <dan.carpenter@oracle.com> wrote:
>> >> > On Fri, Feb 10, 2012 at 09:42:32PM +0200, Felipe Contreras wrot=
e:
>> >> >> On Fri, Feb 10, 2012 at 8:00 PM, Dan Carpenter
>> >> >> <dan.carpenter@oracle.com> wrote:
>> >> >> > On Fri, Feb 10, 2012 at 01:30:48AM +0200, Felipe Contreras w=
rote:
>> >> >> >> It's not an oops, it's a warning, and again, it depends on =
the
>> >> >> >> firmware being used. We don't have control over that, and w=
e have no
>> >> >> >> way to detect if this feature is there. It's up to the user=
=2E
>> >> >> >
>> >> >> > Perhaps just remove the warning message and handle the condi=
tion
>> >> >> > instead of printing a stack dump? =C2=A0The user should be t=
riggering
>> >> >> > stack dumps. =C2=A0What on earth?
>> >> >>
>> >> >> The warning doesn't come from the driver.
>> >> >
>> >> > I'm not sure I understand. =C2=A0Are you saying that because it=
 comes
>> >> > from the arch/ directory, it can't be fixed? =C2=A0I have good =
news for
>> >> > you my friend. =C2=A0:) =C2=A0It's all open source! =C2=A0\o/
>> >>
>> >> The fact that you _can_ remove the warning doesn't mean you shoul=
d. To
>> >> me it sounds like a proper warning.
>> >>
>> >> > Anyway, I saw in another email that Omar is working on a fix so
>> >> > probably we can just wait for his patch, yes?
>> >>
>> >> He only proposed a solution, I doubt he is working on. And to me,=
 that
>> >> sounded like a hack rather than a proper fix.
>> >
>> > I'm out on travel but will be able to look at it on Monday.
>> >
>> > Well,=C2=A0 I think it is the right way, you look on the firmware =
if it has WDT
>> > you use it if it doesn't then you don't. Rather than guessing if y=
ou have
>> > the feature. It would be like reading a config option in the firmw=
are.
>>
>> Yeah, but it's not really firmware, it's an operating system image. =
I
>> can be running Linux there, and I might have implemented WDT. How is
>> that code going to find that out?
>
> Tidspbridge loader doesn't support that use case, baseimage and let's
> say a dsp-linuximg won't have the same layout, hence it won't be able
> to parse and load the latter.
>
> When that case is applicable, we should first modify the loader code
> or prepare the baseimages to be common so we can get rid of specific
> loaders and just dump them into memory.

I'd say the less workarounds, the better.

> WDT could be detected by prepending common symbols into the baseimage=
s
> or just making the new images to treat all peripherals as resources,
> that is, the new baseimg should actually request the wdt3 as any othe=
r
> clock.

I see, but if wdt3 is requested as another clock, the Linux ARM side
would still need to know how to threat the WDT.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
