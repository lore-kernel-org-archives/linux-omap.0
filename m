From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Fri, 10 Feb 2012 18:16:19 +0200
Message-ID: <CAMP44s3M1vo7j9o8NBhQm5QpLz91w3UdZz6vFmXt2f_r5n1hSw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40707 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758270Ab2BJQQV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 11:16:21 -0500
Received: by lagu2 with SMTP id u2so2482520lag.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 08:16:19 -0800 (PST)
In-Reply-To: <20120210051849.GE1565@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, linux-omap@vger.kernel.org

On Fri, Feb 10, 2012 at 7:18 AM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> On Thu, Feb 09, 2012 at 04:45:00PM -0800, Ramirez Luna, Omar wrote:
>> Hi,
>>
>> On Thu, Feb 9, 2012 at 3:30 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> >> Again, I'm totally confused as to _WHY_ this needs to be y. =C2=A0=
What is
>> >> causing this oops without it? =C2=A0If an oops is happening, then=
 shouldn't
>> >> this be a strict dependancy? =C2=A0Why allow it to be disabled at=
 all if it
>> >> can break your box if you don't enable it?
>> >
>> > It's not an oops, it's a warning, and again, it depends on the
>> > firmware being used. We don't have control over that, and we have =
no
>> > way to detect if this feature is there. It's up to the user.
>>
>> I have been thinking more into it, how about looking for a WDT symbo=
l
>> inside the baseimage to decide whether to turn ON/OFF WDT3, this wou=
ld
>> mean that the code is always compiled in, but the decision to turn i=
t
>> on/off is made at runtime.
>
> I totally don't understand, why not just silence the warning properly
> then?

The warning doesn't come from the driver, and AFAIK it's a valid
warning. Now, I haven't explored the code, so I don't know what's
going on, I just know Omar said this fixes the warning, and that
there's no easy way around it.

> I fail to understand why this warning happens,

I don't know either, I just know enabling TIDSPBRIDGE_WDT3 fixes it.

> why it depends on the firmware,

Because it just does.

Does your firmware have WDT? Yes =3D> TIDSPBRIDGE_WDT3 on, No =3D>
TIDSPBRIDGE_WDT3 off.

What is so complicated about this?

> and why you can't detect it at runtime to not do it.

The DSP "firmwmare" is an operating system. You even run Linux on it.

We just don't know if has WDT support or not. Omar is familiar with
the code regarding the WDT, and he said it was not easy to detect if
enabling WDT failed or not.

> And how it all ties into a kconfig option...

Some people want it, some people don't.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
