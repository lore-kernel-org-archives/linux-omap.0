From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Tue, 14 Jun 2011 05:40:09 -0700
Message-ID: <20110614124009.GC23145@atomide.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com>
 <201106081051.27234.peter.ujfalusi@ti.com>
 <20110613133542.GD3352@atomide.com>
 <27857936.rzNg0PjYWH@barack>
 <20110614150530.87e594a5.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:61209 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752264Ab1FNMkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 08:40:14 -0400
Content-Disposition: inline
In-Reply-To: <20110614150530.87e594a5.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

* Jarkko Nikula <jhnikula@gmail.com> [110614 04:59]:
> On Tue, 14 Jun 2011 14:19:34 +0300
> P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>=20
> > We have discussion ongoing about the mcbsp code move, and so far th=
e current=20
> > understanding/plan is (Jarkko/Liam correct me if I'm wrong):
> > - Fix the OMAP4 support
> > - move the code under sound/soc/omap/
> >  - the reason for this is that McBSP block can be only used for str=
eaming type=20
> > of modes (from omap2430 onwards McBSP does not have clock stop func=
tionality).
> > This makes other type of usage hard to say the least.
> > - Clean up the code (remove the SPI mode, remove unused code paths =
at the same=20
> > time)
> > - Consolidate the interface for audio only use
>=20
> Yeah, now is perfect time to tell if there is any need for something
> else than audio.
>=20
> OMAP1xxx/59xx and 2420 are already something like more
> than 5 years old obsolete components and we haven't seen that any of
> them would need SPI/clock stop functionality. Actually we haven't see=
n
> any other use for McBSP than audio.

Yes this sounds OK to me. So the order to do things should be:

- Fix issues
- Remove unused code
- Move to drivers
- Add new features as needed
=20
> > - Only OMAP3 has sidetone (on OMAP2 EAC block has the sidetone), mi=
ght need=20
> > some change, but I think the current way can be reused.
> >=20
> Yeah, they probably need work on kernel side (hwmod stuff etc) but I
> think for keeping userspace intact over the cleanup we might want to
> keep these special sysfs nodes for sidetone filter coefficients, dma
> operating mode and FIFO threshold as it over the cleanup.

Also related is the sound/soc/omap mess that should not be doing
any platform level stuff at all but instead get the configuration
in platform data and device tree data eventually. Just grep for
platform_set_drvdata in sound/soc/omap to see it..

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
