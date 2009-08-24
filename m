From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Where is DSP Gateway
Date: Mon, 24 Aug 2009 09:27:30 +0300
Message-ID: <94a0d4530908232327h79334d81u20686c5a773d3501@mail.gmail.com>
References: <deb0f030908181654m71a6a10l10a29426377a702a@mail.gmail.com>
	 <deb0f030908182145r68b8021cj49f2fac24d330eca@mail.gmail.com>
	 <4A8D4064.7050005@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:53313 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbZHXG13 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 02:27:29 -0400
Received: by fg-out-1718.google.com with SMTP id e12so449297fga.17
        for <linux-omap@vger.kernel.org>; Sun, 23 Aug 2009 23:27:30 -0700 (PDT)
In-Reply-To: <4A8D4064.7050005@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: ext Suresh Rajashekara <suresh@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Thu, Aug 20, 2009 at 3:24 PM, Ameya Palande<ameya.palande@nokia.com>=
 wrote:
> ext Suresh Rajashekara wrote:
>> Hi All,
>>
>> We had been using dspgateway 3.3 on 2.6.16. Recently we changed our
>> kernel to 2.6.29 and we found that the dspgateway driver has been
>> removed from the tree
>> ( http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.=
git;a=3Dcommit;h=3D2512fd29db4eb09e82d182596304c7aaf76d2c5c).
>>
>> What do I do, If I want to use the dspgateway on 2.6.29?
>>
>> I tried searching the patch for dspgateway on 2.6.29, but found none
>> except this
>> http://archive.netbsd.se/?ml=3Dlinux-kernel&a=3D2009-07&m=3D11155350
>>
>> Any pointers would be really helpful
>>
>> Thanks in advance,
>> Suresh
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
> I think DSP-gateway is not maintained, and they are now using bridged=
river.

AFAIK Hiroshi is the maintainer, but probably haven't had time to work
on that since a while.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
