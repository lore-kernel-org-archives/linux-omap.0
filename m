From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/PATCH v3 00/13] PM QoS: add a per-device latency constraints class
Date: Fri, 29 Jul 2011 23:46:21 +0200
Message-ID: <201107292346.22211.rjw@sisk.pl>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com> <CAORVsuVoJ5-1hx2+6+gCuuWDd9A9h_RTS=U1228BM7EYiG=gxA@mail.gmail.com> <20110729142459.GA5509@gvim.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34841 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917Ab1G2Vpj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 17:45:39 -0400
In-Reply-To: <20110729142459.GA5509@gvim.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: markgross@thegnar.org
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

On Friday, July 29, 2011, mark gross wrote:
> On Fri, Jul 29, 2011 at 10:37:52AM +0200, Jean Pihet wrote:
> > Mark,
> > 
> > On Thu, Jul 28, 2011 at 3:14 PM, mark gross <markgross@thegnar.org> wrote:
> > > On Thu, Jul 28, 2011 at 10:30:07AM +0200, jean.pihet@newoldbits.com wrote:
> > >> From: Jean Pihet <j-pihet@ti.com>
> > >>
> > >> This patch set is in an RFC state, for review and comments.
> > >>
> > >> High level implementation:
> > >>
> > ...
> > 
> > >> 7. Misc fixes to improve code readability:
> > >> . rename of the PM QoS implementation file from pm_qos_params.[ch] to pm_qos.[ch]
> > > I picked the name for the file as pm_qos_params over pm_qos because I
> > > wanted to make it implicitly clear that this was not an full QOS
> > > implementation.  True QOS carries expectations similar to real time and
> > > as the infrastructure is closer to "good intentioned" than even "best
> > > effort" and offers no notification when the QOS request is not able to
> > > be met and really doesn't implement a true QOS at all, (it just provides
> > > the parameter interface for part of one its missing the notification
> > > interface when the service level is not met and I think a few other
> > > things.) So I wanted to have it named a bit different from just pm_qos.
> > >
> > > This said I'm not supper attached to the naming of the modules.  If
> > > folks want to change it I wouldn't complain (too much anyway;).
> > Ok got the idea. I do not know what name to chose though. As suggested
> > previously the name pm_qos_params does not reflect the implementation,
> > that is why I renamed it.
> 
> I must have missed the part where the name doesn't reflect the
> implementation was talked about.  I look at the interface and I see
> parameters all over the place and a small bit of notification.

The interface is for specifying PM QoS requirements or constraints that
may or may not be regarded as "parameters", depending on ones definition
of the last term.  Moreover, the code not only implements the interface,
but also defines data structures and API to be used throughout the kernel
which is quite a bit more than just "parameters".

In my not so humble opinion the name isn't good and the .c file should be
in kernel/power in the first place.  I would call it simply qos.c (the fact
that _right_ _now_ it's not a full QoS implementation doesn't matter, because
it may become one in the future).

Thanks,
Rafael
