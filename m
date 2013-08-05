From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod fixes for v3.11-rc
Date: Sun, 4 Aug 2013 19:32:19 -0700
Message-ID: <CAOesGMim-Ku=HMEor-8Lh_jtfdy6vFve-vaeYPOGZ0nxWiH0sA@mail.gmail.com>
References: <alpine.DEB.2.02.1307301146110.4505@utopia.booyaka.com>
	<20130730133336.GL7656@atomide.com>
	<20130804203653.GF15602@quad.lixom.net>
	<alpine.DEB.2.02.1308042345590.21276@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:37802 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab3HECcU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Aug 2013 22:32:20 -0400
Received: by mail-qc0-f178.google.com with SMTP id s1so1396126qcw.37
        for <linux-omap@vger.kernel.org>; Sun, 04 Aug 2013 19:32:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1308042345590.21276@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Aug 4, 2013 at 4:46 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Sun, 4 Aug 2013, Olof Johansson wrote:
>
>> On Tue, Jul 30, 2013 at 06:33:36AM -0700, Tony Lindgren wrote:
>> > Arnd & Olof,
>> >
>> > Can you please take this pull request directly? Other than the
>> > omap5 regulator dts changes I just posted I don't yet have
>> > anything else queued up right now.
>>
>>
>> Pulled. But Paul, if you don't mind, please base your fixes on older -rcs
>> unless there's a reason to go with the latest-and-greatest.
>>
>> I had to rebase our fixes branch since this pulled in a newer -rc than
>> ours and I didn't want to have a back-merge in the history.
>
> Will do.  Sorry about the extra hassle.

No need to apologize, I've never asked for anything like it in the past.

It's something I've realized as of late that it'd be good to avoid
where possible. We used to start a new fixes branch on top of each -rc
so it wasn't an issue before.


-Olof
