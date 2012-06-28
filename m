From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Thu, 28 Jun 2012 11:43:37 -0500
Message-ID: <4FEC89B9.3090404@ti.com>
References: <cover.1340778002.git.afzal@ti.com> <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com> <20120627145844.GL3483@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com> <20120628123207.GG19842@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45612 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2F1Qnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 12:43:32 -0400
In-Reply-To: <20120628123207.GG19842@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony, Afzal,

On 06/28/2012 07:32 AM, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120628 02:36]:
>> Hi Tony,
>>
>> On Wed, Jun 27, 2012 at 20:28:45, Tony Lindgren wrote:
>>
>>> The last patch in this series causes onenand not to show
>>> up on my n900. I believe the problem has been there earlier
>>> too, but I just did not notice it.
>>
>> Sorry for the delayed response, could reach workplace a short
>> while ago only
>>
>> Could the diff [1] be tried and check whether it resolves the issue,
>>
>> Regards
>> Afzal
>>
>> [1]
>> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
>> index c8a9487..bbae674 100644
>> --- a/arch/arm/mach-omap2/gpmc-onenand.c
>> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
>> @@ -364,6 +364,8 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
>>         struct gpmc_timings t;
>>         int ret;
>>
>> +       omap2_onenand_set_async_mode(onenand_base);
>> +
>>         t = omap2_onenand_calc_async_timings();
>>
>>         ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
> 
> Yes that seems to do the trick, thanks! I can fold that into the
> breaking patch when applying.

I am not sure what to make of this. Testing Afzal's this series along with the other
gpmc-prep series [1], onenand is working fine on my 3430sdp and I see ...

[    2.792510] OneNAND driver initializing
[    2.797576] omap2-onenand omap2-onenand: initializing on CS2, phys base 0x20000000, virtual base c88c0000, freq 0 MHz
[    2.808929] OneNAND Manufacturer: Samsung (0xec)
[    2.808990] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    2.814208] OneNAND version = 0x002c

The above change seems to imply that Tony's n900 is dependent on the bootloader settings
and not those being set by the kernel. Ideally, we should not need to set the async mode
in the onenand before we set the onenand timings in the gpmc (per Afzal's changelog
comment). This appears backwards.

The other thing to note is that the 3430sdp has samsung onenand where as the n900 has
Numonyx. The gpmc-onenand.c only has one set of settings that it is using for all
devices. However, it would appear that at least the async settings are not working for
the Numonyx. Therefore, may be we need to get a dump of Tony's n900 settings and make
sure the right settings are being used for the appropriate board. 

These onenand settings are really killing us. I don't want us to have to spend alot
of time re-calculating this stuff but the way it has been written to begin with is not
driver friendly. I really wonder if we need to have some sort of callback for the 
onenand timings from the driver. It is ugly, but the alternative is that someone needs
to sit down and re-calculate all the timings again to get them into a driver friendly
format. Furthermore, it seems that onenand is no longer available from the likes of
samsung and numonyx (micron) so it is hard to justify re-calculating everything again.
I am not even sure if we have all the datasheets!

Let me know your thoughts.

Cheers
Jon

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70096.html

