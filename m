From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio/omap: fix invalid context restore of gpio bank-0
Date: Sun, 1 Jul 2012 01:45:40 -0700
Message-ID: <20120701084540.GK4202@atomide.com>
References: <1340990551-19426-1-git-send-email-jon-hunter@ti.com>
 <CAMQu2gx+tCujB0a+2zL8RGdJe5Y2VLPOyPUOPkys3VS7JdaKbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56649 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab2GAIpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Jul 2012 04:45:44 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gx+tCujB0a+2zL8RGdJe5Y2VLPOyPUOPkys3VS7JdaKbg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Kevin Hilman <khilman@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Franky Lin <frankyl@broadcom.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120629 21:23]:
> On Fri, Jun 29, 2012 at 10:52 PM, Jon Hunter <jon-hunter@ti.com> wrot=
e:
> > Currently the gpio _runtime_resume/suspend functions are calling th=
e
> > get_context_loss_count() platform function if the function is popul=
ated for
> > a gpio bank. This function is used to determine if the gpio bank lo=
gic state
> > needs to be restored due to a power transition. This function will =
be populated
> > for all banks, but it should only be called for banks that have the
> > "loses_context" variable set. It is pointless to call this if loses=
_context is
> > false as we know the context will never be lost and will not need r=
estoring.
> >
> > For all OMAP2+ devices gpio bank-0 is in an always-on power domain =
and so will
> > never lose context. We found that the get_context_loss_count() was =
being called
> > for bank-0 during the probe and returning 1 instead of 0 indicating=
 that the
> > context had been lost. This was causing the context restore functio=
n to be
> > called at probe time for this bank and because the context had neve=
r been saved,
> > was restoring an invalid state. This ultimately resulted in a crash=
 [1].
> >
> > There are multiple bugs here that need to be addressed ...
> >
> > 1. Why the always-on power domain returns a context loss count of 1=
? This needs
> > =C2=A0 to be fixed in the power domain code. However, the gpio driv=
er should not
> > =C2=A0 assume the loss count is 0 to begin with.
> Indeed. GPIO driver should not assume the value.
>=20
> > 2. The omap gpio driver should never be calling get_context_loss_co=
unt for a
> > =C2=A0 gpio bank in a always-on domain. This is pointless and adds =
unneccessary
> > =C2=A0 overhead.
> Make sense too.
>=20
> > 3. The OMAP gpio driver assumes that the initial power domain conte=
xt loss count
> > =C2=A0 will be 0 at the time the gpio driver is probed. However, it=
 could be
> > =C2=A0 possible that this is not the case and an invalid context re=
store could be
> > =C2=A0 performed during the probe. To avoid this otherwise only pop=
ulated the
> > =C2=A0 get_context_loss_count() function pointer after the initial =
call to
> > =C2=A0 pm_runtime_get() has occurred. This will ensure that the fir=
st
> > =C2=A0 pm_runtime_put() initialised the loss count correctly.
> >
> > This patch addresses issues 2 and 3 above.

Should this one be Cc: stable? If this is a regression, then the regres=
sion
causing commit should be mentioned.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
