From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/8] mfd: twl6040: Add initial support
Date: Fri, 3 Jun 2011 19:44:26 +0300
Message-ID: <201106031944.26251.peter.ujfalusi@ti.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com>
	<1306927051-8937-5-git-send-email-peter.ujfalusi@ti.com>
	<BANLkTi=3Xw8Ti80oreBiN4_a-=ekDfFM6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <BANLkTi=3Xw8Ti80oreBiN4_a-=ekDfFM6A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Margarita Olaya Cabrera <magi.olaya@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 01 June 2011 16:47:21 Krishnamoorthy, Balaji T wrote:
> > +int twl6040_reg_read(struct twl6040 *twl6040, unsigned int reg)
> > +{
> > +       int ret;
> > +       u8 val =3D 0;
> > +
> > +       mutex_lock(&twl6040->io_mutex);
> > +       ret =3D twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &val, reg);
> =

> Can this dependency on twl_i2c_[read/write] be removed,
> Since TWL6040 is a separate IC which can get its own i2c_client in
> twl6040-core.c and
> create its own mfd devices like vibra, audio-codec ... while creating
> twl6040-core.c

You are right, twl6040 is separate IC.
I'll take a look how it can be separated from the twl-core (twl6030).

Thanks for noticing this, =

P=E9ter
