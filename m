From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Fri, 08 Apr 2011 09:46:22 +1200
Message-ID: <4D9E30AE.9080105@bluewatersys.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103112313.16128.arnd@arndb.de> <4D9DE532.5000802@linaro.org>
	<201104072329.24243.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201104072329.24243.arnd@arndb.de>
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
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <lee.jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Daniel
List-Id: linux-omap@vger.kernel.org

On 04/08/2011 09:29 AM, Arnd Bergmann wrote:
> On Thursday 07 April 2011, Lee Jones wrote:
>> On 11/03/11 22:13, Arnd Bergmann wrote:
>>> On Friday 11 March 2011 23:03:33 Greg KH wrote:
>>>> On Fri, Mar 11, 2011 at 10:42:43PM +0100, Arnd Bergmann wrote:
>>>>> On Friday 11 March 2011 20:33:30 Greg KH wrote:
>>>>>> Make this a "real" device not /sys/socinfo please.  It can be a platform
>>>>>> device that export the needed information, that way you can have
>>>>>> multiple ones.
>>>>>
>>>>> Note that the version 1 of this patch had a device, and I argued against
>>>>> that patch on the basis that anything under /sys/devices/ should
>>>>> reflect an actual part of the hardware, which socinfo by itself
>>>>> does not.
>>>>
>>>> Why is the overall SoC not a device?  cpus are (well, they will be in a
>>>> few kernel versions in the future), so what makes the other bits somehow
>>>> "special"?
>>>
>>> The suggestion was to have a single disconnected device stuck 
>>> in /sys/devices/system/socinfo, and only have it there to
>>> contain device attributes that can be collected from random
>>> places in the system, such hardcoded board specific data,
>>> or read from registers that belong to another device.
>>>
>>> A real device IMHO would be one that has specific hardware
>>> properties, such as its own set of device registers or other
>>> devices that are attached to it and that are represented
>>> as children of this device.
>>
>> Unfortunately, Maxime is extremely busy at the moment, so I have taken
>> over to finally get this thing upstream. Just for clarification what's
>> the final verdict on the location of this entry? Something that we can
>> all agree on.
> 
> I'll try to capture the opinions from the other people as well,
> hopefully this represents a consensus. Please correct me otherwise.
> 
> I believe the uncontroversial parts are:
> 
> * Make it not an entry but a device with certain properties.
> * Make the naming so that you can have more than one of them.
> * Put all devices on an SoC that uses this scheme underneath that
>   device by setting their parents to the SoC device.
> 
> For the location of the device, I have not seen a clear consensus yet,
> but I'm fine with eihter of these:
> 
> /sys/devices/soc/${NAME}/
> /sys/devices/platform/soc${NUMBER}/

I prefer the second format here since the path is always the same which
makes it easier to write parsing tools. The name should be an entry in
the directory rather than the name of the directory itself.

Probably SoC number should match CPU number for SMP machines right?
Possibly the SoC directory should even contain a symlink to the relevant
CPU sysfs directory? If CPU's are set to become devices under sysfs then
the SoC should also probably be the parent of the CPU?

> For the implementation, I'd suggest adding an soc_device_register()
> function that gets passed the necessary data and returns the struct device
> that can then be used as the parent in all platform_device_register calls.

Agreed.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
