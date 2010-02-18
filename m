From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv3 1/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 15:56:03 +0200
Message-ID: <201002181556.03245.peter.ujfalusi@nokia.com>
References: <1266496635-31347-1-git-send-email-ilkka.koskinen@nokia.com>
	<1266496635-31347-2-git-send-email-ilkka.koskinen@nokia.com>
	<20100218152413.11d0189a.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100218152413.11d0189a.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On Thursday 18 February 2010 15:24:13 ext Jarkko Nikula wrote:
> On Thu, 18 Feb 2010 14:37:14 +0200
> =

> Ilkka Koskinen <ilkka.koskinen@nokia.com> wrote:
> >  static inline void __devexit omap34xx_device_exit(struct omap_mcbsp
> >  *mcbsp) {
> > =

> > -	if (cpu_is_omap34xx())
> > +	if (cpu_is_omap34xx()) {
> > =

> >  		omap_additional_remove(mcbsp->dev);
> > =

> > +
> > +		if (mcbsp->id =3D=3D 2 || mcbsp->id =3D=3D 3)
> > +			omap_st_remove(mcbsp);
> > +	}
> > =

> >  }
> =

> Are you sure about these ids? Same comment to the patch 2 as well.
> Worth to check.

They are correct.
mcbsp->id is 1 based (1 -> McBSP1, 2 -> McBSP2, etc)
While the exported functions expect the id to
be 0 based (0 -> McBSP1, 1 -> McBSP2, etc)

But, yes it is confusing at times...

-- =

P=E9ter
