From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC 1/1] omap3: PM: MPU and CORE should stay awake if there is
 CAM domain ACTIVE
Date: Tue, 31 Jan 2012 10:34:09 +0100
Message-ID: <CAORVsuU+Gw5kAh13pgsxCH1B=q5Vs1QBwAfJ520p9AzkTyRjig@mail.gmail.com>
References: <1327658401-28441-1-git-send-email-sakari.ailus@iki.fi>
	<CAORVsuWYvvZ_kp=9OTYMjDBibbsOSuBmkUU+u9mb_hKpL80d1Q@mail.gmail.com>
	<20120127140349.GE15297@valkosipuli.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41645 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab2AaJeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:34:10 -0500
Received: by vcge1 with SMTP id e1so195516vcg.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:34:09 -0800 (PST)
In-Reply-To: <20120127140349.GE15297@valkosipuli.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com

Hi Kevin, Paul,

On Fri, Jan 27, 2012 at 3:03 PM, Sakari Ailus <sakari.ailus@iki.fi> wro=
te:
> Hi Jean,
>
> Thanks for you quick reply.
>
> On Fri, Jan 27, 2012 at 12:06:37PM +0100, Jean Pihet wrote:
>> Hi,
>>
>> On Fri, Jan 27, 2012 at 11:00 AM, Sakari Ailus <sakari.ailus@iki.fi>=
 wrote:
>> > MPU and CORE should stay awake if there is CAM domain ACTIVE. This=
 is
>> > because that module doesn't have wake-up capability.
>> >
>> > The original patch was written by Jouni H=F6gander in 2008 and thi=
s is the
>> > last part left of it which is not in upstream yet.
>> >
>> > I wonder if the approach taken in the patch is valid these days;
>> > nevertheless it seems to do the job...
>> The code in the function omap3_enter_idle_bm from
>> arch/arm/mach-omap2/cpuidle34xx.c is doing exactly the same thing: i=
t
>> is choosing the cpuidle safe_state if the CAM power domain is active=
=2E
>>
>> Please note that this only works if CPU_IDLE is selected, which is
>> needed to reach any decent low power mode.
>
> I didn't have CONFIG_CPU_IDLE selected --- it works if I enable it. B=
ut
> still it should work even if it's disabled I guess.
What is your call on this?

Regards,
Jean

>
> Kind regards,
>
> --
> Sakari Ailus
> e-mail: sakari.ailus@iki.fi =A0 =A0 jabber/XMPP/Gmail: sailus@retiisi=
=2Eorg.uk
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
