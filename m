From: Loic PALLARDY <loic.pallardy@st.com>
Subject: Re: [PATCH 1/9] mailbox: OMAP: introduce mailbox framework
Date: Fri, 21 Dec 2012 09:54:26 +0100
Message-ID: <50D423C2.3090009@st.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-2-git-send-email-loic.pallardy-ext@stericsson.com>
 <20121218165909.GF4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:53705 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751812Ab2LUIzK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Dec 2012 03:55:10 -0500
In-Reply-To: <20121218165909.GF4989@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Loic PALLARDY STE <loic.pallardy-ext@stericsson.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Linus Walleij <linus.walleij@linaro.org>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>Omar



On 12/18/2012 05:59 PM, Tony Lindgren wrote:
> * Loic Pallardy<loic.pallardy-ext@stericsson.com>  [121218 05:15]:
>>
>> Signed-off-by: Omar Ramirez Luna<omar.luna@linaro.org>
>
> AFAIK the first two patches should have:
> From: Omar Ramirez Luna<omar.luna@linaro.org>
Yes right, my mistake.
I'll fix that on next version.
/Loic
>
> Once that's fixed, for arch/arm/*omap*/* parts:
>
> Acked-by: Tony Lindgren<tony@atomide.com>