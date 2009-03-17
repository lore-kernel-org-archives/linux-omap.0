From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Tue, 17 Mar 2009 11:15:06 -0700
Message-ID: <200903171115.06685.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <200903142105.29382.david-b@pacbell.net> <20090316215422.GA6433@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:24496 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750997AbZCQSPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2009 14:15:09 -0400
In-Reply-To: <20090316215422.GA6433@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Monday 16 March 2009, Mark Brown wrote:
> On Sat, Mar 14, 2009 at 09:05:29PM -0700, David Brownell wrote:
> 
> > was called.  It's not exactly hard to check if it was enabled, then
> > act accordingly, in the typical "single consumer of the regulator"
> > case.
> 
> How typical that is depends very much on the devices you're looking at.

I'd have said "systems you're looking at" ... but so long
as the boot_on flag exists, then this issue can appear with
absolutely any regulator, used for anything.

The basic issue addressed by $SUBJECT patch just restores
internal consistency to the framework, in the face of such
flags (or equivalent actions by the boot loader).


> Devices that need to do things like set voltages are fairly likely to
> own the regulator but with devices that just need to ensure that they
> have their supplies enabled it's much more likely that the supplies will
> be shared.

Right.  Do you have a model how such shared supplies would
coexist with the "enabled at boot time" model, and still
support being disabled?

My first thought is that the system designer should avoid
such boot_on modes.  But that's not always going to work.

- Dave

