From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v3] SoC Camera: add driver for OMAP1 camera interface
Date: Mon, 4 Oct 2010 17:35:44 +0200
Message-ID: <201010041735.46371.jkrzyszt@tis.icnet.pl>
References: <201009301335.51643.jkrzyszt@tis.icnet.pl> <201010021445.14567.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1010030439550.15920@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:44554 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756287Ab0JDPg0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:36:26 -0400
In-Reply-To: <Pine.LNX.4.64.1010030439550.15920@axis700.grange>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

Sunday 03 October 2010 04:42:53 Guennadi Liakhovetski napisa=C5=82(a):
> On Sat, 2 Oct 2010, Janusz Krzysztofik wrote:
> > Saturday 02 October 2010 08:07:28 Guennadi Liakhovetski napisa=C5=82=
(a):
> > > Same with this one - let's take it as is and address a couple of
> > > clean-ups later.
> >
> > Guennadi,
> > Thanks for taking them both.
> >
> > BTW, what are your intentions about the last patch from my series s=
till
> > left not commented, "SoC Camera: add support for g_parm / s_parm
> > operations", http://www.spinics.net/lists/linux-media/msg22887.html=
 ?
>
> Yes, taking that one too, thanks. I see it right, that I have to appl=
y 3
> of your patches: omap1 camera driver, ov6650 and default .[gs]_fmt fo=
r
> soc_camera, the rest will go via the OMAP / ARM tree, right?

Right.
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
