From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/7] mfd: twl4030-power: Fix hang on reboot if sleep
 configuration was loaded earlier
Date: Tue, 20 May 2014 18:55:28 +0100
Message-ID: <20140520175528.GB1458@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-2-git-send-email-tony@atomide.com>
 <20140520150119.GW24991@lee--X1>
 <20140520150748.GD27830@atomide.com>
 <20140520173705.GA1458@lee--X1>
 <20140520174827.GF27830@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35707 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbaETRze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 13:55:34 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so838965iec.1
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 10:55:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140520174827.GF27830@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

> > > > > Looks like we can still hit the issue of wrong load order of
> > > > > twl4030 configuration. If we have a sleep configuration loade=
d,
> > > > > and do a warm reset, the device can hang while initializing t=
he
> > > > > wakeup12 sequence. We do have a warning message about wrong o=
rder
> > > > > of twl4030 configuration, but in this case it does not help a=
s
> > > > > the sleep configuration was loaded during the previous boot a=
nd
> > > > > the state of twl4030 is maintained throughout the warm reset.
> > > > >=20
> > > > > Fix the issue by clearing any existing sleep configuration
> > > > > before we load the warm reset configuration.
> > > > >=20
> > > > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > > ---
> > > > >  drivers/mfd/twl4030-power.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > >=20
> > > > Can't vouch for the semantics of the patch, but the code looks =
good.
> > > >=20
> > > >   Acked-by: Lee Jones <lee.jones@linaro.org>
> > > >=20
> > > > Can I just apply this, or would you like Peter to review it fir=
st?
> > >=20
> > > As far as I'm concerned you can go ahead an apply, it's been
> > > floating on the list for a while and Peter is probably busy
> > > with other things.
> >=20
> > No problem.  Just a couple of things for you to look at in the othe=
r
> > patches, then we can go ahead and apply for v3.16.
>=20
> OK thanks yeah saw those. Will fix them up and test today. Then
> maybe you can apply them to the immutable branch we set earlier
> or I can send you a pull request against that branch whichever
> you prefer.

Probably be easier if I update and re-tag the original one.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
