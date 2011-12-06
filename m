From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC][PATCH 1/1] OMAP: voltage: add a hook for normal regulator
 calls
Date: Tue, 6 Dec 2011 04:21:41 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D12143039515@DBDE01.ent.ti.com>
References: <1321547303-21807-1-git-send-email-vaibhav.bedia@ti.com>
	<B5906170F1614E41A8A28DE3B8D12143032D30@DBDE01.ent.ti.com>
	<87iplymwwi.fsf@ti.com>
	<B5906170F1614E41A8A28DE3B8D121430391C2@DBDE01.ent.ti.com>
 <87sjkykfb9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56872 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932880Ab1LFEVv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 23:21:51 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pB64LmUc015726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 5 Dec 2011 22:21:50 -0600
In-Reply-To: <87sjkykfb9.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kattekola, Ravikumar" <rk@ti.com>

On Tue, Dec 06, 2011 at 00:37:38, Hilman, Kevin wrote:
[...]
> >
> > We want to use the existing OMAP implementation of cpufreq (and DVFS) on 
> > the devices which do not have VC/VP.
> >
> > The current OMAP cpufreq code under drivers/ invokes clk_set_rate().
> >
> > We had a look at the future DVFS implementation for OMAP[1] and merged in 
> > the relevant patches (hope this is close to what's planned).
> 
> Unfortunately, that implementation is not what's planned, and in fact
> was rejected some time ago.

That's really unfortunate :(

> 
> > After this change, cpufreq invokes omap_device_scale(). The DVFS code
> > makes use of the OPP layer and adds a request for voltage and frequency
> > change. However, the voltage change request expects the scaling to be done
> > in scaling functions defined in the voltage layer (vc->scale or vp->scale)
> >
> > On devices which do not have VC/VP, instead of just hacking the current
> > implementation to get the voltage scaling done, we thought of adding
> > a separate path.
> 
> A much better path for SoCs without VC/VP is to simply modify the
> CPUfreq driver to use the regulator API to scale voltage before calling
> clk_set_rate() (if scaling up) and after scaling the frequency (if
> scaling down.)

I assume this needs to be done using the OPP library?

> 
> In fact, that is the direction we're going for DVFS, even for VC/VP
> platforms.  There will be a regulator driver which will call the
> voltagedomain/VC/VP calls to scale the voltage when needed, so from a
> DVFS perspective, you use the clock API to change frequency, and the
> regulator API to change voltages.

Wouldn't this end up adding OMAP specific code into the various regulator
drivers? If TPS65910 gets used on a variant that has VC/VP, won't this
require making changes in the regulator drivers to being with?

> 
> This should be a much simpler approach for you, and much easier to
> understand.

Yes, making calls to the regulator and clock frameworks is much simpler
and desirable.

Regards,
Vaibhav 

