From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 12 Jan 2012 09:59:40 +1100
Message-ID: <20120112095940.0a54413e@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/27H=_LxSvzDOg7AGsLtwKNA"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58795 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab2AKW7v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jan 2012 17:59:51 -0500
In-Reply-To: <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, linux-omap@vger.kernel.org

--Sig_/27H=_LxSvzDOg7AGsLtwKNA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jan 2012 06:43:04 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:

> cc Kevin
>=20
> On Tue, 10 Jan 2012, NeilBrown wrote:
>=20
> > It seems that when cpuidle on an omap3 tries to switch to lower power
> > states, various things misbehave:
> >  - UARTs lose characters
>=20
> Is this with off-mode enabled, or is this with only retention idle=20
> enabled?

I haven't experimented with off-mode much.  When I try it the suspend-time
current drain goes from 65mA to about 90mA which doesn't seem the right
direction.  The only other observation is that the "cam" power domain
doesn't reach the target state of '0'.  I'm guessing they are related but
haven't progressed further. (I don't have anything like a camera driver
compiled in - nor do I have a camera attached).

So it is just retention.

I occasionally see evidence of a garbled char when I wake from suspend, but
that doesn't bother me much.

I spent some time exploring why cpuidle never drops below state 0 and found
out that the code explicitly disables other states when uart is active - for
a fairly broad definition of 'active'.

I found the "sleep_timeout" setting and set them all to 1 second.  This mea=
nt
that cpuidle started working, but I got a lot of garbage characters.

>=20
> If off-mode is enabled, and incoming serial traffic is used to wake the=20
> system, it's known and expected that the first byte will be lost.  This i=
s=20
> an artifact of the hardware and seems to be unavoidable.

Does this really mean CPU_IDLE cannot be used when you might expect chars
from a serial port - e.g. GPS or Bluetooth?
Which power domain needs to stay non-off?  I would guess 'CORE' for UART1,2
and 'PER' for UART3,4.  I'm using UART3 for the console port, but it looks
like 'PER' doesn't get switched off by CPUIDLE.

What is the important issue here that I don't know about ? :-)

>=20
> >  - dss loses sync
>=20
> Best to take this up with the DSS maintainer directly.
>=20
> >  - HDQ seems to lose everything.
>=20
> Is this with off-mode enabled, or just with retention idle?

Not off-mode - just retention.

>=20
> If the former, this is hardly surprising as the HDQ driver=20
> (drivers/w1/masters/omap_hdq.c) doesn't contain any context save/restore=
=20
> code.  In fact the HDQ driver doesn't even use PM runtime, so quite a bit=
=20
> of work is needed there.=20

The HDQ driver does enable/disable the iclk and fclk.  I thought I read that
having the clocks enabled would prevent the powerdomain from dropping to a
lower-power state ??

Could you suggest some other driver which does do the right sort of runtime
PM that I could try copying?

Thanks,
NeilBrown


--Sig_/27H=_LxSvzDOg7AGsLtwKNA
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTw4UXDnsnt1WYoG5AQJGwRAAh/LWWMEarFwzkDiv5dFOuHZOYCOirGEU
d4/9kmddx6qMOXTXI92JRPpN80veIvibZ5lX10lKiD3nO23pM4emByi6mPfOaJqq
ZB/I0s31Zg4RAE+3AeoxiiOoQ+Tfx/uUIqLVHxtQRg8gNK2CfN8VJViXMPSzQLop
GW2wXNhZUbTjfcdIz3c7rfEDE5KWivCDCKZ93mSgKWUXE0KYZ7rFbhnUH+KNMAyo
BTLwEZFo6UsqK0CRns8kqpAFfAGtHwJTeby2IPW7wffkLaEpquBao+kqB8FtuRTf
++t9bpgDz/5rJtvS2pUS0UQKSC0n6WtjNjSN6uNaAZIjGtvKZzVaQqHaFMta04XC
7CGt329WP0vFATR25HzBVg8+UumsVsIwv6xfHjqs09VD+CX4Y9E9W3x1WvB63Puu
z+yJ2mEQ+wYbuwCfDMOa/IfZhJf1P9me+crmdR+iWG6nyaa21ZJlXmcmlx5vTZpk
zjYcNx+IytmndTQtopn/+TGFgen7FgzJ2I3KX/g637OqBbE8TikhKwuf0THy9SXw
aTC0G2RCR8IF2m0euRNjV3ePqjLlt0WSmfHMO5jf+km8ofkE3A9RDWgKT3IpXVuD
X1xwVoRNP1ijAiIdVn5PZRN4MvdbqrGQQ86FJ5RfGhCNFDqZCahHL77TcEt9b8MK
QLynfKiqZvM=
=K2At
-----END PGP SIGNATURE-----

--Sig_/27H=_LxSvzDOg7AGsLtwKNA--
