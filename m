From: Tony Lindgren <tony@atomide.com>
Subject: Re: 5.2-rc1 on droid4: spi crash
Date: Mon, 27 May 2019 06:31:19 -0700
Message-ID: <20190527133119.GK5447@atomide.com>
References: <20190523090926.GA9106@amd>
 <20190523093325.6si5jpvrvyktpax6@earth.universe>
 <20190527055343.GG5447@atomide.com>
 <c741aa5b9d366b231b5c40899b1ef814@webmail.domeneshop.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c741aa5b9d366b231b5c40899b1ef814@webmail.domeneshop.no>
Sender: linux-kernel-owner@vger.kernel.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <notro@tronnes.org>
Cc: Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Noralf Trønnes <notro@tronnes.org> [190527 13:16]:
> 
> 
> Den 2019-05-27 07:53, skrev Tony Lindgren:
> > Hi,
> > 
> > * Sebastian Reichel <sre@kernel.org> [190523 09:33]:
> > > Hi,
> > > 
> > > On Thu, May 23, 2019 at 11:09:26AM +0200, Pavel Machek wrote:
> > > > This was greeting me overnight... I don't yet know how reproducible it
> > > > is, it happened once so far.
> > > 
> > > Please pipe the stacktrace into ./scripts/decode_stacktrace.sh
> > > to get a readable stacktrace, otherwise this is pretty much useless.
> > > FWIW the only SPI device in the Droid 4 is the PMIC.
> > 
> > I've seen this too, and looks like reverting commit c9ba7a16d0f1
> > ("spi: Release spi_res after finalizing message") fixes it based
> > several days of testing.
> > 
> > Noralf and Mark, any ideas what needs to be fixed here?
> 
> Mark has a revert in his for-5.2 branch:
> spi: Fix Raspberry Pi breakage
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-5.2&id=0ed56252c9567351344cb7b5cff6140e1bcec943

Oh OK good to hear.

> I don't know when or if he has sent a pull request.
> Sorry about the breakage.

No worries, thanks for the update.

Regards,

Tony
