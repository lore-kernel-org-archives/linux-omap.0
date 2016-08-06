From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Drop last two remaining omap3 legacy board files
Date: Fri, 5 Aug 2016 23:26:02 -0700
Message-ID: <20160806062601.GM28140@atomide.com>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <20160805174557.GA27448@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160805174557.GA27448@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Russell King <rmk+kernel@armlinux.org.uk>, Pavel Machek <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160805 10:46]:
> Hi Tony,
> 
> On Wed, Jun 15, 2016 at 03:48:07AM -0700, Tony Lindgren wrote:
> > Here are two patches to drop the last remaining omap3 legacy boot
> > files. We have device tree based booting working for these boards,
> > and the legacy booting has been mostly kept around to validate
> > against regressions.
> > 
> > Let's not touch the rest of the platform init code until around
> > v4.9 so we can revert these two patches if needed.
> >
> > Cheers,
> > 
> > Tony
> > 
> > Tony Lindgren (2):
> >   ARM: OMAP2+: Drop legacy board file for n900
> >   ARM: OMAP2+: Drop legacy board file for LDP
> 
> I wonder what happened to these patches. I see, that you have a
> omap-for-v4.8/legacy branch, which contains them. But as far as I
> can see its not in linux-next and it was not included in the ARM
> pull request.

Well I took some time off and wanted to see v4.8-rc1 work with
legacy mode as we have it in few automated test systems.
So I did not add them to Linux next yet. My plan is to
send them right after v4.8-rc1 and wait on any further legacy
code removal until v4.9.

Regards,

Tony
