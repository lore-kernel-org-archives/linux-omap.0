From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Sun, 12 Feb 2012 01:03:21 +0200
Message-ID: <CAMP44s1yY8N4z_uF1b=DKdEMGXORJUhkytEpbK2AoCSTbmiJNw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44830 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755046Ab2BKXDX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Feb 2012 18:03:23 -0500
Received: by lagu2 with SMTP id u2so3182468lag.19
        for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 15:03:21 -0800 (PST)
In-Reply-To: <CAB-zwWhSoiMNVGQ=u=6-Umte-AaP9Qih8QMJFTyk8pjXaXysLg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Greg KH <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Sat, Feb 11, 2012 at 9:19 PM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
>
> On Feb 10, 2012 12:44 PM, "Felipe Contreras" <felipe.contreras@gmail.=
com>
> wrote:
>>
>> On Fri, Feb 10, 2012 at 10:35 PM, Dan Carpenter
>> <dan.carpenter@oracle.com> wrote:
>> > On Fri, Feb 10, 2012 at 09:42:32PM +0200, Felipe Contreras wrote:
>> >> On Fri, Feb 10, 2012 at 8:00 PM, Dan Carpenter
>> >> <dan.carpenter@oracle.com> wrote:
>> >> > On Fri, Feb 10, 2012 at 01:30:48AM +0200, Felipe Contreras wrot=
e:
>> >> >> It's not an oops, it's a warning, and again, it depends on the
>> >> >> firmware being used. We don't have control over that, and we h=
ave no
>> >> >> way to detect if this feature is there. It's up to the user.
>> >> >
>> >> > Perhaps just remove the warning message and handle the conditio=
n
>> >> > instead of printing a stack dump? =C2=A0The user should be trig=
gering
>> >> > stack dumps. =C2=A0What on earth?
>> >>
>> >> The warning doesn't come from the driver.
>> >
>> > I'm not sure I understand. =C2=A0Are you saying that because it co=
mes
>> > from the arch/ directory, it can't be fixed? =C2=A0I have good new=
s for
>> > you my friend. =C2=A0:) =C2=A0It's all open source! =C2=A0\o/
>>
>> The fact that you _can_ remove the warning doesn't mean you should. =
To
>> me it sounds like a proper warning.
>>
>> > Anyway, I saw in another email that Omar is working on a fix so
>> > probably we can just wait for his patch, yes?
>>
>> He only proposed a solution, I doubt he is working on. And to me, th=
at
>> sounded like a hack rather than a proper fix.
>
> I'm out on travel but will be able to look at it on Monday.
>
> Well,=C2=A0 I think it is the right way, you look on the firmware if =
it has WDT
> you use it if it doesn't then you don't. Rather than guessing if you =
have
> the feature. It would be like reading a config option in the firmware=
=2E

Yeah, but it's not really firmware, it's an operating system image. I
can be running Linux there, and I might have implemented WDT. How is
that code going to find that out?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
