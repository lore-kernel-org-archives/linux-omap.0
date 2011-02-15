From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Tue, 15 Feb 2011 23:52:23 +0000
Message-ID: <20110215235222.GL15795@trinity.fluff.org>
References: <1297406718-24147-1-git-send-email-j-keerthy@ti.com> <877hd2xivn.fsf@ti.com> <AANLkTikdDsq0mku6Jakq-cxA3jYYHQ7CL0sjwJ6wzXNh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikdDsq0mku6Jakq-cxA3jYYHQ7CL0sjwJ6wzXNh-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "J, KEERTHY" <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 15, 2011 at 10:13:58AM +0530, J, KEERTHY wrote:
> On Tue, Feb 15, 2011 at 5:35 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> > Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> writes:
> >
> >> From: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
> >>
> >> ProDB00017052 - ARDY interrupt reasserted after being cleared.
> >
> >> This errata caused intermittent i2c instabilty(1 error per 3 hours=
) on several
> >> customer platforms. After applying the workaround the intermittent=
 errors were
> >> not seen. This is not captured in the usual errata documents.
> >
> > This (presumably internal) ProDB number above is meaningless in the
> > public changelog. =A0In lieu of a public erratum number, just summa=
rize
> > the erratum/instability seen, references to other relevant public
> > errata (if any) would be useful too. =A0 IOW, "instability" isn't q=
uite
> > accurate enough. =A0A more detailed description of the problem/inst=
ability
> > is needed.
> >
>=20
> Kevin,
>=20
> Yes the ProDB number is internal. I will remove it from the change lo=
g.
> I will add a more detailed description of the problem.

Leave it in a comment at the most, it might be useful, otherwise please
respond to Kevin's review and then it'll be ready to merge.
=20
> --=20
> Regards and Thanks,
> Keerthy
>=20
>=20
> > Thanks,
> >
> > Kevin
> >
> >>
> >> The workaround is to have a double clear of ARDY status in
> >> irq handler.
> >>
> >> Signed-off-by: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> >> ---
> >> =A0drivers/i2c/busses/i2c-omap.c | =A0 =A03 ++-
> >> =A01 files changed, 2 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2=
c-omap.c
> >> index 445de08..9bcefae 100644
> >> --- a/drivers/i2c/busses/i2c-omap.c
> >> +++ b/drivers/i2c/busses/i2c-omap.c
> >> @@ -851,7 +851,8 @@ complete:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_I2C_STAT_AL)) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev,=
 stat &
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP_=
I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C=
_STAT_XRDY | OMAP_I2C_STAT_XDR));
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C=
_STAT_XRDY | OMAP_I2C_STAT_XDR |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C=
_STAT_ARDY));
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_complete_cmd(=
dev, err);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disapp=
ear.
