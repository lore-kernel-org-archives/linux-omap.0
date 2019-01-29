From: Tony Lindgren <tony@atomide.com>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Date: Tue, 29 Jan 2019 09:18:46 -0800
Message-ID: <20190129171846.GD5720@atomide.com>
References: <20190129164813.GA5720@atomide.com>
 <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
 <20190129171151.GC5720@atomide.com>
 <20190129171538.GH10524@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129171538.GH10524@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [190129 17:15]:
> On Tue, Jan 29, 2019 at 09:11:51AM -0800, Tony Lindgren wrote:
> 
> > OK. Let's see if Sebastian spots where pwm_vibrator_start()
> > and pwm_vibrator_stop() might get called multiple times
> > or something similar.
> 
> Given that nobody has noticed that the driver stops working entirely
> it's possible that the pattern is something like:
> 
> 
>     pwm_vibrator_start()
>     pwm_vibrator_stop()
>     pwm_vibrator_stop()
>     pwm_vibrator_start()
> 
> so it's a temporary underflow that gets corrected (or it could be that
> not many people are using mainline kernels on these systems).  On your
> system it's the dummy driver but presumably some other users have it
> connected to actual regulators.

Yeah that makes sense.

Regards,

Tony
