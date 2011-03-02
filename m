From: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
Date: Wed, 2 Mar 2011 13:17:18 +0100
Message-ID: <4D6E354E.5010208@stericsson.com>
References: <AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>
	<4D6D9B10.9000606@codeaurora.org>
	<4D6D9D06.2020204@bluewatersys.com>
	<4D6D9FC7.1090206@codeaurora.org>
	<4D6DA290.2010607@bluewatersys.com>
	<4D6DAA24.3000204@codeaurora.org>
	<4D6DAE6E.4030701@bluewatersys.com>
	<4D6DB1B1.4060908@codeaurora.org> <4D6DFE67.3020801@stericsson.com>
	<AANLkTimJh_uGP6SYo=9ndz4xiUs1Tbg7z70ng0aFcWyG@mail.gmail.com>
	<20110302113823.GB2728@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110302113823.GB2728@pulham.picochip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Walker <dwalker@codeaurora>
List-Id: linux-omap@vger.kernel.org

On 03/02/2011 12:38 PM, Jamie Iles wrote:
> On Wed, Mar 02, 2011 at 11:36:38AM +0100, Linus Walleij wrote:
>> On Wed, Mar 2, 2011 at 9:23 AM, Maxime Coquelin
>> <maxime.coquelin-nonst@stericsson.com>  wrote:
>>
>>> I think we should have a tree like this :
>>>
>>> /sys/devices/system/soc/
>>> /sys/devices/system/soc/unique_id<- Unified way to export an ID for all machs
>> Arbitrary number of bits? Some will have a 64-bit ID, some will have 32-bit
>> etc.
>>
>> Should we say it's a hex string of 64 bits?
> Could we provide hooks for the platform that takes the buffer and length
> and let the platform do the snprintf()?  Our devices have a 128-bit
> serial number and I'm sure there must be others.

This is one possibility, another one is to let the platform specify how 
it exports this serial, as you proposed bellow.

>>> /sys/devices/system/soc/mach/
>>> /sys/devices/system/soc/mach/name<- Name of the mach
>>> /sys/devices/system/soc/mach/foo_id
>>> /sys/devices/system/soc/mach/bar_id<- Vendors may have several/different IDs
>>> to export (IDCODE for OMAP, Production ID...)
> Do we need a way to allow platforms to specify additional attributes to
> co into the socinfo?  For our devices we can boot in different modes and
> how we boot determines how the firmware is upgraded.  In the case above
> the platform could specify that it needs foo_id and bar_id and the
> callbacks to fill them in.

Yes it was what I thought with the foo and bar IDs exports.

Maxime
