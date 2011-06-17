From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 14/18] ASoC: twl6040: Support other
	sample rates in constraints.
Date: Fri, 17 Jun 2011 16:09:47 +0300
Message-ID: <1415474.GAIs6zDgU1@barack>
References: <1307983070-2257-1-git-send-email-peter.ujfalusi@ti.com>
	<1307983070-2257-15-git-send-email-peter.ujfalusi@ti.com>
	<20110617132227.GA4951@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110617132227.GA4951@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Friday 17 June 2011 15:22:27 Mark Brown wrote:
> On Mon, Jun 13, 2011 at 07:37:46PM +0300, Peter Ujfalusi wrote:
> > From: Liam Girdwood <lrg@ti.com>
> > =

> > Add other supported sample rates to LP and HP modes.
> > =

> > Signed-off-by: Liam Girdwood <lrg@ti.com>
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> =

> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> =

> This shouldn't be part of this series as far as I can tell, there's no
> textual link with the rest of it?

I just did not wanted this patch to be buried within another patch.
This patch fixes (completes) the supported sample rates for different power =

modes. I can remove it from the series and send it separately, but I would =

prefer if it is handled together with the rest of the changes.

-- =

P=E9ter
