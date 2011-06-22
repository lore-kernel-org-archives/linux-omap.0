From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v6 15/18] ASoC: twl6040: Remove pll and
	headset mode dependency
Date: Wed, 22 Jun 2011 14:39:46 +0300
Message-ID: <9947082.diNasC8ni8@barack>
References: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com>
	<1308663556-29120-16-git-send-email-peter.ujfalusi@ti.com>
	<20110621173505.GC26592@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110621173505.GC26592@opensource.wolfsonmicro.com>
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

Hello Mark,

On Tuesday 21 June 2011 19:35:05 Mark Brown wrote:
> On Tue, Jun 21, 2011 at 04:39:13PM +0300, Peter Ujfalusi wrote:
> > From: Misael Lopez Cruz <misael.lopez@ti.com>
> > =

> > Remove dependency between pll (hppll, lppll) and headset power
> > mode (low-power, high-performance), as headset power mode can
> > be used with any pll.
> =

> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> =

> but you should note that the code has been modified since Misael's
> original version.

Oh.
I did intended to put comments related to the changes has been done to this =

patch. Obviously I forgot to do that.
I did not added your ack to this patch, since I knew that I have changed a =
bit =

more.
Sorry.

-- =

P=E9ter
