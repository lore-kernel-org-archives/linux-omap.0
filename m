From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] i2c-omap: Trigger bus recovery in lockup case
Date: Fri, 29 Sep 2017 14:52:13 +0200
Message-ID: <20170929125213.by5mwverw2a47lmo@earth>
References: <1505403549-12992-1-git-send-email-claudio.foellmi@ergon.ch>
 <9d3e3029-f775-a9aa-8025-badccb699ed8@ti.com>
 <48ddc9bc-2b83-97c9-fbd7-90d4da9f2687@ti.com>
 <0a506277-6c9b-1407-dea3-f9895fdc3e63@ergon.ch>
 <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
 <3778fa75-0327-0c36-1721-e89e23a782b6@ergon.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bru6povnofgkl62s"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3778fa75-0327-0c36-1721-e89e23a782b6@ergon.ch>
Sender: linux-i2c-owner@vger.kernel.org
To: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Vignesh R <vigneshr@ti.com>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--bru6povnofgkl62s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On Tue, Sep 26, 2017 at 02:24:59PM +0200, Claudio Foellmi wrote:
> On 19.09.2017 12:50, Vignesh R wrote:
> >=20
> >=20
> > On Monday 18 September 2017 05:31 PM, Claudio Foellmi wrote:
> >> On 18.09.2017 07:24, Vignesh R wrote:
> >>>
> >>>
> >>> On Saturday 16 September 2017 05:01 AM, Strashko, Grygorii wrote:
> >>>>
> >>>>
> >>>> On 09/14/2017 10:39 AM, Claudio Foellmi wrote:
> >>>>> A very conservative check for bus activity (to prevent interference
> >>>>> in multimaster setups) prevented the bus recovery methods from being
> >>>>> triggered in the case that SDA or SCL was stuck low.
> >>>>> This defeats the purpose of the recovery mechanism, which was intro=
duced
> >>>>> for exactly this situation (a slave device keeping SDA pulled down).
> >>>>>
> >>>>> Note that bus lockups can persist across reboots. The only other op=
tions
> >>>>> are to reset or power cycle the offending slave device, and many i2c
> >>>>> slaves do not even have a reset pin.
> >>>>>
> >>>>> If we see that one of the lines is low for the entire timeout durat=
ion,
> >>>>> we can actually be sure that there is no other master driving the b=
us.
> >>>>> It is therefore save for us to attempt a bus recovery.
> >>>>>
> >>>>
> >>>> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >>>>
> >>>>> Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
> >>>>> ---
> >>>>> Caveat: It turns out I don't have the hardware to fully test the
> >>>>> recovery mechanism. My faulty i2c slave device actually pulls down =
SCL,
> >>>>> not SDA (so the recovery will not succeed in my case).
> >>>
> >>> Maybe, you could detect SCL stuck low case by reading status of SCL l=
ine
> >>> from OMAP_I2C_SYSTEST_REG and then call IP reset (there is nothing mu=
ch
> >>> that can be done) instead of bus recovery.
> >>>
> >>
> >> I plan on posting a related patch soon, that will print better messages
> >> if the generic recovery fails. If SCL is stuck low, I think the best we
> >> can do is make the problem visible in the kernel log.
> >>
> >>>>> But by directly connecting SDA to ground, I could at least make sure
> >>>>> the recovery function gets called after applying this patch.
> >>>>>
> >>>
> >>> I had seen flood of XRDY & RRDY interrupts as soon as TMODE is set to
> >>> 0x3 as part of omap_i2c_prepare_recovery() leading to unusable system.
> >>> Did you observe this behavior on your system? Could you mention the
> >>> platform on which this experiment done?
> >>>
> >>
> >> So attempting bus recovery is dangerous on some platforms?
> >> I did not notice any obvious problems (assuming an 'unusable system'
> >> would be hard to miss), but then again I only have one target to test =
on.
> >> I'm working with a TI AM3352, the slave is a NXP NT3H2211 on i2c-1.
> >>
> >=20
> > I hit a situation where when communicating with a faulty i2c device, the
> > last transaction on the bus does not end with proper STOP condition on
> > the i2c bus. Since, STOP condition was not detected by IP, Bus Busy will
> > remain set even though both SCL and SDA are high. Thus,
> > omap_i2c_wait_for_bb() function would end up calling bus recovery. And
> > as soon as TMODE is set to 0x3 and ST_EN to 0x1, there is a flood of
> > XRDY & RRDY interrupts.
> >=20
> > This spurious irqs can be reproduced easily by setting TMODE to 0x3 and
> > ST_EN to 0x1 in OMAP_I2C_SYSTEST_REG when both SCL and SDA are high (bus
> > is idle) even on AM335x.
> >=20
> > So, if you are not seeing irq flood when SCL/SDA is stuck low, then
> > maybe its safe to enter TMODE 0x3 in such cases. Could you modify the
> > patch to test whether or not SDA is stuck low before initiating bus
> > recovery?
> >=20
>=20
> This sounds more like a problem with the interrupt handler than with
> bus recovery, so I'm a bit hesitant to just add such a workaround.
> Instead, I spent a few hours looking through the interrupt handling
> (and poking my i2c bus with a wire to induce random faults), and
> I suspect to have found the underlying cause, or at least part of it:
>=20
> We sometimes ignore some interrupts (such as RRDY if we think we are
> not in receiving mode), but don't really deal with their cause.
> As a result, the same interrupt will just be raised again as soon as
> we leave the handler. It will then be ignored again, and raised again...
>=20
> I'm still not quite sure how we can reliably get into such situations in
> the first place, but not sending a stop condition seems to be part of it.
> Maybe it is somehow connected to the automatic internal state change
> that happens as part of AL or NACK interrupts.
>=20
>=20
> Below is a small patch that should test my assumptions.
> It clears the incoming fifo and acks the ignored RRDY interrupts.
>=20
> Sebastian, can you please check if this helps with your problems on N950?
> If it does, I'll turn it into a proper standalone patch.

