From: Tejun Heo <tj@kernel.org>
Subject: Re: Re: Re: Re: [PATCH v4 11/18] input: Add initial support for
 TWL6040 vibrator
Date: Tue, 14 Jun 2011 10:18:36 +0200
Message-ID: <20110614081836.GG8141@htj.dyndns.org>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
 <8556714.NHVg2d8yTv@barack>
 <20110614073130.GF8141@htj.dyndns.org>
 <4476185.bf2jyafmHt@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43486 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1FNISl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 04:18:41 -0400
Content-Disposition: inline
In-Reply-To: <4476185.bf2jyafmHt@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>

Hello,

On Tue, Jun 14, 2011 at 10:51:35AM +0300, P=E9ter Ujfalusi wrote:
> On Tuesday 14 June 2011 09:31:30 Tejun Heo wrote:
> > Thanks for the explanation.  I have a couple more questions.
> >=20
> > * While transferring data from I2C, I suppose the work item is full=
y
> >   occupying the CPU?
>=20
> Not exactly on OMAP platforms at least. We do not have busy looping i=
n low=20
> level driver (we wait with wait_for_completion_timeout for the transf=
er to be=20
> done), so scheduling on the same CPU can be possible.
>=20
> >   If so, how long delay are we talking about?
> >   Millisecs?
>=20
> It is hard to predict, but it can be few tens of ms for one device, i=
f we have=20
> several devices on the same bus (which we tend to have), and they wan=
t to=20
> read/write something at the same time we can see hundred(s) ms in tot=
al - it=20
> is rare to happen, and hard to reproduce, but it does happen for sure=
=2E
> =20
> > * You said that the if one task is accessing I2C bus, the other wou=
ld
> >   wait even if scheduled on a different CPU.  Is access to I2C bus
> >   protected with a spinlock?
>=20
> At the bottom it is using rt_mutex_lock/unlick to protect the bus.
> And yes, the others need to wait till the ongoing transfer has been f=
inished.

I see, so IIUC,

* If it's using mutex and not holding CPU for the whole duration, you
  shouldn't need to do anything special for latency for other work
  items.  Workqueue code will start executing other work items as soon
  as the I2C work item goes to sleep.

* If I2C work item is burning CPU cycles for the whole duration which
  may stretch to tens / few hundreds millsecs, 1. it's doing something
  quite wrong, 2. should be marked WQ_CPU_INTENSIVE.

So, if something needs to be modified, it's the I2C stuff, not the
vibrator driver.  If I2C stuff isn't doing something wonky, there
shouldn't be a latency problem to begin with.

Thank you.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
