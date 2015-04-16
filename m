From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v3] ARM: AM43xx: hwmod: add VPFE hwmod entries
Date: Thu, 16 Apr 2015 15:44:10 +0100
Message-ID: <CA+V-a8vP=1jF2a791BTK9A75rWEYnhw_T55qaxh6e57DpzcXQw@mail.gmail.com>
References: <1422260488-380-1-git-send-email-prabhakar.csengg@gmail.com>
 <20150128193247.GH2570@ti.com> <alpine.DEB.2.02.1502102310010.3767@utopia.booyaka.com>
 <CA+V-a8vx=A8qQh4CtD7tjFwgBmkFPX7sUVuak8e4rH9N39gwfA@mail.gmail.com>
 <alpine.DEB.2.02.1504102248590.19540@utopia.booyaka.com> <CA+V-a8uw7AM0HWtNgKT6otj1xF502Msn-=a5WzbSYjT0xM8Epw@mail.gmail.com>
 <alpine.DEB.2.02.1504102302290.19540@utopia.booyaka.com> <CA+V-a8vTKiaJqttuvfU-NHznF=TghH5Fbzqwo8AcCRccn7DJgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33024 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933614AbbDPOom (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2015 10:44:42 -0400
In-Reply-To: <CA+V-a8vTKiaJqttuvfU-NHznF=TghH5Fbzqwo8AcCRccn7DJgg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Parrot <bparrot@ti.com>, Tony Lindgren <tony@atomide.com>, LAK <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>, Felipe Balbi <balbi@ti.com>

Hi Paul,

On Sat, Apr 11, 2015 at 10:19 AM, Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Sat, Apr 11, 2015 at 12:03 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> On Fri, 10 Apr 2015, Lad, Prabhakar wrote:
>>
>>> On Fri, Apr 10, 2015 at 11:51 PM, Paul Walmsley <paul@pwsan.com> wrote:
>>> > Hi Prabhakar
>>> >
>>> > On Fri, 10 Apr 2015, Lad, Prabhakar wrote:
>>> >
>>> >> Hi Paul,
>>> >>
>>> >> On Tue, Feb 10, 2015 at 11:10 PM, Paul Walmsley <paul@pwsan.com> wrote:
>>> >> > On Wed, 28 Jan 2015, Benoit Parrot wrote:
>>> >> >
>>> >> >> Suspend/resume is functional with this patch.
>>> >> >>
>>> >> >> Tested-by: Benoit Parrot <bparrot@ti.com>
>>> >> >
>>> >> > Thanks folks, queued for v3.21.
>>> >> >
>>> >> >
>>> >> I see that this patch is not into linux-next yet.
>>> >
>>> > thanks for the ping.  This slipped through the cracks here due to the
>>> > kernel version number change from 3.21 to 4.1 :-(  Sorry about that; I
>>> > will requeue for either 4.1-rc or 4.2.
>>> >
>>> > Unfortunately I don't have an AM43xx board.  Is suspend/resume broken
>>> > without this patch?  If so, then v4.1-rc seems like the appropriate
>>> > target.
>>> >
>>> there is kernel soft crashes without this patch, so this needs to go
>>> in for v4.1-rc.
>>
>> Could you provide some further detail?  Does it crash during boot, or
>> during suspend, or ... ?  Also could you describe what you mean by "soft
>> crash" ?
>>
> with patch [1] applied and VPFE being enabled and this patch missing
> (ARM: AM43xx: hwmod: add VPFE hwmod entries) I have attached the
> boot log.
> By soft crash I meant it doesn't get hung :)
>
> With the above patch (ARM: AM43xx: hwmod: add VPFE hwmod entries)
> applied all goes well.
>
>
> [1] https://lkml.org/lkml/2015/3/12/1001
>

Any update on this ?

Cheers,
--Prabhakar Lad
