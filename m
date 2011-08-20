From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sat, 20 Aug 2011 07:25:44 +0100
Message-ID: <20110820062543.GA5011@opensource.wolfsonmicro.com>
References: <20110819231419.GA3981@sirena.org.uk>
 <Pine.LNX.4.44L0.1108192223230.18944-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51226 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751462Ab1HTGZq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Aug 2011 02:25:46 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1108192223230.18944-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Fri, Aug 19, 2011 at 10:24:19PM -0400, Alan Stern wrote:
> On Sat, 20 Aug 2011, Mark Brown wrote:

> > interfaces and let the subsystem and driver translate these into actual
> > wakeup latency constraints:

> >   https://lists.linux-foundation.org/pipermail/linux-pm/2011-August/032422.html
> >   https://lists.linux-foundation.org/pipermail/linux-pm/2011-August/032428.html

> > This is much easier for users as it translates into something they're
> > actually doing (and in most cases the driver can make it Just Work) and
> > it means that off the shelf applications will end up tuning the system
> > appropriately by themselves.  I'm additionally concerned that if we
> > expose this stuff directly to userspace that's an open invitation to
> > driver authors to not even bother trying to make the kernel figure this
> > stuff out by itself and to instead tie the system together with magic
> > userspace.

> Can you give a couple of examples to illustrate these points?  I think
> it would help a lot to make the conversation more concrete.

Examples of what?  Latency constraints from drivers?  That'd be things
like Kevin listed in the second message linked above - the kernel knows
it needs to wake up within a given time period in order to have time to
do what it needs to do in response to a given wake source such as
filling a buffer before it underflows.
