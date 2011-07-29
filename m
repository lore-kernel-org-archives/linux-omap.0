From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Fri, 29 Jul 2011 17:02:11 +0300
Message-ID: <20110729140210.GT31013@legolas.emea.dhcp.ti.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
 <20110729095512.GE31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
 <20110729113713.GK31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
 <20110729121907.GM31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4wQqS64xG0Vi9YCOdy3f2=1V7UkJCErpikHOra4X=g7+w@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eu12+zRL7gQwOC+E"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAL8m4wQqS64xG0Vi9YCOdy3f2=1V7UkJCErpikHOra4X=g7+w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: balbi@ti.com, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--eu12+zRL7gQwOC+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2011 at 06:28:32PM +0530, Govindraj wrote:
> On Fri, Jul 29, 2011 at 5:49 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Jul 29, 2011 at 05:29:12PM +0530, Govindraj wrote:
> >> Yes fine, But there are scenarios even before first runtime_suspend ha=
ppens,
> >>
> >> ex: uart_port_configure -> get_sync -> pm_generic_runtime_resume
> >> (omap_device_enable in this case) debug printk -> console_write -> get=
_sync.
> >>
> >> there are numerous such scenarios where we end from runtime context
> >> to runtime api context again, or jumping from one uart port operation
> >> to uart print operation.
> >
> > calling pm_runtime_get_sync() should not be a problem. It should only
> > increase the usage counters... This sounds like a race condition on the
> > driver, no ?
>=20
> Actually when we call a API to enable clocks we except the internals of A=
PI
> to just enable clocks and return.
>=20
> *Clock enable API should not cause or trigger to do a _device_driver_oper=
ation_
> even before enabling clocks of the device-driver which called it*
>=20
> for uart context get_sync can land me to uart driver back
> even before enabling the uart clocks due to printks.

only if _you_ have prints or _your_ runtime_*() calls, no ?

Let's say omap_hwmod.c wants to do a print:

-> printk()
  -> pm_runtime_get_sync
    -> console_write
  -> pm_runtim_put

now, if you have a printk() on your runtime_resume() before you enable
the clocks, then I can see why you would deadlock:

-> pm_runtime_get_sync
  -> omap_serial_runtime_resume
    -> printk
      -> pm_runtime_get_sync
        -> omap_serial_runtime_resume
	  -> printk
	   -> pm_runtime_get_sync
	    .....

maybe I'm missing something, but can you add a stack dump on your
->runtime_resume and ->runtime_suspend methods, just so we try to figure
out who's to blame here ?

> > What you're experiencing, if I understood correctly, is a deadlock ? In
> > that case, can you try to track the locking mechanism on the omap-serial
> > driver to try to find if there isn't anything obviously wrong ?
> >
>=20
> Yes deadlocks. due to entering from runtime context to runtime context
> or entering from uart_port_operation to uart_console_write ops.
>=20
> There are already port locks used extensively within the uart driver
> to secure a port operation.
>=20
> But cannot secure a port operation while using clock_enable API.
> since clock enable API can land the control back to uart_console_write
> operation..

but in that case, if clock isn't enabled, why don't you just ignore the
print and enable the clock ?? Just return 0 and continue with
clk_enable() ??

