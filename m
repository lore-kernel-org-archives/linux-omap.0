From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 14:44:55 +0000
Message-ID: <20110310144455.GG22195@opensource.wolfsonmicro.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<AANLkTikFCAC-hdv0Q_9eQs31XHHEc4wYqRjfY0S=FYcz@mail.gmail.com>
	<20110310140807.GB7411@sirena.org.uk>
	<201103101529.25661.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201103101529.25661.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 10, 2011 at 03:29:25PM +0100, Arnd Bergmann wrote:
> On Thursday 10 March 2011, Mark Brown wrote:

> > Lots of stuff (like the MFD children of I2C devices) gets shoved on the
> > platform bus on Linux - every time someone considers creating a new bus
> > type for trivial devices the discussion ends up saying that the code
> > will end up being pretty much identical to the platform bus as it's so
> > straightforward so there's no point in cut'n'pasting the code.

> Note that there is a difference between using top-level platform
> devices (the ones that show up in /sys/devices/platform/) and platform
> devices that are children of others (all the others that are in
> /sys/bus/platform).

Sure.

> What some broken drivers do is to create platform devices ad hoc
> and just put them into /sys/platform/ directly although the
> devices clearly have a parent somewhere. These are bugs that should
> be fixed.

Most of the devices doing that on ARMs tend to be devices where there's
no bus that it's meaningful to expose to software - they'll typically be
hanging off an AHB or APB bus which has either no real software control
or control which is very heavily tied into the overall system control
and so is better treated over the whole SoC rather than the bus.
