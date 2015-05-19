From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: rx51: use flags argument of
 devm_gpiod_get to set direction
Date: Tue, 19 May 2015 11:16:50 +0300
Message-ID: <20150519081650.GA8310@bitmer.com>
References: <1432021688-25830-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1432021688-25830-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alexandre Courbot <gnurou@gmail.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 19, 2015 at 09:48:08AM +0200, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for output.
> =

> Use this to simplify the driver. Furthermore this is one caller less
> that stops us making the flags argument to gpiod_get*() mandatory.
> =

> Fixes: 386e81ab3b4d ("ASoC: omap: rx51: get GPIO numbers via gpiod API")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  sound/soc/omap/rx51.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> =

I don't think Fixes tag is justified. Otherwise than that

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com
