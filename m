From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Fri, 08 Apr 2011 10:07:25 +1200
Message-ID: <4D9E359D.50502@bluewatersys.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103112313.16128.arnd@arndb.de> <4D9DE532.5000802@linaro.org>
	<201104072329.24243.arnd@arndb.de>
	<4D9E30AE.9080105@bluewatersys.com>
	<alpine.LFD.2.00.1104071756080.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1104071756080.28032@xanadu.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <lee.jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.
List-Id: linux-omap@vger.kernel.org

On 04/08/2011 10:01 AM, Nicolas Pitre wrote:
> On Fri, 8 Apr 2011, Ryan Mallon wrote:
> 
>> On 04/08/2011 09:29 AM, Arnd Bergmann wrote:
>>> I'll try to capture the opinions from the other people as well,
>>> hopefully this represents a consensus. Please correct me otherwise.
>>>
>>> I believe the uncontroversial parts are:
>>>
>>> * Make it not an entry but a device with certain properties.
>>> * Make the naming so that you can have more than one of them.
>>> * Put all devices on an SoC that uses this scheme underneath that
>>>   device by setting their parents to the SoC device.
>>>
>>> For the location of the device, I have not seen a clear consensus yet,
>>> but I'm fine with eihter of these:
>>>
>>> /sys/devices/soc/${NAME}/
>>> /sys/devices/platform/soc${NUMBER}/
>>
>> I prefer the second format here since the path is always the same which
>> makes it easier to write parsing tools. The name should be an entry in
>> the directory rather than the name of the directory itself.
>>
>> Probably SoC number should match CPU number for SMP machines right?
> 
> Not really.  SOC means System On Chip.  you usually have only one SOC on 
> a board, and within that SOC you may have one or more CPUs.  SMP 
> machines are still likely to have only one SOC.

Ok. What is the situation where we have more than one SoC?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
