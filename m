From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 00/62] Add definition for GPIO direction
Date: Tue, 5 Nov 2019 15:30:25 +0200
Message-ID: <20191105133025.GR32742@smile.fi.intel.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
 <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "semi.malinen@ge.com" <semi.malinen@ge.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "david.daney@cavium.com" <david.daney@cavium.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "ptyser@xes-inc.com" <ptyser@xes-inc.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "marek.behun@nic.cz" <marek.behun@nic.cz>, "festevam@gmail.com" <festevam@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "jonathanh@nvidia.com" <jonathan>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 05, 2019 at 02:10:38PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Nov 05, 2019 at 12:54:55PM +0000, Vaittinen, Matti wrote:
> > On Tue, 2019-11-05 at 14:20 +0200, Andy Shevchenko wrote:
> > > I would also like to see bloat-o-meter statistics before and after
> > > your patch.
> > > My guts tell me that the result will be not in the favour of yours
> > > solution.
> > =

> > Can you please tell me what type of stats you hope to see? I can try
> > generating what you are after. The cover letter contained typical +/-
> > change stats from git and summary:
> > =

> > 62 files changed, 228 insertions(+), 104 deletions(-)
> =

> I guess he wants to see
> =

> 	scripts/bloat-o-meter vmlinuz.old vmlinuz

Yes, but be sure you have compiled them all and build them all in.
Otherwise you might get wrong result.

> . I would expect a 0 there. I didn't look in detail, but in general I
> like the idea to give 0 and 1 a symbolic name.

I'll will be fine with that if and only if maintainers are okay. For now,
I don't like the idea to trade bad for worse.

-- =

With Best Regards,
Andy Shevchenko
