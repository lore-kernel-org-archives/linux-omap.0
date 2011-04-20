From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: The old omapfb support
Date: Wed, 20 Apr 2011 14:31:24 +0300
Message-ID: <1303299084.2102.61.camel@deskari>
References: <1303215626.32281.70.camel@deskari>
	 <20110419123036.GF15620@atomide.com>  <1303216485.27432.7.camel@maggie>
	 <1303216889.32281.80.camel@deskari>  <1303217114.27432.9.camel@maggie>
	 <1303286810.2102.49.camel@deskari>  <1303298280.12837.2.camel@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:34928 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753620Ab1DTLba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 07:31:30 -0400
Received: by mail-wy0-f180.google.com with SMTP id 26so767765wyj.39
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 04:31:28 -0700 (PDT)
In-Reply-To: <1303298280.12837.2.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Tony Lindgren <tony@atomide.com>, lo-ml <linux-omap@vger.kernel.org>

On Wed, 2011-04-20 at 13:18 +0200, Michael B=C3=BCsch wrote:
> On Wed, 2011-04-20 at 11:06 +0300, Tomi Valkeinen wrote:=20
> > > So if you first port the stuff and then add the depends-on OMAP1,=
 I'm
> > > fine with it.
> >=20
> > Does the display even work on N8x0 with mainline kernel? I don't se=
e any
> > code for it in the board file.
>=20
> It needs some additional glue code, which can be found here:
> https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches-2=
=2E6.38/301-nokia-board-additional.patch
> But with that code it works fine.

Ok, thanks. I found an N810 from my HW stash, but as I don't have a
serial adapter for it, kernel work will be rather difficult. I'll port
the display driver, but I'm probably not able to test it at all.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
