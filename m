From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Thu, 9 Feb 2012 16:45:00 -0800
Message-ID: <CAB-zwWj0z9N_2RRHBBNcHPLYWRii2T8q+gMgBnA3+ux8Ojg9JA@mail.gmail.com>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
	<20120201011239.GA797@suse.de>
	<CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
	<20120201034445.GA2979@kroah.com>
	<CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
	<20120209173528.GA31726@kroah.com>
	<CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
	<20120209185923.GB10284@kroah.com>
	<CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:37292 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754722Ab2BJApC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 19:45:02 -0500
Received: by mail-lpp01m010-f52.google.com with SMTP id y4so3324156lag.39
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 16:45:00 -0800 (PST)
In-Reply-To: <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, linux-omap@vger.kernel.org

Hi,

On Thu, Feb 9, 2012 at 3:30 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>> Again, I'm totally confused as to _WHY_ this needs to be y. =A0What =
is
>> causing this oops without it? =A0If an oops is happening, then shoul=
dn't
>> this be a strict dependancy? =A0Why allow it to be disabled at all i=
f it
>> can break your box if you don't enable it?
>
> It's not an oops, it's a warning, and again, it depends on the
> firmware being used. We don't have control over that, and we have no
> way to detect if this feature is there. It's up to the user.

I have been thinking more into it, how about looking for a WDT symbol
inside the baseimage to decide whether to turn ON/OFF WDT3, this would
mean that the code is always compiled in, but the decision to turn it
on/off is made at runtime.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
