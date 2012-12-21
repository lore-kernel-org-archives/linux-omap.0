From: Loic PALLARDY <loic.pallardy@st.com>
Subject: Re: [PATCH 0/9] drivers: mailbox: framework creation
Date: Fri, 21 Dec 2012 09:52:07 +0100
Message-ID: <50D42337.3080204@st.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <CACRpkdaqO7AAeYeR8SZt4Tbv1grrMq85TNYMc-FSbUSrnZBm=Q@mail.gmail.com>
 <20121220182835.GB21056@atomide.com>
 <CAOesGMh2uZC_9FzAxDVZqwe06OgqOrKjPgQi6wOJCt-SAmoHwg@mail.gmail.com>
 <CAK=Wgba=jLiig+TBcAcp7STz=Y6RM8noR_0S2HZjNQXLZV8JBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:53096 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339Ab2LUIy4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Dec 2012 03:54:56 -0500
In-Reply-To: <CAK=Wgba=jLiig+TBcAcp7STz=Y6RM8noR_0S2HZjNQXLZV8JBA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Loic PALLARDY STE <loic.pallardy-ext@stericsson.com>, "arm@kernel.org" <arm@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadi>



On 12/21/2012 08:31 AM, Ohad Ben-Cohen wrote:
> On Thu, Dec 20, 2012 at 9:19 PM, Olof Johansson<olof@lixom.net>  wrote:
>> While we can make the branch stable, would it make sense to make
>> remoteproc for omap depend on !multiplatform during the transition, to
>> reduce dependencies a little? Either way works, but it'd be nice to
>> keep them independent if we can.
>
> I'm not sure multiplatform is the culprit; OMAP's remoteproc driver
> heavily depends on this mailbox code, and obviously breaks with this
> patch-set if only for the the naming changes. We'll need this patch
> set to update omap's remoteproc as well so at least we don't break
> bisectibility, though running a sanity test before merging would be
> even nicer (Loic I can help if you don't have a panda board).

Hi Ohad,
Yes tidspbridge and remoteproc must be adapted.
This new mailbox fw has been tested on TI environment by Omar, who did 
adaptation at least for tidspbridge.

Omar, do you have patch series ready for TI adaptations to new mailbox 
framework?
Else I can do it, but I won't be able to test it (no panda board)

Regards,
Loic
>
> BTW - grep shows that tidspbridge is using the mailbox code too, but
> it's in staging and I'm not sure it gets much love. Nevertheless, as
> long as it's there we should at least update it with the new API as
> well.
>
> Thanks,
> Ohad.