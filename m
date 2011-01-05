From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 5 Jan 2011 14:03:26 +0000
Message-ID: <20110105140325.GB746@opensource.wolfsonmicro.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
	<1293509826-23253-2-git-send-email-dlambert@ti.com>
	<20101228141759.GA31883@opensource.wolfsonmicro.com>
	<AANLkTi=k981bx0jjWhJdZmxY8-Uyt=KSB4v0E-uKQ_pL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=k981bx0jjWhJdZmxY8-Uyt=KSB4v0E-uKQ_pL@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lambert, David" <dlambert@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 05, 2011 at 07:56:13AM -0600, Lambert, David wrote:
> On Tue, Dec 28, 2010 at 8:18 AM, Mark Brown

> > A comment explaining why we don't actually do anything with the request
> > would be helpful. =A0Given that we're ignoring the event it'd seem bett=
er
> > to just leave it masked and not take the interrupt in the first place.

> Since the IRQ handler isn't really doing anything in this driver,
> would it better
> to just not have one?

Possibly, if the hardware doesn't care.

> >> + =A0 =A0 =A0 =A0 =A0 =A0 dmic->clk_freq =3D freq;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 default:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dai->dev, "clk freq not supported %d=
\n", freq);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_freq;
> >> + =A0 =A0 }

> > Can't you ask the parent clock what rate it's set to?

> Didn't really think there was a need for that on the audio driver.
> There are clock API's available
> to query that already.

That's my point - you're requiring that the user pass in the rate rather
than querying the clock API.
