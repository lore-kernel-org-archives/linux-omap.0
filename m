From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Mon, 13 Feb 2012 17:12:04 -0800
Message-ID: <CAB-zwWi0_ueUo96Jrxrfcvidwn9yPOePBxUTzNbhwTaMbuCiSA@mail.gmail.com>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:41283 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751438Ab2BNBMG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Feb 2012 20:12:06 -0500
Received: by mail-lpp01m020-f176.google.com with SMTP id i15so2788162lbo.7
        for <linux-omap@vger.kernel.org>; Mon, 13 Feb 2012 17:12:04 -0800 (PST)
In-Reply-To: <20120210051849.GE1565@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, linux-omap@vger.kernel.org

On Thu, Feb 9, 2012 at 9:18 PM, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> On Thu, Feb 09, 2012 at 04:45:00PM -0800, Ramirez Luna, Omar wrote:
>> Hi,
>>
>> On Thu, Feb 9, 2012 at 3:30 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> >> Again, I'm totally confused as to _WHY_ this needs to be y. =A0Wh=
at is
>> >> causing this oops without it? =A0If an oops is happening, then sh=
ouldn't
>> >> this be a strict dependancy? =A0Why allow it to be disabled at al=
l if it
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
>
> I fail to understand why this warning happens, why it depends on the
> firmware, and why you can't detect it at runtime to not do it. =A0And=
 how
> it all ties into a kconfig option...

Just FTR, the warning comes from an interconnect driver that reports er=
rors.

This specific warning occurs because the dsp tries to access wdt3
registers without a clock, hence turning ON the wdt3 (or default y for
wdt3 Kconfig) will make the warning to disappear when first loading a
base image into the dsp, because now there will be a clock for the
registers.

It depends on the firmware because the accesses are made from the dsp i=
tself.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
