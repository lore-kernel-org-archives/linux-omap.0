From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Tue, 2 Jun 2015 10:15:25 +0300
Message-ID: <556D580D.1000600@ti.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com> <1433172627-28052-1-git-send-email-t-kristo@ti.com> <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com> <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com> <20150601180429.GA30984@atomide.com> <20150601180658.GB30984@atomide.com> <alpine.DEB.2.02.1506012122050.14902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37286 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbbFBHP3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 03:15:29 -0400
In-Reply-To: <alpine.DEB.2.02.1506012122050.14902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Jeroen Hofstee <linux-arm@myspectrum.nl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06/02/2015 12:26 AM, Paul Walmsley wrote:
> On Mon, 1 Jun 2015, Tony Lindgren wrote:
>
>> * Tony Lindgren <tony@atomide.com> [150601 11:06]:
>>> * Paul Walmsley <paul@pwsan.com> [150601 10:45]:
>>>>
>>>> See for example the "Build warnings from toolchain", "Kernel warnings
>>>> during boot to userspace", "Kernel warnings during PM test", and "Obsolete
>>>> Kconfig symbols" sections here:
>>>>
>>>> http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/README.txt
>>>
>>> OK somehow 3517evm is listed under "skip" there?
>>
>> Oh I see you have two 3517 devices there, never mind.
>>
>> Hmm now I'm wondering what the panda es warnings listed there are..
>
> http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/boot/4430es2panda/4430es2panda_log.txt
>
> Looked to me like an OMAP4430 ES2.2 bug.  I recall discussing it with
> someone with an ES2.3 Pandaboard and they said it didn't show up.  So I
> asked TI at the time if there was an erratum for it; apparently not.  So I
> think we may need to add in another hardware bug workaround flag to the
> OMAP integration code...
>
> - Paul
>

Don't know about pandaboard ES2.2, but this doesn't show up on SDP4430 
es2.3 at least. Do you know which clockdomain is in question there? It 
could just be a race someplace in the usecounting system that shows up 
on that specific SoC.

-Tero

