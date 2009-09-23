From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] video: omap2: dss: RET on idle, enable/disable dss
 clocks 	only when needed.
Date: Wed, 23 Sep 2009 10:20:51 +0300
Message-ID: <1253690451.14841.40.camel@tubuntu>
References: <1253230586-931-1-git-send-email-mike@android.com>
	 <1253262472.28956.10.camel@tubuntu>
	 <8bb80c380909181033s2fd5e3a1o16404f1667760b25@mail.gmail.com>
	 <1253514408.4690.5.camel@tubuntu>  <877hvrf2sj.fsf@deeprootsystems.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49024 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbZIWHVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 03:21:00 -0400
In-Reply-To: <877hvrf2sj.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: ext Mike Chan <mike@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2009-09-22 at 16:54 +0200, ext Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:
> 
> > Hi,
> >
> > On Fri, 2009-09-18 at 19:33 +0200, ext Mike Chan wrote:
> >> On Fri, Sep 18, 2009 at 1:27 AM, Tomi Valkeinen
> >> <tomi.valkeinen@nokia.com> wrote:
> >> > Hi,
> >> >
> >> > If you disable the clocks to allow RET, you also allow OFF mode. And
> >> > resuming from OFF mode hasn't been implemented for DSI, if I recall
> >> > right. And when I was testing it, it didn't seem to be trivial with the
> >> > DSI PLL.
> >> >
> >> 
> >> You can limiting the pwrdm next state to RET when being called from cpuidle.
> >
> > No, you _must_ limit it to RET. Otherwise the DSI will break down. So we
> > can either keep the dsi code as it is now, or explicitely disable OFF
> > mode and then apply your patch. But your patch alone won't work.
> 
> Or could add a hack to this patch so that 'enable_off_mode' doesn't
> affect DSS_MOD until DSS has off-mode support.

Is this something that the driver can do with the current PM API? The
thing is, most of the DSS has off-mode support, only DSI and RFBI is
missing the support. So optimally we would allow full PM normally, but
when DSI display is in use, only allow RET.

> 
> > In the long run I think we anyway need to somehow dynamically manage the
> > power state. I haven't measured it but I believe resuming from OFF will
> > have a bit of a penalty, as (I think) DSI PLL etc. will have to
> > reinitialized. But it would still be good to allow RET whenever
> > possible, and OFF only after some period of inactivity.
> 
> This is the purpose of latency constraints.  These can be used when
> the latency of going OFF will cause a problem.

I think this is a different problem. My understanding of the PM latency
functionality is that they control how quickly MPU responds to
interrupts, or how quickly the HW module is awake after clk_enable().

The problem here is that there's bunch of DSI initialization that needs
to be done after the DSS module has woken up. The DSI PLL needs to be
configured and locked, complex IO has to be configured etc. I don't know
how long those take (should make some measurements at some point), but I
imagine they are not anywhere near instant. And the latency from those
things is what I'm concerned about. So it would be beneficial if the DSS
driver could define easily what DSS PM level is allowed.

 Tomi


