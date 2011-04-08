From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Fri, 08 Apr 2011 08:41:32 +0100
Message-ID: <4D9EBC2C.2050809@linaro.org>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201104080119.11378.arnd@arndb.de>
	<20110407232959.GA29305@kroah.com>
	<201104080535.02769.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201104080535.02769.arnd@arndb.de>
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>linux-ar
List-Id: linux-omap@vger.kernel.org

On 08/04/11 04:35, Arnd Bergmann wrote:
> On Friday 08 April 2011, Greg KH wrote:
>> Symlinks are a requirement as multiple cpus can be attached to a single
>> SoC.
>>
>> What about multiple cpus that are attached to multiple SoCs?  Why even
>> try to describe this relationship, what would userspace get out of this
>> information?
> 
> The only one I can think of is node affinity. I've worked with a system
> (IBM QS2x Cell blade) that had two SoCs with multiple CPUs each. There was
> a significant performance penalty when talking to devices on the remote
> SoC. In that case, we used the NUMA node information in /sys/ to deal
> with it, but we might not want to use the NUMA infrastructure on systems
> that only have RAM on one node.

I'm struggling to see a scenario where we'd have multiple SoCs on a
single device and only one filesystem. ux500 sub-arch code is yet to
facilitate SoC counting functionality. If were are to implement per-SoC
directories would this need to be added?
