From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 17:54:07 +0100
Message-ID: <201103101754.07679.arnd@arndb.de>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101711.59544.arnd@arndb.de>
	<20110310161917.GD27206@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110310161917.GD27206@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Daniel Walker <dwalker@codeauror>
List-Id: linux-omap@vger.kernel.org

On Thursday 10 March 2011, Mark Brown wrote:
> On Thu, Mar 10, 2011 at 05:11:59PM +0100, Arnd Bergmann wrote:
> > On Thursday 10 March 2011, Mark Brown wrote:
> 
> > > You could, though the bus will just be a noop.  Typically it's more than
> > > one bus but software basically can't tell.
> 
> > Yes. The main reason for representing such a bus in sysfs would be
> > to match the SOC's block diagram with the structure in the kernel.
> 
> If you're doing that things like power domains tend to be a lot more
> interesting since you can do something meaningful with them in software.
> The non-visible buses aren't reliably documented anyway and the first
> procesor datasheet I just pulled up had a whole bunch of devices that
> span multiple buses anyway :)

Yes, I'm aware that devices are not alwasy in a clear hierarchy and
that you have bus addressing, device driver, clock, power and interrupt
(and possibly more) trees that often don't match up.

My point is simply that we should still try to find a helpful tree
representation in these cases, even if it's not perfect. Almost anything
is better than having lots of unrelated devices in a flat directory.

	Arnd
