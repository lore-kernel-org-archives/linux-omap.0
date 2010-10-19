From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap: dsp: fix for ioremap()
Date: Tue, 19 Oct 2010 10:43:30 +0300
Message-ID: <AANLkTik12BFhn+UXT4dBnuPFZKeeNPYwp+ibd63SU_O+@mail.gmail.com>
References: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
	<20101019073834.GB12470@legolas.emea.dhcp.ti.com>
	<20101019073919.GC12470@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36148 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386Ab0JSHnc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 03:43:32 -0400
Received: by fxm4 with SMTP id 4so1361619fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Oct 2010 00:43:31 -0700 (PDT)
In-Reply-To: <20101019073919.GC12470@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

On Tue, Oct 19, 2010 at 10:39 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Oct 19, 2010 at 02:38:34AM -0500, Balbi, Felipe wrote:
>>
>> On Tue, Oct 19, 2010 at 02:37:23AM -0500, Felipe Contreras wrote:
>>>
>>> Since ioremap() on RAM will be soon disallowed, this is required.
>>>
>>> This also requires a patch like:
>>> http://article.gmane.org/gmane.linux.kernel/1047146
>>>
>>> Felipe Contreras (1):
>>> =C2=A0omap: dsp: remove shm from normal memory
>>>
>>> arch/arm/plat-omap/devices.c | =C2=A0 =C2=A04 +++-
>>> 1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> -ENOPATCH ??
>
> ok, now I got the patch. Just $SUBJECT is a bit misleading, sorry

:)

I thought on just sending the patch, but the last time there wasn't
enough explanation that it depended on another one.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