> >> So either we should not have those prints from pm_generic layers or su=
ppress
> >> them(seems pretty much a problem for a clean design within the driver
> >> using console_lock/unlock for every get_sync, and for
> >> runtime_put we cannot suppress the prints as it gets scheduled later)
> >>
> >> or if other folks who really need those prints form pm_generic* layers
> >> to debug and analysis then we have no other choice rather control
> >> the clk_enable/disable from outside driver code in idle path.
> >
> > yeah, none of these would be nice :-(
> >
> > I think this needs more debugging to be sure what's exactly going on.
> > What's exactly causing the deadlock ? Which lock is held and never
> > released ?
> >
>=20
> I had done some investigations, from scenarios it simply boils down to fa=
ct
> to handle clock within uart driver, uart driver expects clock enable API*=
 used
> to just enable uart clocks but rather not trigger a _uart_ops_ within whi=
ch
> kind of unacceptable from the uart_driver context.

ok, now I see what you mean:

113 static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
114 {
115         struct timespec a, b, c;
116
117         pr_debug("omap_device: %s: activating\n", od->pdev.name);
118
119         while (od->pm_lat_level > 0) {
120                 struct omap_device_pm_latency *odpl;
121                 unsigned long long act_lat =3D 0;
122
123                 od->pm_lat_level--;
124
125                 odpl =3D od->pm_lats + od->pm_lat_level;
126
127                 if (!ignore_lat &&
128                     (od->dev_wakeup_lat <=3D od->_dev_wakeup_lat_limit))
129                         break;
130
131                 read_persistent_clock(&a);
132
133                 /* XXX check return code */
134                 odpl->activate_func(od);
135
136                 read_persistent_clock(&b);
137
138                 c =3D timespec_sub(b, a);
139                 act_lat =3D timespec_to_ns(&c);
140
141                 pr_debug("omap_device: %s: pm_lat %d: activate: elapsed=
 time "
142                          "%llu nsec\n", od->pdev.name, od->pm_lat_level,
143                          act_lat);
144
145                 if (act_lat > odpl->activate_lat) {
146                         odpl->activate_lat_worst =3D act_lat;
147                         if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJU=
ST) {
148                                 odpl->activate_lat =3D act_lat;
149                                 pr_warning("omap_device: %s.%d: new wor=
st case "
150                                            "activate latency %d: %llu\n=
",
151                                            od->pdev.name, od->pdev.id,
152                                            od->pm_lat_level, act_lat);
153                         } else
154                                 pr_warning("omap_device: %s.%d: activat=
e "
155                                            "latency %d higher than expt=
ected. "
156                                            "(%llu > %d)\n",
157                                            od->pdev.name, od->pdev.id,
158                                            od->pm_lat_level, act_lat,
159                                            odpl->activate_lat);
160                 }
161
162                 od->dev_wakeup_lat -=3D odpl->activate_lat;
163         }
164
165         return 0;
166 }

When that first pr_debug() triggers, UART's hwmod could be disabled, and
that would trigger the state I described above where you would keep on
calling pm_runtime_get_sync() forever ;-)

isn't it enough to patch it like below:

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_dev=
ice.c
index b6b4097..560f622 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -114,8 +114,6 @@ static int _omap_device_activate(struct omap_device *od=
, u8 ignore_lat)
 {
        struct timespec a, b, c;
=20
-       pr_debug("omap_device: %s: activating\n", od->pdev.name);
-
        while (od->pm_lat_level > 0) {
                struct omap_device_pm_latency *odpl;
                unsigned long long act_lat =3D 0;
@@ -162,6 +160,8 @@ static int _omap_device_activate(struct omap_device *od=
, u8 ignore_lat)
                od->dev_wakeup_lat -=3D odpl->activate_lat;
        }
=20
+       pr_debug("omap_device: %s: activated\n", od->pdev.name);
+
        return 0;
 }
=20

either the above or something like:

if (pm_runtime_suspended(dev))
	return 0;

on console_write() ??

--=20
balbi

--eu12+zRL7gQwOC+E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMr1iAAoJEAv8Txj19kN1zo0IAI+du5hemqUp5zWsjLQmKcE7
tBtM4zz6gj0VxMFSTYvtuTOfFT6qvdugwwProDyUK5sEL3edw4wyBYNYjTKp2ddk
WqZyXQ6wVN24f5boMsKlXY+sNOfyQIsnG1DzaznJixrJqb6H/oAgPFPATfQDmMx1
CDYupy9N0QeXUpWD/FKFA/aTtVoiRw3DvSjP7bhqFhEvWBV1aXOGkkaeIDl0TLdb
4w9mKEbLuUWZeQtXiRLofoS6nJupuqwISg/njNvUAbAJVa3oiWLL6rumGVHJNJcF
8lQF+JqsIsXf8j7kvBNijNx75NH/l+Hg+NBr2BNNR/aP42LKzxIOeTIh0/4RA0s=
=eDQf
-----END PGP SIGNATURE-----

--eu12+zRL7gQwOC+E--
