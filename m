From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Thu, 28 Jun 2012 14:00:45 -0500
Message-ID: <4FECA9DD.8050505@ti.com>
References: <cover.1340778002.git.afzal@ti.com> <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com> <20120627145844.GL3483@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com> <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47753 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab2F1TAl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 15:00:41 -0400
In-Reply-To: <4FEC89B9.3090404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony, Afzal,

On 06/28/2012 11:43 AM, Jon Hunter wrote:
> Hi Tony, Afzal,
> 
> On 06/28/2012 07:32 AM, Tony Lindgren wrote:
>> * Mohammed, Afzal <afzal@ti.com> [120628 02:36]:
>>> Hi Tony,
>>>
>>> On Wed, Jun 27, 2012 at 20:28:45, Tony Lindgren wrote:
>>>
>>>> The last patch in this series causes onenand not to show
>>>> up on my n900. I believe the problem has been there earlier
>>>> too, but I just did not notice it.
>>>
>>> Sorry for the delayed response, could reach workplace a short
>>> while ago only
>>>
>>> Could the diff [1] be tried and check whether it resolves the issue,
>>>
>>> Regards
>>> Afzal
>>>
>>> [1]
>>> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
>>> index c8a9487..bbae674 100644
>>> --- a/arch/arm/mach-omap2/gpmc-onenand.c
>>> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
>>> @@ -364,6 +364,8 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
>>>         struct gpmc_timings t;
>>>         int ret;
>>>
>>> +       omap2_onenand_set_async_mode(onenand_base);
>>> +
>>>         t = omap2_onenand_calc_async_timings();
>>>
>>>         ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
>>
>> Yes that seems to do the trick, thanks! I can fold that into the
>> breaking patch when applying.
> 
> I am not sure what to make of this. Testing Afzal's this series along with the other
> gpmc-prep series [1], onenand is working fine on my 3430sdp and I see ...
> 
> [    2.792510] OneNAND driver initializing
> [    2.797576] omap2-onenand omap2-onenand: initializing on CS2, phys base 0x20000000, virtual base c88c0000, freq 0 MHz

I realised that the above print showing 0 MHz is another clue as to why
the above change is needed for the n900. It is printing 0 MHz because
the OMAP3430 SDP does not support sync read or write. The frequency is
only queried during the configuration of the sync mode timings and not
the async. I had just submitted a 2 patch series to fix this so that is
displays the correct frequency for all boards [1]. If you agree with my
changes may be we can include them in Afzal's series.

However, more importantly with my fix, I now see that the frequency
supporting by the OneNAND on the SDP is 66MHz. On Tony's n900 it shows
83MHz. The timings for async mode are hard-coded in the gpmc-onenand.c
and it does not have different timings for different devices and
different frequencies. Hence, this is probably why the async timings in
the gpmc-onenand.c do not work for the n900.

The problem is that unlike nand, where it is clear which boards were
dependent on the bootloader timings, for onenand it really is not 100%
clear. Some boards support ONENAND_SYNC_READWRITE and so these are not
using the async timings. However, the n8x0 appears only to use sync
read. Does the n900 use the same settings as the n8x0?

Tony, have you tried using any of the mtd kernel tests to verify OneNAND
read/write is working on your n900? For example ...

# insmod mtd_pagetest.ko dev=<mtd-part-num>

_NOTE_ that above test erases the OneNAND! ;-)

Cheers
Jon

[1] http://marc.info/?l=linux-omap&m=134090910321284&w=2
