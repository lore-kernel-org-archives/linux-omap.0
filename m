From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Thu, 07 Apr 2011 17:24:18 +0100
Message-ID: <4D9DE532.5000802@linaro.org>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103112242.43962.arnd@arndb.de>
	<20110311220333.GA30232@kroah.com>
	<201103112313.16128.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201103112313.16128.arnd@arndb.de>
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
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Daniel
List-Id: linux-omap@vger.kernel.org

On 11/03/11 22:13, Arnd Bergmann wrote:
> On Friday 11 March 2011 23:03:33 Greg KH wrote:
>> On Fri, Mar 11, 2011 at 10:42:43PM +0100, Arnd Bergmann wrote:
>>> On Friday 11 March 2011 20:33:30 Greg KH wrote:
>>>> Make this a "real" device not /sys/socinfo please.  It can be a platform
>>>> device that export the needed information, that way you can have
>>>> multiple ones.
>>>
>>> Note that the version 1 of this patch had a device, and I argued against
>>> that patch on the basis that anything under /sys/devices/ should
>>> reflect an actual part of the hardware, which socinfo by itself
>>> does not.
>>
>> Why is the overall SoC not a device?  cpus are (well, they will be in a
>> few kernel versions in the future), so what makes the other bits somehow
>> "special"?
> 
> The suggestion was to have a single disconnected device stuck 
> in /sys/devices/system/socinfo, and only have it there to
> contain device attributes that can be collected from random
> places in the system, such hardcoded board specific data,
> or read from registers that belong to another device.
> 
> A real device IMHO would be one that has specific hardware
> properties, such as its own set of device registers or other
> devices that are attached to it and that are represented
> as children of this device.

Unfortunately, Maxime is extremely busy at the moment, so I have taken
over to finally get this thing upstream. Just for clarification what's
the _final_ verdict on the location of this entry? Something that we can
all agree on.
