From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: expand the description of the
 debug facility
Date: Wed, 7 Oct 2015 13:02:31 +0200
Message-ID: <20151007110231.GL3982@pengutronix.de>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <5614CDAE.6070604@ti.com> <20151007075338.GH3982@pengutronix.de>
 <20151007102822.GT23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151007102822.GT23801@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

On Wed, Oct 07, 2015 at 03:41:19AM -0700, Tony Lindgren wrote:
> * Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [151007 00:57]:
> > On Wed, Oct 07, 2015 at 10:45:50AM +0300, Roger Quadros wrote:
> > > =

> > > How about this instead?
> > > =

> > > NOTE: Apart from matching the register setup with the bootloader you =
also need to
> > > match the GPMC FCLK frequency used by the bootloader else the GPMC ti=
mings
> > > won't be identical with the bootloader timings.
> > Yeah, sounds better, thanks.
> > =

> > > Also you might need to build this patch on top of
> > > http://article.gmane.org/gmane.linux.kernel/2054796
> > I talked to Tony about this patch yesterday on irc, but I didn't find it
> > in the archives yet when I sent my mail.
> =

> Yes sorry here's a repost with your and Roger's changes folded in and
> edited a bit. Probably best to keep them together with this patch.
> =

> Does the following look OK to you guys?
Yes,
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
