From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Fri, 9 Dec 2011 03:13:38 +0200
Message-ID: <CAMP44s10VzBSN0fQm1SkrraZqJgUf_gw8ym-xwOfAFJkXyNPLg@mail.gmail.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
	<CAMP44s16cSBw23Py7qUW4Oj60gXKuvmtx-c=urisxecMQEE6Dw@mail.gmail.com>
	<CAB-zwWiH020HfovGF8CA-v9t8Pjc3kLbsXezN6ToLdyC4muHqA@mail.gmail.com>
	<20111209000733.GA9504@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49920 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1LIBNi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 20:13:38 -0500
Received: by dadv6 with SMTP id v6so2168780dad.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 17:13:38 -0800 (PST)
In-Reply-To: <20111209000733.GA9504@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

On Fri, Dec 9, 2011 at 2:07 AM, Greg KH <greg@kroah.com> wrote:
> On Thu, Dec 08, 2011 at 02:16:10PM -0600, Ramirez Luna, Omar wrote:
>> On Thu, Dec 8, 2011 at 2:11 PM, Felipe Contreras
>> > Definitely 3.2-fix material IMO :)
>>
>> I believe it was pushed to staging-next... I'm rooting so it can be
>> pushed to staging-linus :)
>
> As it wasn't originally stated that this was a problem that needed to=
 be
> fixed for 3.2, can it wait for 3.3-rc1? =C2=A0Especially given that t=
here is
> still discussion about this?

Well, if you want the bridgedriver to hang the whole system in 3.2,
which I don't think is the case. There's no more discussion, at least
not from my side, and I don't think anybody has raised any more
issues. There's really no reason not to merge this patch, as it really
cannot get worst than the current situation, unless the patch makes
the device explode, or something like that, which is not the case :)

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
