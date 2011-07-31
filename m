From: mark gross <markgross@thegnar.org>
Subject: Re: [linux-pm] [RFC/PATCH v3 00/13] PM QoS: add a per-device latency
 constraints class
Date: Sun, 31 Jul 2011 10:38:46 -0700
Message-ID: <20110731173846.GA19112@gvim.org>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
 <CAORVsuVoJ5-1hx2+6+gCuuWDd9A9h_RTS=U1228BM7EYiG=gxA@mail.gmail.com>
 <20110729142459.GA5509@gvim.org>
 <201107292346.22211.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:44755 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab1GaRiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Jul 2011 13:38:50 -0400
Received: by pzk37 with SMTP id 37so9953123pzk.1
        for <linux-omap@vger.kernel.org>; Sun, 31 Jul 2011 10:38:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201107292346.22211.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jul 29, 2011 at 11:46:21PM +0200, Rafael J. Wysocki wrote:
> On Friday, July 29, 2011, mark gross wrote:
> > On Fri, Jul 29, 2011 at 10:37:52AM +0200, Jean Pihet wrote:
> > > Mark,
> > > 
> > > On Thu, Jul 28, 2011 at 3:14 PM, mark gross <markgross@thegnar.org> wrote:
> > > > On Thu, Jul 28, 2011 at 10:30:07AM +0200, jean.pihet@newoldbits.com wrote:
> > > >> From: Jean Pihet <j-pihet@ti.com>
> > > >>
> > > >> This patch set is in an RFC state, for review and comments.
> > > >>
> > > >> High level implementation:
> > > >>
> > > ...
> > > 
> > > >> 7. Misc fixes to improve code readability:
> > > >> . rename of the PM QoS implementation file from pm_qos_params.[ch] to pm_qos.[ch]
> > > > I picked the name for the file as pm_qos_params over pm_qos because I
> > > > wanted to make it implicitly clear that this was not an full QOS
> > > > implementation.  True QOS carries expectations similar to real time and
> > > > as the infrastructure is closer to "good intentioned" than even "best
> > > > effort" and offers no notification when the QOS request is not able to
> > > > be met and really doesn't implement a true QOS at all, (it just provides
> > > > the parameter interface for part of one its missing the notification
> > > > interface when the service level is not met and I think a few other
> > > > things.) So I wanted to have it named a bit different from just pm_qos.
> > > >
> > > > This said I'm not supper attached to the naming of the modules.  If
> > > > folks want to change it I wouldn't complain (too much anyway;).
> > > Ok got the idea. I do not know what name to chose though. As suggested
> > > previously the name pm_qos_params does not reflect the implementation,
> > > that is why I renamed it.
> > 
> > I must have missed the part where the name doesn't reflect the
> > implementation was talked about.  I look at the interface and I see
> > parameters all over the place and a small bit of notification.
> 
> The interface is for specifying PM QoS requirements or constraints that
> may or may not be regarded as "parameters", depending on ones definition
> of the last term.  Moreover, the code not only implements the interface,
> but also defines data structures and API to be used throughout the kernel
> which is quite a bit more than just "parameters".
> 
> In my not so humble opinion the name isn't good and the .c file should be
> in kernel/power in the first place.  I would call it simply qos.c (the fact
> that _right_ _now_ it's not a full QoS implementation doesn't matter, because
> it may become one in the future).

Sounds ok to me.

--mark
