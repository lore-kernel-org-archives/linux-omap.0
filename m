From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg
 access
Date: Wed, 14 Oct 2009 16:01:06 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF737@dbde02.ent.ti.com>
References: <1255512629-14323-1-git-send-email-charu@ti.com>
 <ce9ab5790910140252q14d2d8a6xd02bf12ae58bf260@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53470 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932349AbZJNKbr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 06:31:47 -0400
In-Reply-To: <ce9ab5790910140252q14d2d8a6xd02bf12ae58bf260@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimal.newwork@gmail.com>, "Varadarajan, Charu Latha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of vimal singh
> Sent: Wednesday, October 14, 2009 3:23 PM
> To: Varadarajan, Charu Latha
> Cc: linux-omap@vger.kernel.org; Syed, Rafiuddin
> Subject: Re: [PATCH] OMAP3: Fix McBSP poll read and write for=20
> 32bit reg access

> >
> > =A0 =A0 =A0 =A0base =3D mcbsp->io_base;
> > =A0 =A0 =A0 =A0/* if frame sync error - clear the error */
> > - =A0 =A0 =A0 if (readw(base + OMAP_MCBSP_REG_SPCR1) & RSYNC_ERR) {
> > + =A0 =A0 =A0 if (OMAP_MCBSP_READ(base, SPCR1) & RSYNC_ERR) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* clear error */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(readw(base + OMAP_MCBSP_REG_SP=
CR1) &=20
> (~RSYNC_ERR),
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0base + OMAP_MCBSP_REG_=
SPCR1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MCBSP_WRITE(base, SPCR1,=20
> OMAP_MCBSP_READ(base, SPCR1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & (~RSYNC_ERR));
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* resend */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;

Return value can be a meaningful macro with proper value?

> > =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* wait for recieve confirmation */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int attemps =3D 0;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(readw(base + OMAP_MCBSP_REG_=
SPCR1)=20
> & RRDY)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (attemps++ > 1000)=
 {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write=
w(readw(base +=20
> OMAP_MCBSP_REG_SPCR1) &
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(~RRST),
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0base + OMAP_MCBSP_REG_SPCR1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(OMAP_MCBSP_READ(base, SPCR1)=
 & RRDY)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (attemps++ > 10000=
) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_=
MCBSP_WRITE(base, SPCR1,
> > + =A0 =A0 =A0=20
=A0 =A0 =A0
Why attemps changed from 1000 to 10000?=20

-Manjunath
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
