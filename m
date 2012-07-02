From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Mon, 2 Jul 2012 12:25:20 -0500
Message-ID: <4FF1D980.4040100@ti.com>
References: <cover.1340778002.git.afzal@ti.com> <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com> <20120627145844.GL3483@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com> <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com> <20120702063651.GO4202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46784 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab2GBRZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 13:25:27 -0400
In-Reply-To: <20120702063651.GO4202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 07/02/2012 01:36 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [120628 09:48]:
>>
>> [    2.792510] OneNAND driver initializing
>> [    2.797576] omap2-onenand omap2-onenand: initializing on CS2, phys base 0x20000000, virtual base c88c0000, freq 0 MHz
>> [    2.808929] OneNAND Manufacturer: Samsung (0xec)
>> [    2.808990] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
>> [    2.814208] OneNAND version = 0x002c
>>
>> The above change seems to imply that Tony's n900 is dependent on the bootloader settings
>> and not those being set by the kernel. Ideally, we should not need to set the async mode
>> in the onenand before we set the onenand timings in the gpmc (per Afzal's changelog
>> comment). This appears backwards.
> 
> That should not be the case, I'm more likely to believe in Afzal's explanation.

Right I agree with Afzal's explanation now too.

>> The other thing to note is that the 3430sdp has samsung onenand where as the n900 has
>> Numonyx. The gpmc-onenand.c only has one set of settings that it is using for all
>> devices. However, it would appear that at least the async settings are not working for
>> the Numonyx. Therefore, may be we need to get a dump of Tony's n900 settings and make
>> sure the right settings are being used for the appropriate board. 
> 
> Hmm I would assume the n900 onenand settings are the most tested settings we have.
> And AFAIK have also been tested with L3 frequency scaling. So let's assume they're
> mostly right.
>  
>> These onenand settings are really killing us. I don't want us to have to spend alot
>> of time re-calculating this stuff but the way it has been written to begin with is not
>> driver friendly. I really wonder if we need to have some sort of callback for the 
>> onenand timings from the driver. It is ugly, but the alternative is that someone needs
>> to sit down and re-calculate all the timings again to get them into a driver friendly
>> format. Furthermore, it seems that onenand is no longer available from the likes of
>> samsung and numonyx (micron) so it is hard to justify re-calculating everything again.
>> I am not even sure if we have all the datasheets!
>>
>> Let me know your thoughts.
> 
> I don't think we should spend much time working on the recalculations. Let's rather
> use these known working cases as examples. If they don't work, it's likely that
> adding any new devices won't work either.
> 
> For the timings, we should allow specifying either cycles or time values in the
> data struct. And always just use the cycle value directly if specified, and
> othewise use the time value. We may be able to limit the registers where we need
> to allow either cycle or time value depending on the device futher.
> 
> In general, I doubt that we can come up with better calculations. The existing
> code pretty well already follows the device spec timings. And using cycle values
> for some registers is the right thing to do according to the connected device
> specs no matter what the frequency is. In those cases converting from time values
> to cycles does not make sense.

Ok agree, but the problem here is how to provide the timings to the
driver. The onenand code is doing a lot of rounding based upon the gpmc
clock before it presents the timings (in nano-seconds) to the gpmc
function to calculate the final timings and program the gpmc
chip-select. So therefore I think that we have the following options ...

1. The simplest is to continue using a global variable for storing the
gpmc f-clk handle and have the OneNAND timings calculated prior to
probing the gpmc driver.

2. Provide some sort of "retime" callback that the gpmc driver can call
at probe time to calculate the timings.

Cheers
Jon
