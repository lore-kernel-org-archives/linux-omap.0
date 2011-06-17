From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 15/18] ASoC: twl6040: Remove pll and
	headset mode dependency
Date: Fri, 17 Jun 2011 16:04:34 +0300
Message-ID: <3587033.yBnh7UpTkW@barack>
References: <1307983070-2257-1-git-send-email-peter.ujfalusi@ti.com>
	<1307983070-2257-16-git-send-email-peter.ujfalusi@ti.com>
	<20110617132759.GB4951@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110617132759.GB4951@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Friday 17 June 2011 15:27:59 Mark Brown wrote:
> On Mon, Jun 13, 2011 at 07:37:47PM +0300, Peter Ujfalusi wrote:
> > From: Misael Lopez Cruz <misael.lopez@ti.com>
> > =

> > Remove dependency between pll (hppll, lppll) and headset power
> > mode (low-power, high-performance), as headset power mode can
> > be used with any pll.
> =

> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> =

> but...
> =

> > A new control is created to allow headset power mode configuration
> > from userspace. Changing headset power mode during earpiece related
> > usecases is not allowed as earpiece requires HS DAC in HP mode.
> =

> Might be nicer to allow the user to set the control given that you'll
> just ignore the configured value anyway if it's not usable right now.

Yeah, we can allow the change, but skip the register updates for use cases =

when it is not allowed.

I did spot other issue related to this power mode handling: the DAPM event =

handler has been attached to HFDAC, and not to the HSDAC, so the refcountin=
g =

is done for a wrong set of DAC... The HFDACs has no relationship with the =

Earpiece output (it is connected to HSDACL).

-- =

P=E9ter
