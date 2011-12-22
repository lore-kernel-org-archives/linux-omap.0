From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v2 1/7 v2] ARM: OMAP1: ams-delta: register latch dependent
 devices later
Date: Thu, 22 Dec 2011 13:08:12 +0200
Message-ID: <4EF30F9C.7030708@bitmer.com>
References: <201112200028.32947.jkrzyszt@tis.icnet.pl> <201112212051.13113.jkrzyszt@tis.icnet.pl> <20111221200728.GG24444@atomide.com> <201112221139.16317.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:42530 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149Ab1LVLI4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 06:08:56 -0500
In-Reply-To: <201112221139.16317.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On 12/22/2011 12:39 PM, Janusz Krzysztofik wrote:

>>> Don't we need Jarkko's or Mark's or Liam's ack as well for the change to
>>> the sound/soc/omap/ams-delta.c file?
>>
>> Yes, you're right.
>
> Jarkko, Mark or Liam, care to ack this change, moving the Amstrad Delta
> sound card registration to late_initcall?
>
Unfortunately I haven't had time to look at the series but I'm fine with 
sound/soc/omap/ams-delta.c change.

-- 
Jarkko
