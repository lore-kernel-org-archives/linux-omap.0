From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP4: hwmod data: do not enable or reset the
 AESS during kernel init
Date: Fri, 4 Jan 2013 21:27:41 +0100
Message-ID: <50E73B3D.4010705@ti.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com> <1357304526-21557-3-git-send-email-s-guiriec@ti.com> <alpine.DEB.2.00.1301041833510.25868@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42841 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133Ab3ADU1v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 15:27:51 -0500
In-Reply-To: <alpine.DEB.2.00.1301041833510.25868@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

On 01/04/2013 07:35 PM, Paul Walmsley wrote:
> Hi Sebastien
>
> On Fri, 4 Jan 2013, Sebastien Guiriec wrote:
>
>> The AESS on OMAP4 has additional register on top of SYS_CONFIG for
>> auto gatting configuration. In order to avoid running clock after
>> boot up we should avoid to enable and reset the module during boot up.
>>
>> Audio driver will be in charge of configuring the addition register.
>>
>> At its core, this patch is a workaround for an OMAP hardware problem.
>> It should be possible to configure the OMAP with good default reset
>> configuration of AESS IP for auto gatting mode.
>>
>> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
>
> What do you think about a slightly modified and updated version of:
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69853.html

This solution is the better. I was thinking that Tony reject this 
callback (but I realize that I miss the second series long time back).

Paul,
Do you want me to rebase this version and update the serie or are you 
handle it?

>
> ?  That way we can reset the IP block at startup, like most of our other
> IP blocks, to avoid previous OS and bootloader dependencies.

Yes can be useful.

>
>
> - Paul
>

