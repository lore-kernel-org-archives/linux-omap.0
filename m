From: Loic PALLARDY <loic.pallardy@st.com>
Subject: Re: [PATCH 5/9] mailbox: change protection mechanisms
Date: Fri, 21 Dec 2012 11:50:58 +0100
Message-ID: <50D43F12.8070105@st.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-6-git-send-email-loic.pallardy-ext@stericsson.com>
 <B5906170F1614E41A8A28DE3B8D121433EC9CE80@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:60844 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752182Ab2LUKvi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Dec 2012 05:51:38 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC9CE80@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Loic PALLARDY STE <loic.pallardy-ext@stericsson.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Gutierrez, Juan" <jgutierrez@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Contreras <felipe.contreras@nokia.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Tejun Heo <tj@kernel.org>, "Anna, Suman" <s-anna@ti.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kern>



On 12/21/2012 11:28 AM, Bedia, Vaibhav wrote:
> On Tue, Dec 18, 2012 at 18:40:08, Loic Pallardy wrote:
>> TX: replace spin by mutex
>> RX: replace spin_lock_irq by spin_lock_irqsave
>>
>
> Can you please add a short note on why this is being done?
>
Ok I'll add more information in commit message in next version.

Regards,
Loic

> Regards,
> Vaibhav
>