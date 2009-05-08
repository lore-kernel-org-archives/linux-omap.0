From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: McBSP in Multi Channel mode
Date: Fri, 8 May 2009 10:38:01 +0300
Message-ID: <200905081038.01470.peter.ujfalusi@nokia.com>
References: <29e1ddd50905071118i28bd16b8ub715cd2b5dafaca8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49228 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbZEHHiN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 03:38:13 -0400
In-Reply-To: <29e1ddd50905071118i28bd16b8ub715cd2b5dafaca8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Fernando Governatore <fergc@uol.com.br>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,


On Thursday 07 May 2009 21:18:34 ext Fernando Governatore wrote:
> Hello,
>
> I'm new to kernel development and so I'm a bit confused on how to do
> things here. I need to use the McBSP with Multi-Channel enabled and
> using DMA to transfer the data.
>
> The data will be PCM sound and I will have 4 cards attached to this
> McBSP. I'm using OMAP35xx.
>
> From what I've seen, I have to change the files:
>  - arch/arm/plat-omap/mcbsp.c
>  - arch/arm/mach-omap2/mcbsp.c
> to support multi channel. Is that it? or I would need more changes?
>
> Is there something that I would need to change in DMA implementation?
> Do you know where I can get an example or documentation?

Take a look at the sound-2.6 tree's topic/asoc branch:
http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dsho=
rtlog;h=3Dtopic/asoc

The omap3beagle has support for 4 channel audio playback (combination o=
f=20
McBSP+TWL4030 codec).
=46iles that could be interesting for you:
sound/soc/omap/omap3beagle.c
sound/soc/omap/omap-mcbsp.c
sound/soc/codecs/twl4030.c

>
> Thanks,
> Fernando

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
