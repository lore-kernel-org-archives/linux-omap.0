From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/1] Runtime detection of OMAP35x devices
Date: Fri, 9 Oct 2009 15:18:59 -0700
Message-ID: <20091009221858.GT25892@atomide.com>
References: <1255117668-28109-1-git-send-email-premi@ti.com> <782515bb0910091302k25b162cdk1fce6d4d98287c29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63979 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922AbZJIWTo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 18:19:44 -0400
Content-Disposition: inline
In-Reply-To: <782515bb0910091302k25b162cdk1fce6d4d98287c29@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

* Nishanth Menon <menon.nishanth@gmail.com> [091009 13:22]:
> Sanjeev,
>=20
> On Fri, Oct 9, 2009 at 2:47 PM, Sanjeev Premi <premi@ti.com> wrote:
> > Add runtime check for these OMAP35x variations
> > based on the detected Si features:
> > =A0OMAP3503, OMAP3515, OMAP3525 and OMA3530.
> [sni[]
> > =A0 =A0 =A0 =A0if (hawkeye =3D=3D 0xb7ae) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (rev) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0: /* Take care of early samples=
 */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OM=
AP3430_REV_ES2_0;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rev_name =3D "ES2.0";
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 2:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OM=
AP3430_REV_ES2_1;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rev_name =3D "ES2.1";
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 3:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OM=
AP3430_REV_ES3_0;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rev_name =3D "ES3.0";
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 4:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OM=
AP3430_REV_ES3_1;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rev_name =3D "ES3.1";
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Use the latest kn=
own revision as default */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OM=
AP3430_REV_ES3_1;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rev_name =3D "Unknown=
 revision\n";
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0}
> > -
> > -out:
> > - =A0 =A0 =A0 pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
> > =A0}
> >
> > =A0#define OMAP3_SHOW_FEATURE(feat) =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > @@ -248,6 +240,57 @@ out:
> >
> > =A0void __init omap3_cpuinfo(void)
> > =A0{
> > + =A0 =A0 =A0 u8 rev =3D GET_OMAP_REVISION();
> > + =A0 =A0 =A0 char cpu_name[16], cpu_rev[16];
> > +
> > + =A0 =A0 =A0 /* OMAP3430 and OMAP3530 are assumed to be same.
> > + =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0* OMAP3525, OMAP3515 and OMAP3503 can be detected =
only based
> > + =A0 =A0 =A0 =A0* on available features. Upon detection, update th=
e CPU id
> > + =A0 =A0 =A0 =A0* and CPU class bits.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (omap3_has_iva() && omap3_has_sgx()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(cpu_name, "3430/3530");
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 else if (omap3_has_sgx()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP3525_REV(rev);
>=20
> your patch conflicts with mine unfortunately. could you introduce 36x=
x
> on top of the aligned version for 36xx?
> see http://marc.info/?t=3D125510410600006&r=3D1&w=3D2

I'll push this 35xx patch first as it's been available before 36xx
processors. That way we'll get the ordering right in the changelog :)

Nishant, can you please post your 36xx patch one more time rebased
on this one?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
