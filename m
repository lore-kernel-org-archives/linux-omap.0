From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: [PATCH 0/9] drivers: mailbox: framework creation
Date: Fri, 21 Dec 2012 13:33:08 -0600
Message-ID: <CAJ6Av5N+H4eno+9FizLp9gNsZrZ-TQnLnVGjf-UMBtNiDVuNdA@mail.gmail.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
	<CACRpkdaqO7AAeYeR8SZt4Tbv1grrMq85TNYMc-FSbUSrnZBm=Q@mail.gmail.com>
	<20121220182835.GB21056@atomide.com>
	<CAOesGMh2uZC_9FzAxDVZqwe06OgqOrKjPgQi6wOJCt-SAmoHwg@mail.gmail.com>
	<CAK=Wgba=jLiig+TBcAcp7STz=Y6RM8noR_0S2HZjNQXLZV8JBA@mail.gmail.com>
	<50D42337.3080204@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34024 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab2LUTdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 14:33:11 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so6766867iea.24
        for <linux-omap@vger.kernel.org>; Fri, 21 Dec 2012 11:33:11 -0800 (PST)
In-Reply-To: <50D42337.3080204@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Loic PALLARDY <loic.pallardy@st.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Loic PALLARDY STE <loic.pallardy-ext@stericsson.com>, "arm@kernel.org" <arm@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@lis>

Hi Loic/Ohad,

On Fri, Dec 21, 2012 at 2:52 AM, Loic PALLARDY <loic.pallardy@st.com> wrote:
>
>
> On 12/21/2012 08:31 AM, Ohad Ben-Cohen wrote:
>> On Thu, Dec 20, 2012 at 9:19 PM, Olof Johansson<olof@lixom.net>  wrote:
>>> While we can make the branch stable, would it make sense to make
>>> remoteproc for omap depend on !multiplatform during the transition, to
>>> reduce dependencies a little? Either way works, but it'd be nice to
>>> keep them independent if we can.
>>
>> I'm not sure multiplatform is the culprit; OMAP's remoteproc driver
>> heavily depends on this mailbox code, and obviously breaks with this
>> patch-set if only for the the naming changes. We'll need this patch
>> set to update omap's remoteproc as well so at least we don't break
>> bisectibility, though running a sanity test before merging would be
>> even nicer (Loic I can help if you don't have a panda board).
>
> Hi Ohad,
> Yes tidspbridge and remoteproc must be adapted.
> This new mailbox fw has been tested on TI environment by Omar, who did
> adaptation at least for tidspbridge.
>
> Omar, do you have patch series ready for TI adaptations to new mailbox
> framework?
> Else I can do it, but I won't be able to test it (no panda board)

Yes, I made the changes, for tidspbridge and remoteproc, I will submit
both for review, based on this series.

Cheers,

Omar
