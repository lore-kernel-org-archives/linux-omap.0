From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 1/3] ASoC: Add GPIO support for
	jack	reporting interface
Date: Mon, 2 Mar 2009 15:16:22 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECC77862@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
	<20090226115243.GC4229@sirena.org.uk>
	<2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com>
	<20090227130502.GA4415@sirena.org.uk>
	<2C7D3DF36ADFFC479B44490D912B616705ECC77374@dlee07.ent.ti.com>
	<20090302113845.GA19744@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090302113845.GA19744@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> > Could we leave the actual implementation of this report function to
> > the machine driver? Since the things being done in detection function
> > are common (even if other status are wanted to be updated), then
> > probably machine driver could define a specific function ("action")
> > for doing extra tasks, it can be called from generic gpio detect
> > function. Could it be a valid approach?

> That sounds like adding a callback for power updates on the jack itself
> to me (which isn't a bad idea), rather than changing the report function
> of the jack detection method.  The need for machine-specific extra
> actions probably isn't specific to jacks that are detected via GPIOs.

In that situation, power updates should come only when the jack reporting
bits are either all active (jack enabled) or none (jack disabled), is that
correct?

If so, then machine drivers can create callbacks receiving the soc_codec
the jack belongs to and the current state of the jack. All the power updates
(dapm_enable_pin/damp_disable_pin) will happen in the callback in machine
driver but the dapm sync will happen in soc jack framework (i.e. when
reporting current status of the jack).

-Misa
