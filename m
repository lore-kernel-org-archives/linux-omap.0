From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PM-SR] [PATCH 5/7] omap3: sr: device: add unlikely checks
Date: Fri, 09 Jul 2010 17:15:27 +0300
Message-ID: <1278684927.9953.119.camel@localhost>
References: <1277502400-9915-1-git-send-email-nm@ti.com>
	 <1277502400-9915-6-git-send-email-nm@ti.com>
	 <1278681148.9953.110.camel@localhost>  <4C3726C9.7010002@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33925 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab0GIOUd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 10:20:33 -0400
In-Reply-To: <4C3726C9.7010002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>

On Fri, 2010-07-09 at 08:40 -0500, Nishanth Menon wrote:
> Artem Bityutskiy had written, on 07/09/2010 08:12 AM, the following:
> > On Fri, 2010-06-25 at 16:46 -0500, Nishanth Menon wrote:
> >> Add unlikely checks to better optimize the rare occurrance of
> >> erroneous conditions.
> >>
> >> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> >> Cc: Thara Gopinath <thara@ti.com>
> >>
> >> Signed-off-by: Nishanth Menon <nm@ti.com>
> >=20
> > unlikely and friends make sens only in realy hot path places. In ot=
her
> > places like you touch, they are pointless - better let gcc make a c=
hoice
>=20
> > @@ -43,8 +43,9 @@ static void __init sr_read_efuse(struct omap_sr_d=
ev_data *dev_data,
> >  {
> >  	int i;
> > =20
> > -	if (!dev_data || !dev_data->volts_supported || !dev_data->volt_da=
ta ||
> > -			!dev_data->efuse_nvalues_offs) {
> > +	if (unlikely(!dev_data || !dev_data->volts_supported ||
> > +			!dev_data->volt_data ||
> > +			!dev_data->efuse_nvalues_offs)) {
>=20
> > @@ -87,8 +88,8 @@ static void __init sr_set_testing_nvalues(struct =
omap_sr_dev_data *dev_data,
> >  {
> >  	int i;
> > =20
> > -	if (!dev_data || !dev_data->volts_supported ||
> > -			!dev_data->volt_data || !dev_data->test_nvalues) {
> > +	if (unlikely(!dev_data || !dev_data->volts_supported ||
> > +			!dev_data->volt_data || !dev_data->test_nvalues)) {
>=20
> and other places, why do you think that these are checks that should =
be=20
> expected? - would be great if you can explain inline to the patch whi=
ch=20
> unlikely checks dont make sense.
>=20
> static functions such as these are helpers for the maincode, unless=20
> something horribly wrong occurs within the codepath calling these=20
> helpers, they are not expected to be invalid parameters. hence the=20
> rationale for adding unlikely.

Sorry, I do not really understand you. All I said is that
unlikely()/likely() are usually used in hot-paths / tight loops.

unlikely()/likely() are micro optimization. They make no difference whe=
n
you use them in initialization paths.

So what I said, that in your patch they will make no difference
performance wise. So no benefits.

But they make if () statements a bit more difficult to read, this is a
drawback.

So your patch introduces no benefits, just a drawback. Thus, it is not
good.

There were many flamewars about unlikely and likely in lkml in the past=
=2E
And the outcome was always - do not use them anywhere except of
performance-critical tight loops / hot paths.


--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
