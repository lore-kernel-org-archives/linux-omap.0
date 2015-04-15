From: Tero Kristo <t-kristo@ti.com>
Subject: Re: AM335x OMAP2 common clock external fixed-clock registration
Date: Wed, 15 Apr 2015 09:34:48 +0300
Message-ID: <552E0688.1020903@ti.com>
References: <20150414211734.GA28974@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50590 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964835AbbDOGet (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 02:34:49 -0400
In-Reply-To: <20150414211734.GA28974@deathray>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, gregkh@linuxfoundation.org
Cc: Daniel Mack <daniel@zonque.org>

On 04/15/2015 12:17 AM, Michael Welling wrote:
> Greetings,
>
> I have developed an AM3354 based SoM and it uses an external SI5351 clock
> generator to drive the clock inputs for an external duart and I2S audio
> master clock. With the registration according to the documentation the
> reference clock is not being detected and hence the clock generator is
> not working as expect.
>
> After trying many different things, I started to look around the mailing
> lists to find information related to this issue.
>
> I came acrossed post that has the exact same issue:
> https://lkml.org/lkml/2013/2/18/468
>
> Seeing as the patch did not land upstream, I am wondering if there is
> a solution that I am not seeing.
>
> I am willing to provide a patch given appropriate guidance.

Hi Michael,

The info on the email you referenced is kind of obsolete, TI SoCs are 
calling of_clk_init() during boot now, and thus external clock nodes 
should be registered fine also. Maybe you can provide the actual DTS 
patch you are trying out so we can help better...? Are you seeing any 
boot time error / warning prints for your new clock?

-Tero
