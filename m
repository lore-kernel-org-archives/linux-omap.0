From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] video: omap2: dss: RET on idle, enable/disable dss
 clocks 	only when needed.
Date: Thu, 24 Sep 2009 13:39:23 +0300
Message-ID: <1253788763.17009.282.camel@tubuntu>
References: <1253230586-931-1-git-send-email-mike@android.com>
	 <1253262472.28956.10.camel@tubuntu>
	 <8bb80c380909181033s2fd5e3a1o16404f1667760b25@mail.gmail.com>
	 <1253514408.4690.5.camel@tubuntu> <877hvrf2sj.fsf@deeprootsystems.com>
	 <1253690451.14841.40.camel@tubuntu>  <87my4lbr86.fsf@deeprootsystems.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18707 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZIXKjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 06:39:35 -0400
In-Reply-To: <87my4lbr86.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: ext Mike Chan <mike@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-09-23 at 17:44 +0200, ext Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:
> 
> > On Tue, 2009-09-22 at 16:54 +0200, ext Kevin Hilman wrote:
> >> Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:
> >> 
> >> > Hi,
> >> >
> >> > On Fri, 2009-09-18 at 19:33 +0200, ext Mike Chan wrote:
> >> >> On Fri, Sep 18, 2009 at 1:27 AM, Tomi Valkeinen
> >> >> <tomi.valkeinen@nokia.com> wrote:
> >> >> > Hi,
> >> >> >
> >> >> > If you disable the clocks to allow RET, you also allow OFF mode. And
> >> >> > resuming from OFF mode hasn't been implemented for DSI, if I recall
> >> >> > right. And when I was testing it, it didn't seem to be trivial with the
> >> >> > DSI PLL.
> >> >> >
> >> >> 
> >> >> You can limiting the pwrdm next state to RET when being called from cpuidle.
> >> >
> >> > No, you _must_ limit it to RET. Otherwise the DSI will break down. So we
> >> > can either keep the dsi code as it is now, or explicitely disable OFF
> >> > mode and then apply your patch. But your patch alone won't work.
> >> 
> >> Or could add a hack to this patch so that 'enable_off_mode' doesn't
> >> affect DSS_MOD until DSS has off-mode support.
> >
> > Is this something that the driver can do with the current PM API? The
> > thing is, most of the DSS has off-mode support, only DSI and RFBI is
> > missing the support. So optimally we would allow full PM normally, but
> > when DSI display is in use, only allow RET.
> 
> There's not an official API for this, but for testing, you could just
> set the next state for the DSS_MOD to be off.  This would be overridden
> whenever someone changes the enable_off_mode flag.
> 
> In general, we don't want drivers restricting states at that level.
> We'd rather the drivers use the OMAP PM layer to define/declare its
> constraints.

If I want to disable OFF mode for DSS with constraints, doesn't it mean
that I need to dig out a magic number, and use it as the max wakeup
latency, and that latency will then limit DSS from going to OFF mode?

> 
> >> 
> >> > In the long run I think we anyway need to somehow dynamically manage the
> >> > power state. I haven't measured it but I believe resuming from OFF will
> >> > have a bit of a penalty, as (I think) DSI PLL etc. will have to
> >> > reinitialized. But it would still be good to allow RET whenever
> >> > possible, and OFF only after some period of inactivity.
> >> 
> >> This is the purpose of latency constraints.  These can be used when
> >> the latency of going OFF will cause a problem.
> >
> > I think this is a different problem. My understanding of the PM latency
> > functionality is that they control how quickly MPU responds to
> > interrupts, or how quickly the HW module is awake after clk_enable().
> 
> That's only part of the story.
> 
> > The problem here is that there's bunch of DSI initialization that needs
> > to be done after the DSS module has woken up. The DSI PLL needs to be
> > configured and locked, complex IO has to be configured etc. I don't know
> > how long those take (should make some measurements at some point), but I
> > imagine they are not anywhere near instant. And the latency from those
> > things is what I'm concerned about. So it would be beneficial if the DSS
> > driver could define easily what DSS PM level is allowed.
> 
> Actually, the OMAP PM layer is meant to handle device wakeup latencies
> as well.  See Documentation/arm/OMAP/omap_pm, and the
> set_max_dev_wakeup_lat() hook in particular.
> 
> For example, if you know that DSS wakeup from OFF takes X usecs and
> the driver has set a max device wakeup latency < X, then DSS will
> never go to OFF.  The same can be done to prevent RET for even faster
> wakeup.

The doc says "set_max_dev_wakeup_lat() function to constrain the device
wakeup latency (from clk_enable() to accessibility)". I understood
"accessibility" meaning that the HW registers can be accessed, and also
as registers should be accessible after clk_enable(), it would mean that
clk_enable will block at most the defined wakeup latency.

If it is not like that, and the driver initialization is included, how
does the PM layer know how long it takes for the DSS driver to
reconfigure the DSS hardware from OFF mode?

 Tomi


