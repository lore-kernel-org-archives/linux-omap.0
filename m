From: Neil Brown <neil@brown.name>
Subject: Re: [PATCH 03/13] twl4030_charger: correctly handle -EPROBE_DEFER from devm_usb_get_phy_by_node
Date: Wed, 02 Sep 2015 08:19:52 +0200
Message-ID: <87si6x4a2f.fsf@notabene.neil.brown.name>
References: <20150730001113.4012.18086.stgit@noble> <20150730001124.4012.31980.stgit@noble> <CAMAWPa__hFOuz24YBcFiR+m5mOUArSuNpuqh3Ju1H+yj6qadfA@mail.gmail.com> <CAMAWPa_s2ELgRBRtWzFucmREMuLXS_V5Akmad5yFU13-GrzBDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMAWPa_s2ELgRBRtWzFucmREMuLXS_V5Akmad5yFU13-GrzBDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, lkml <linux-kernel@vger.kernel.org>, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Tyler Baker <tyler.baker@linaro.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain

Kevin Hilman <khilman@kernel.org> writes:

> ping... this boot failure has now landed in mainline

sorry, I'm on leave at the moment and travelling so I'm unlikely to be
able to look at this properly.  I should be able to examine this issue
before the end of the month but cannot promise sooner than that (though
it is not impossible).

Maybe it would be best to just revert it until a proper analysis can be
done.

NeilBrown


>
> On Thu, Aug 27, 2015 at 1:51 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> On Wed, Jul 29, 2015 at 5:11 PM, NeilBrown <neil@brown.name> wrote:
>>> Now that twl4030_bci_probe can safely return -EPROBE_DEFER,
>>> do so when devm_usb_get_phy_by_node returns that error.
>>>
>>> Signed-off-by: NeilBrown <neil@brown.name>
>>
>> This patch has hit linux-next in the form of coommit 3fc3895e4fe1
>> (twl4030_charger: correctly handle -EPROBE_DEFER from
>> devm_usb_get_phy_by_node) and kernelci.org found a regression on
>> omap3-beagle-xm[1].  Bisecting[2] this boot failure pointed at this
>> commit, and I verified that reverting it on top of next-20150827 gets
>> the board booting again.  I haven't debugged any further.
>>
>> Kevin
>>
>> [1] http://storage.kernelci.org/next/next-20150827/arm-omap2plus_defconfig/lab-khilman/boot-omap3-beagle-xm.html
>> [2] https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/88/console

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5pUJAAoJEDnsnt1WYoG56VsP/Rg4zvP6mCB+Ongc051q9xeW
7MAtzQdzmdQ8XYGfvQcPWiS1O9Q+Dut1ImABOql4j7jdoFssGB8sZK4/UxuNaGY4
okA0vAdoeUtRNmscsbmby3/tJA/hXe9enG/zmkS6/83zLpKfeYJmdnDP8riPbw0k
nDUm7NgPUXjhdlvPOsmFQfeNR8ouYADJhxfDmLY9g+Ksd6qi8UegXSQmvQDX+y+P
gtohtrDsvHiuDhUl5m5nW6iEopynitrxCe8ANVdLKIyZ/fyypAN10f5jC8uDlsBF
NuF4kNPqzCIsGnmx90IjLIxFXqa5PlNFQ3U1vgKjbhC/HSFULkVVCoQSqHJYu0S/
c3O4z8F7NmpslIaQ8Vpc/80HSdvjkuusRlr0FDL4XlG4u/sz86sTlWaT4NEaGWcj
leDGW4SanmlrOMPjrrrPOEZ+4VyPjPaNore3rI9k0sIN6zws/NKhImu44+HjzRLf
2YPXdTNYTX22CmUUFkXCemfz39kyL+hrtqt+oI37olmbKG519SIBVIUA6HlpEKIQ
h4ukWwotSBHn33b19o10RHOOPPTtS5RZrH1rvGnLRrdkQvGq3Lrlyu8XznmG3CYz
IVZ0/gtsvrLgPLssWf2Cbhk4tkGNTTUOlwAk8vTC6eSZ3G+TdDmOTdVGPT2BBm1v
VvriLMcQQ2hFFgm9KFuW
=rTBz
-----END PGP SIGNATURE-----
--=-=-=--
