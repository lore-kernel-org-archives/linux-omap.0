From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Progress in adding ams-delta support to ASoC?
Date: Thu, 18 Jun 2009 12:02:10 +0300
Message-ID: <200906181202.11414.peter.ujfalusi@nokia.com>
References: <4A1BEBE3.8010306@tis.icnet.pl> <4A37AFA9.4080403@tis.icnet.pl> <4A38F9D6.5000803@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55994 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbZFRJDS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 05:03:18 -0400
In-Reply-To: <4A38F9D6.5000803@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

On Wednesday 17 June 2009 17:12:38 ext Janusz Krzysztofik wrote:
> Janusz Krzysztofik wrote:
> > After all, it is more and more likely that the problem is not dma, =
but
> > mcbsp just not shifting any data for some mysterious reason.
>
> I finally did what I should have already done before: learned about
> dynamic debugging, turned it on and probably got the answer from
> omap_msbsp_dump_reg(): all mcbsp1 register read operations returned
> 0xffff. So it looks like I simply get no acccess to mcbsp1 at all. No=
w I
> wonder if I can close this thread with a conclusion that mcbsp1 on
> opam15xx is simply not yet supported by the mainline kernel that I ha=
ve
> based my work on.

Hmmm, this is quite unexpected.
Can you access to mcbsp2 or 3 registers, or only the mcbsp1 registers a=
re not=20
accessible?
One thing that I have noticed is that the McBSP1 (and 3) is under the D=
SP=20
Public Peripherals, while McBSP2 is under MPU Public Peripherals (in=20
OMAP1510).
I have to check it further what this actually means...

>
> Thanks,
> Janusz

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
