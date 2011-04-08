From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Fri, 8 Apr 2011 05:35:02 +0200
Message-ID: <201104080535.02769.arnd@arndb.de>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201104080119.11378.arnd@arndb.de>
	<20110407232959.GA29305@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110407232959.GA29305@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <greg@kroah.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <lee.jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Friday 08 April 2011, Greg KH wrote:
> Symlinks are a requirement as multiple cpus can be attached to a single
> SoC.
> 
> What about multiple cpus that are attached to multiple SoCs?  Why even
> try to describe this relationship, what would userspace get out of this
> information?

The only one I can think of is node affinity. I've worked with a system
(IBM QS2x Cell blade) that had two SoCs with multiple CPUs each. There was
a significant performance penalty when talking to devices on the remote
SoC. In that case, we used the NUMA node information in /sys/ to deal
with it, but we might not want to use the NUMA infrastructure on systems
that only have RAM on one node.

	Arnd