No, it does not. Also no interrupts ignoring messages appearing
in dmesg:

n950# dmesg | grep -E "48072000.i2c|lp5523x"
[    0.791046] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
[    4.934265] lp5523x 1-0032: reset command sent (no ACK)!
[    6.003875] omap_i2c 48072000.i2c: controller timed out
[    6.033874] lp5523x 1-0032: device detection err: -110
[    6.039154] lp5523x: probe of 1-0032 failed with error -110

-- Sebastian

--bru6povnofgkl62s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnOQfoACgkQ2O7X88g7
+pqihRAAmt4MQgrHiWBcJzLPa0Sh/PbnKNS0b9LhjW1ybO5mx8dBuAxPhveWDmvE
wNF/A8QvBfo4HbMM5wLJvIAP8waYxL0zl22856mfZHu8DWnTzRc9veCixUAchAkh
gBzEZtX6LiraMETfW7I13ogcjyuNIddHyIY2MZD82BEXw4s+fOvgP2zpoP26p6p7
mWTxbq4vZ08sKclj0Ib7JXRiXffA3siEu142sTo56jT/T+WkXMF+DBa/B3rdTdJs
LPRI1AbtvGBdD7XC6dj6AhZ8ebZTXu26qyZeTAJdySwWhw3dSkqZ4mCQCw0G8B/X
EnaHvtMG7Gjg7/PaMAO0B/a9DpFHxGIREeg0URePZPRLN6bWvERvb0lDxAbgjCFE
SoGorVjcy+arjpmfDfc+s4r+sd8FKK+/WOn2nNRYf9LCFOXvHJbvqBWabgIT8Z0D
v/qcFpT5pc2G6drDamK1CfPI83vmNHRc8Ws7vpcljaZKObEnjU64KaGTpmIO2wlG
MsoeLurft89IPHORWZHNdL7rLEPIOio/vwK3vz1kBXVDICjp2uiZT0+WdjpiDkC5
OsVQ9zJ57Jcf/9BnUElhcD7UII0IUfrWJT6xOYpQkb+EcTvZ6HzsWXV0WcrQaAoE
8276NQK41QMkPfuOBXsc1GkQR+2zj8EJLWC3/S5pdrETxFlZJ1g=
=7g0y
-----END PGP SIGNATURE-----

--bru6povnofgkl62s--
