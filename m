From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Fri, 10 Feb 2012 21:42:32 +0200
Message-ID: <CAMP44s2HUApzGH_rExqS1bOnq0nHj4Y0vEojZN4vXNPAxC1oKA@mail.gmail.com>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
	<20120201011239.GA797@suse.de>
	<CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
	<20120201034445.GA2979@kroah.com>
	<CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
	<20120209173528.GA31726@kroah.com>
	<CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
	<20120209185923.GB10284@kroah.com>
	<CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
	<20120210180015.GF4141@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:42947 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932451Ab2BJTme convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 14:42:34 -0500
Received: by lbom4 with SMTP id m4so1502730lbo.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 11:42:32 -0800 (PST)
In-Reply-To: <20120210180015.GF4141@mwanda>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, linux-omap@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, Felipe Contreras <felipe.contreras@nokia.com>

On Fri, Feb 10, 2012 at 8:00 PM, Dan Carpenter <dan.carpenter@oracle.co=
m> wrote:
> On Fri, Feb 10, 2012 at 01:30:48AM +0200, Felipe Contreras wrote:
>> It's not an oops, it's a warning, and again, it depends on the
>> firmware being used. We don't have control over that, and we have no
>> way to detect if this feature is there. It's up to the user.
>
> Perhaps just remove the warning message and handle the condition
> instead of printing a stack dump? =C2=A0The user should be triggering
> stack dumps. =C2=A0What on earth?

The warning doesn't come from the driver.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
