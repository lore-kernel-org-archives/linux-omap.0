From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] drop last omap3 board files for v4.8
Date: Fri, 02 Sep 2016 18:31:55 +0200
Message-ID: <5065725.hSDWXRnpuO@wuerfel>
References: <20160816155241.eka7c6p2rvp4q5zk@atomide.com>
 <4327380.4mS7Wg8her@wuerfel> <20160902145717.gtyhz76bv575plch@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160902145717.gtyhz76bv575plch@atomide.com>
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
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Russell King <rmk+kernel@armlinux.org.uk>, arm@kernel.org, Pavel Machek <pavel@ucw.cz>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday, September 2, 2016 7:57:18 AM CEST Tony Lindgren wrote:
> Sure thanks. Let's just not touch any of the now unused platform
> data until v4.10 then. Otherwise we'll fast reach a point of no
> return without reverting large patches.

Ok, I've applied the branch to next/cleanup now,
thanks a lot for getting omap to this point!

	Arnd
