From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v9 01/25] gpio/omap: remove dependency on gpio_bank_count
Date: Mon, 6 Feb 2012 08:40:45 +0200
Message-ID: <20120206064043.GB15652@legolas.emea.dhcp.ti.com>
References: <20120202215350.GB22888@legolas.emea.dhcp.ti.com>
 <4F2B078B.1040709@ti.com>
 <20120202220744.GA23092@legolas.emea.dhcp.ti.com>
 <87liojajs4.fsf@ti.com>
 <20120204160802.GA10818@legolas.emea.dhcp.ti.com>
 <CA+HSevqvHAgA+PPLm8BH5vfWkc8yY8W+fRpqjT2urq2EWtSYiA@mail.gmail.com>
 <20120205090805.GA13300@legolas.emea.dhcp.ti.com>
 <CAMQu2gyNhEJ3vr7_o_xYAQOYKaRofJViobKtfH2HoxwgU7nUpw@mail.gmail.com>
 <20120205113521.GA13533@legolas.emea.dhcp.ti.com>
 <CAMQu2gzaQ+uHGpu-mpEPaxFim4_yRayKw_XBPBUgu7ML7daR2w@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5717961165278793069=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMQu2gzaQ+uHGpu-mpEPaxFim4_yRayKw_XBPBUgu7ML7daR2w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, tony@atomide.com, linux-kernel@vger.kernel.org, balbi@ti.com, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org, "Varadarajan, Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============5717961165278793069==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 05, 2012 at 06:05:37PM +0530, Shilimkar, Santosh wrote:
> On Sun, Feb 5, 2012 at 5:05 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Sun, Feb 05, 2012 at 02:46:19PM +0530, Shilimkar, Santosh wrote:
> >> >> bank->mod_usage check is used to take care of doing pm_runtime_get*=
/put* only
> >> >> if all the GPIOs in a particular bank are enabled or disabled respe=
ctively.
> >> >
> >> > and why should you care about that ? The first get will enable the
> >> > resources you need, the second get will just increase a counter and =
so
> >> > on. So if you have 32 gets, you will disable the module when you hav=
e 32
> >> > puts.
> >> >
> >> Am not sure if it is clear to you that the GPIO resources like clock,
> >> debounce clk are per bank wise and not per GPIO line. So doing 32
> >
> > this is just one more reason to have usage counters.
> >
> >> get/put per bank is stupid. runtime pm is for managing pm
> >
> > what's stupid is trying to use the pm usage counters as a binary flag,
> > see below.
> >
> >> resources and if the pm resource is per bank, it has to be
> >> handled per bank.
> >
> > hehe, what are you talking about Santosh ? That's the whole point of
> > reference counting. If there are 32 users for 1 resource, you want to
> > make sure that you only free the resources (clocks, or whatever resource
> > you want) after all 32 users are done with it.
> >
> > Trying to use the pm usage counter as a binary flag, that's the stupid
> > part of the OMAP GPIO driver.
> >
> > Instead of adding checks such as:
> >
> > if (module_isnt_used())
> > =A0 =A0 =A0 =A0enable_clocks();
> >
> > on get and:
> >
> > if (module_isnt_needed_anymore())
> > =A0 =A0 =A0 =A0disable_clcoks()
> >
> > on put is the most useless piece of code on that driver. Because such
> > checks are already available on PM core through usage counters. The way
> > that part of the code works is as follow:
> >
> > get() {
> > =A0 =A0 =A0 =A0if (pm_counter_is_zero(dev)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0atomic_inc();
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rpm_resume();
> > =A0 =A0 =A0 =A0}
> > }
> >
> > put() {
> > =A0 =A0 =A0 =A0atomic_dec();
> >
> > =A0 =A0 =A0 =A0if (pm_counter_is_zero(dev)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rpm_suspend();
> > =A0 =A0 =A0 =A0}
> > }
> >
> > Do you not see that you're duplicating functionality by trying to use
> > the pm counter a binary flag ?
> >
> Ahh.. Now I see your point. I miss-understood the point first time
> and thought that we have disconnect on the pm resources from
> number of GPIO perspective.
>=20
> What you are saying is to use pm runtime reference counters rather
> than creating local ones for GPIO which seems to be right thing to
> do. Sorry for the noise.

no problem.

> The agressive clock cutting was tried initially without much success
> and may be we can revisit this one more time.

I think one issue will be wrt to IRQ handling. If you want pm_runtime_*
calls to be irq_safe, they will keep the parent always on, so we need to
find a way to make that part work properly, I guess.

> As per as this series is concerned, we would like to fix
> the build error pointed by Kevin and queue it for 3.4.

sure, go ahead. No problems with that at all.

--=20
balbi

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL3XrAAoJEIaOsuA1yqREOq8P/AzOCM/5gxB+UkGfKDuQBZlu
cFetrv4T4pSeCuW5+yyBGEtLatTMArAYcWOU83u5yZKrjnQxFkg1DquvptRwqXdD
kr6ccJZElwW0Eqokka+YlcFGTRWSrUM7AcUfcaPBVtaflEHpcgg1ebEUifsp95hB
VaGrqvx/RP0W+9CLAT/taybU22saYUihvn+hGTOqHW4i07dqWLbZ5n0AYMF1PvlJ
/4uFqUfxhiiUVXQP3E3+4gFGCYGf+b9Dgszusxda1SKU9QDJ6ff1FHtoZgz8rmNg
3TUeAsulRTpZj31Lbi2un7O4oJb3/hHCEUNwd7VhGkPC8Je2LsXooW4+Mb8zUHVm
zxQBXLh2GuVk57NWd6E3kvurlG0YpGS+DOF8FMxgXL6Lfv1s3cE9SdaZY2A6mwCN
HL6S0SgJOCoWl63g+qncLFnVKXHHKdxSt1F/j1Z/Q5tvJ2HbMhUjJ5cFQn/n278N
vETUE4AnyqMxGgI/gyzWfiuJBVTsl2X5FOj5TEmfm9T7Y+JXVyj3xkR2+8md8HNr
fQ/7azwIvo6nV26ehwvVU9/YJwGOW9rO+FTc9wC86XWBaaM8PiDrWllpNvO6Hffp
cfoEF9G9z/mKJ58w/1umzfi8IsnnN2ScJD8ROPNxSGqgeDLnoQ9tOYIUH3uPJxu2
W7XOApgIuOJXH7VtPAzm
=Dfh5
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--


--===============5717961165278793069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5717961165278793069==--
