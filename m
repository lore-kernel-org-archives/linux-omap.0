From: Maxime Petazzoni <mpetazzoni@mvista.com>
Subject: Re: VDD1 voltage after resume from idle
Date: Fri, 20 Nov 2009 17:29:33 +0100
Message-ID: <20091120162933.GC2354@mvista.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE5BC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hu47.mvista.com ([206.112.117.47]:60447 "HELO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with SMTP id S1753346AbZKTQ31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 11:29:27 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE5BC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

* Premi, Sanjeev <premi@ti.com> [2009-11-20 21:17:04]:

> I am facing a strange problem on OMAP3EVM after resuming from idle.
> When using OPP5, the VDD1 voltage ramps to 1.35V.
>  
> However, when i go thru the idle/wakeup cycle, the voltage never
> ramps back to 1.35V but stays at 1.20V.

I'm seeing some interesting behavior with the OPP values here, too, with
suspend/resume. I'm using SRF based PM and CPUFREQ. Here's what happens:

When changing the CPU frequency through the scaling_setfreq knob of
CPUFREQ, the vdd{1,2}_opp values are updated accordingly. After a
suspend/resume cycles, the OPPs return to their pre-suspend values, all
is fine.

But when changing the OPP values by hand through the vdd{1,2}_opp knobs,
the CPU frequency is changed accordingly, which is expected. But after a
suspend/resume cycle, the OPP values return to the value CPUFREQ set
them to (which may be different than the default OPP values of 3).

Is this the normal behavior? Is cpufreq authoritative on the OPP values
on resume? Or should it follow whatever value was manually set before
suspending?

Thanks,
- Maxime

PS: if I was not clear, I can provide a console log that may be more
explicit--just ask.

-- 
Maxime Petazzoni
Linux kernel & software dev
MontaVista Software, Inc

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksGw+0ACgkQ7KsOe4Pmrg2ATQCfZ7kal3/5VU99NKfAzruGYiTj
K64AoJ/e59oywpc9gZC6AmgueBrf5BsM
=qIaU
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
