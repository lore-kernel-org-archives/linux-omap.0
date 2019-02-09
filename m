From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 4/4] i2c: core: introduce master_xfer_irqless callback
Date: Sat, 9 Feb 2019 19:03:35 +0100
Message-ID: <20190209180335.hmdlqf45kw64mbvn@ninjato>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-5-wsa+renesas@sang-engineering.com>
 <20181018104446.GM6920@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2324045989677792949=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181018104446.GM6920@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, linux-i2c@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, preid@electromag.com.au, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============2324045989677792949==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l6zl2xstp3grxwt4"
Content-Disposition: inline


--l6zl2xstp3grxwt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russell,

I know this has been quite a while. I didn't have further time for this
topic back then. But now I am going to revive and rework it. Still,
thank you for your input.

On Thu, Oct 18, 2018 at 11:44:46AM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 20, 2018 at 06:14:23PM +0200, Wolfram Sang wrote:
> > We had the request to access devices very late when interrupts are not
> > available anymore multiple times now. Mostly to prepare shutdown or
> > reboot. Allow adapters to specify a specific callback for this case.
> > Note that we fall back to the generic master_xfer callback if this new
> > irqless one is not present. This is intentional to preserve the previous
> > behaviour and avoid regressions. Because there are drivers not using
> > interrupts or because it might have worked "accidently" before.
>=20
> It's not really about "irqless", it's about being in atomic context.
> irqless makes it sound like you may sleep, but the reality is sleeping
> is also out (the scheduler needs IRQs to do it's job.)
>=20
> So, it may be tempting to use things like msleep() in "irqless" but
> that's not permissable.  So surely "atomic" would be a better name for
> this?

Full ack. It should be 'master_xfer_atomic'.

> Also, how does this get around the issue which I pointed out with (eg)
> an oops occuring, which leads to a panic followed by an attempt to
> reboot if the I2C bus in question is already mid-transaction?  Won't
> we deadlock?

Interesting question with multiple aspects:

- The above setting will cause problems but this is orthogonal to this
  patch. It works by modifying __i2c_transfer() but all the locking logic
  is one layer above in i2c_transfer(). So, there shouldn't be a
  difference.

- We won't deadlock, because I2C core will use trylock in this case.
  However, even reporting -EAGAIN won't be helpful because the
  interrupted transfer is likely to never finish without irqs. So,
  retrying won't help and we are still stuck.

- Brainstorming: we could decide that if in_atomic() and
  master_xfer_atomic() present and the I2C client is allowed to do
  ATOMIC_IO (and maybe more checks), to ignore the locking and force
  this command on the bus. Also requiring master_xfer_atomic() to reset
  the IP core properly, etc. Probably also enforcing i2c_recover_bus()
  to ensure a free bus. This is probably the best we could do, but
  still no guarantees here. Some I2C devices just lock up when
  interrupted at the wrong time.

Relying on I2C for poweroff/reboot is a somewhat fragile design to begin
with. I will re-start this series with something simple, but keep the
above scenario in mind. Then, we can see how much we can do, hopefully.

And I got the idea for a panic-fault-injector which sounds interesting.
I will try that!

Kind regards,

   Wolfram

>=20
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/i2c/i2c-core-base.c |  6 +++++-
> >  include/linux/i2c.h         | 10 +++++++---
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 904b4d2ebefa..f827446c3089 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -1887,7 +1887,11 @@ int __i2c_transfer(struct i2c_adapter *adap, str=
uct i2c_msg *msgs, int num)
> >  	/* Retry automatically on arbitration loss */
> >  	orig_jiffies =3D jiffies;
> >  	for (ret =3D 0, try =3D 0; try <=3D adap->retries; try++) {
> > -		ret =3D adap->algo->master_xfer(adap, msgs, num);
> > +		if ((in_atomic() || irqs_disabled()) && adap->algo->master_xfer_irql=
ess)
> > +			ret =3D adap->algo->master_xfer_irqless(adap, msgs, num);
> > +		else
> > +			ret =3D adap->algo->master_xfer(adap, msgs, num);
> > +
> >  		if (ret !=3D -EAGAIN)
> >  			break;
> >  		if (time_after(jiffies, orig_jiffies + adap->timeout))
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index 65b4eaed1d96..11e615123bd0 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -498,6 +498,8 @@ i2c_register_board_info(int busnum, struct i2c_boar=
d_info const *info,
> >   * @master_xfer: Issue a set of i2c transactions to the given I2C adap=
ter
> >   *   defined by the msgs array, with num messages available to transfe=
r via
> >   *   the adapter specified by adap.
> > + * @master_xfer_irqless: same as master_xfer. Yet, not using any inter=
rupts
> > + *   so e.g. PMICs can be accessed very late before shutdown
> >   * @smbus_xfer: Issue smbus transactions to the given I2C adapter. If =
this
> >   *   is not present, then the bus layer will try and convert the SMBus=
 calls
> >   *   into I2C transfers instead.
> > @@ -511,9 +513,9 @@ i2c_register_board_info(int busnum, struct i2c_boar=
d_info const *info,
> >   * be addressed using the same bus algorithms - i.e. bit-banging or th=
e PCF8584
> >   * to name two of the most common.
> >   *
> > - * The return codes from the @master_xfer field should indicate the ty=
pe of
> > - * error code that occurred during the transfer, as documented in the =
kernel
> > - * Documentation file Documentation/i2c/fault-codes.
> > + * The return codes from the @master_xfer{_irqless} field should indic=
ate the
> > + * type of error code that occurred during the transfer, as documented=
 in the
> > + * Kernel Documentation file Documentation/i2c/fault-codes.
> >   */
> >  struct i2c_algorithm {
> >  	/* If an adapter algorithm can't do I2C-level access, set master_xfer
> > @@ -524,6 +526,8 @@ struct i2c_algorithm {
> >  	   processed, or a negative value on error */
> >  	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >  			   int num);
> > +	int (*master_xfer_irqless)(struct i2c_adapter *adap,
> > +				   struct i2c_msg *msgs, int num);
> >  	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr,
> >  			   unsigned short flags, char read_write,
> >  			   u8 command, int size, union i2c_smbus_data *data);
> > --=20
> > 2.18.0
> >=20
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20
> --=20
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbp=
s up
> According to speedtest.net: 11.9Mbps down 500kbps up

--l6zl2xstp3grxwt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxfFfIACgkQFA3kzBSg
KbYtYQ/6AkePVz4PczsGrZ9xlTQE4SWBGUnbLsK54HPXSsYxW8TsfHaorH5p8iNb
MpjF3SdT5oXmmLgEmp96RP1alCR61O+TLDhxzxGkZTtdTpnGxacZ7lhop0u2Rtq/
+q1R3jrDbeOCsMzdS2m3sl2M6uba5B1ovKJzei8IX87LtkSxvSvu0tujB+L4jkwS
UoZMbYYKwpDbDmO9R8QmF9wGI/eR5sxl5CnVFcqepJZbazIXIbqs9Exskp/NCH9o
9LydDonsYO39mz3kW2EoCGXS/1JvFta/X6Wdom0mdxs3ZUOvZO+DH6GmmtS/LaOp
L5f2ASfc9ZSWwaZN9kkDp6aSrZW35KIr67q62TwldCyMEYfGHPy7ezrEi/Di3S2m
EFGzfdVwtZJiX6ZuZafan59nMcRu4EfB63w+cJETmWRC/1IOZER6BK9e9E5JQ8G9
WLNM0Cq8ar0YoBZLi6dEvlidN6zv8Ppn8duKXW2FWb7UVbm5KnBpqv14D4fSwbjY
X8xwBX16yaNthwjopHKg6hIHrcq2QVnq9Pl/z7YYG5ZyqUxBTb8D5VKl8Ou4heni
1J8FiWB8vwkJ1EeFtEIJE2XjoBjHYMd33F9J3Y7OTzSxaZ5g6SsALZxn5Bd+41O4
OotNnd5svC4ZWmzrJDoGVg4Z60XsxmK8Nik0VmL7B4sjR5xlGEM=
=lfwN
-----END PGP SIGNATURE-----

--l6zl2xstp3grxwt4--


--===============2324045989677792949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2324045989677792949==--
