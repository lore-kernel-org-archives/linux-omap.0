From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv4 04/15] omap4: add pmic startup / shutdown times
Date: Wed, 30 Nov 2011 06:20:49 -0600
Message-ID: <CAOMWX4cbVfytPbaZp_F1mVH=Qn4gtcFJ0EKBthhhaP94Xa3R8g@mail.gmail.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
 <1322236188-19456-5-git-send-email-t-kristo@ti.com> <CAOMWX4dfTTd6DHX=RhtymyvMEdfoWWQbATqYqbf2svNYHsQGhw@mail.gmail.com>
 <1322646341.21753.1.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50915 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754103Ab1K3MVM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 07:21:12 -0500
Received: by eaah13 with SMTP id h13so665631eaa.12
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 04:21:10 -0800 (PST)
In-Reply-To: <1322646341.21753.1.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com

On Wed, Nov 30, 2011 at 03:45, Tero Kristo <t-kristo@ti.com> wrote:
>
> On Tue, 2011-11-29 at 12:30 -0600, Menon, Nishanth wrote:
> > On Fri, Nov 25, 2011 at 09:49, Tero Kristo <t-kristo@ti.com> wrote:
> > > Both startup and shutdown take 500us at maximum, value taken from
> > > TWL6030 data manual.
Might be good to add reference version as well for traceability.

> > >
> > > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > > ---
> > > =A0arch/arm/mach-omap2/omap_twl.c | =A0 =A02 ++
> > > =A01 files changed, 2 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2=
/omap_twl.c
> > > index 62ed050..bd99328 100644
> > > --- a/arch/arm/mach-omap2/omap_twl.c
> > > +++ b/arch/arm/mach-omap2/omap_twl.c
> > > @@ -207,6 +207,8 @@ static struct omap_voltdm_pmic omap4_iva_pmic=
 =3D {
> > > =A0static struct omap_voltdm_pmic omap4_core_pmic =3D {
> > > =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> > > =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12660,
> > > + =A0 =A0 =A0 .startup_time =A0 =A0 =A0 =A0 =A0 =3D 500,
> > 549?
>
> Where do you get 549? You looking at a different version of the DM? O=
r
> are you adding something to the value?
>
woohoo.. welcome to TWL6030 doc hell ;)
Data Sheet: 0.05: T on =3D500Usec
*but* TRM 0.1 says T on =3D 500uSec for SMPS  not freq locked, and upto
3ms with SMPS frequency locked).
*then* Functional spec rev 0.12 says "Enable VCORE[1,2,3] =3D 549uSec.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
