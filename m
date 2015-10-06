From: Felipe Balbi <balbi@ti.com>
Subject: Re: cpufreq-dt error: failed to init cpufreq table: -61
Date: Tue, 6 Oct 2015 09:00:31 -0500
Message-ID: <87fv1o3xmo.fsf@saruman.tx.rr.com>
References: <CAAfyv370DFbz9v8URqcipQt-AQ-6du19hf8di2fPeVfTdBzXww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAAfyv370DFbz9v8URqcipQt-AQ-6du19hf8di2fPeVfTdBzXww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Belisko Marek <marek.belisko@gmail.com> writes:
> Hi Tony,
>
> I'm using custom am33xx board where mpu voltage can be changed through
> gpio regulator on 4.1 (latest stable) kernel. I defined gpio-regulator
> node and also operating-points to DT. Gpio regulator seems to be
> working fine but during probing cpufreq-dt I get error:
> failed to init cpufreq table: -61
>
> I did small investigation and seem that dev_pm_opp_init_cpufreq_table
> fails at first condition dev_pm_opp_get_opp_count <=3D 0 and this is
> because opp_list is empty. So it seems that any opp for am33xx aren't
> defined if I'm getting it right. I did look to mach-omap2/opp3xxx_data
> but there is nothing am33xx specific. It is known problem or exist
> some patches around to fix that? Many thanks.

OPP initialization is not in mainline yet, there are some out-of-tree
patches which TI has been working on. If you want to use them, have a
look at TI's vendor kernel at [1]

[1] http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-lsk-linux-4.=
1.y/arch/arm/mach-omap2/opp33xx_data.c

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWE9QBAAoJEIaOsuA1yqREmNYQAJlqorhPBil9dOv0E4J3F/6P
3eEu+aiut797wf9ln4jehBdyaFmAH2hpsVuVVTZVwxVJEC8MeMdaFILT2+KCIgEL
5TNTTngYr+FtiUAhV8bOvmp/6/ADu1oMg1rs2NyrDkzU/+pDt8xn+7TOUcffMga/
TwuXjt4p6wloZOwoFNSN2622Nn0EayedkAB6NPdMv+/sMd6Oc7sL23e70j6gani5
V1VqlwR8axosXTMliQxe4FV/RerhW9IL776uyLj8GAUVeouXXp/p7JRKg65mcClw
d40uLOTKIDOISiDFOJRWGMduj5BeOaj+Gkf+yAaLVJmWUyuvPc0RVLBie2Nb7eMH
S+RbLn4SjCJRaxj0WUxFkXo7PSg/oRfRnid+8+aJfF2NoH9LkFWwLsbE7c/tPSPp
9vMK0R+tUcRmWsvtbeNDkPDJKjWrMRNGl+uXL+gSy1lr1qUd5xcZqN02w5W64AR3
bjou8KrbrRZbIyNfH2gBaRacjkTCNy/UlxPtiBuv7C9G8YT/TfhdDDXvp0jnNe2B
I55PxQs0vGBmBaZRZjL3c6xU3ii1BS3vbbrdF3nsl2VQwot63e1Foo2Q9zPordQi
dklwgMEePt8ChYHrsuknwh3effLEKnw86IwGIzaoIAQFMbQfK3PdOiZDpaLlcSZe
PDLMEqjBmR+exRA75Vqy
=mD53
-----END PGP SIGNATURE-----
--=-=-=--
