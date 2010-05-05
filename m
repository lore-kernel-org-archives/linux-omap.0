From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: Upcoming merge window and omap NAND patches
Date: Wed, 05 May 2010 15:55:20 +0300
Message-ID: <4BE16AB8.7010308@compulab.co.il>
References: <20100504220803.GN29604@atomide.com>
	<1273034943.3702.19.camel@localhost>
	<l2wce9ab5791005042311lf1c1a15fu891457f4e0863d6@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030D7DEB6B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030D7DEB6B@dbde02.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, Tony Lindgren <tony@atomide.com>, Steve Sakoman <sakoman@gmail.com>, Vimal Singh <vimal.newwork@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Ghorai,

Ghorai, Sukumar wrote:
> Tony,
> I understand your comment/input. And I will work on it. 
> 
> All existing omap3 boards are using same old fashion. So let me see how many board I can test before post the patch. I will update this next week.

I'd be glad to test the patches on CM-T35 if you'd like to.

> Regards,
> Ghorai
> 
>> -----Original Message-----
>> From: Vimal Singh [mailto:vimal.newwork@gmail.com]
>> Sent: 2010-05-05 11:42
>> To: Artem.Bityutskiy@nokia.com
>> Cc: Tony Lindgren; linux-omap@vger.kernel.org; linux-
>> mtd@lists.infradead.org; Ghorai, Sukumar; Steve Sakoman; Mike Rapoport
>> Subject: Re: Upcoming merge window and omap NAND patches
>>
>> On Wed, May 5, 2010 at 10:19 AM, Artem Bityutskiy
>> <Artem.Bityutskiy@nokia.com> wrote:
>>> On Wed, 2010-05-05 at 00:08 +0200, ext Tony Lindgren wrote:
>>>> Hi all,
>>>>
>>>> There are several omap NAND patches pending, but some basic things
>>>> should be fixed first.
>>>>
>>>> 1. The NAND driver needs to stop tinkering with the GPMC registers
>>>>
>>>> The omap General Purpose Memory Controller (GPMC) registers are omap
>>>> specific, and not driver specific. Tinkering with these registers
>>>> can cause issues with the other devices on the GPMC.
>>>>
>>>> To find out what needs to disappear fomr the NAND driver, just do:
>>>>
>>>> $ grep baseaddr drivers/mtd/nand/omap2.c
>>>>
>>>> Any GPMC register tinkering needs to happen in arch/arm/mach-
>> omap2/gpmc.c.
>>>> If there are not currently GPMC functions to do something in gpmc.c,
>> then
>>>> let's add the necessary support there.
>>>>
>>>> 2. Passing hardcoded GPMC_CS0_BASE needs to go from the board files
>>>>
>>>> Passing hardcoded GPMC virtual addressess is sure way to mess up
>>>> things. This should all become unnecessary once the NAND drivers
>>>> stops messing with the GPMC registers directly.
>>>>
>>>> So, as a result, I'm not planning on pushing any omap NAND related
>>>> patches until these basic issues are fixed. I'll mark these patches
>>>> as "Changes requested" in patchwork.kernel.org even if these patches
>>>> don't have anything else wrong with them.
>>>>
>>>> Let's fix the basic things for good, and put the other patches on
>>>> hold for a while. Sorry if this causes problems!
>>> Hi,
>>>
>>> fair enough. I guess Vimal should address this, as he seems to be the TI
>>> mr. NAND, right? :-)
>> Hi All,
>>
>> Sorry again. I am no more with TI and I don't have any board with me
>> too. So, I'm unable to fix these.  :(
>> I hope someone else from TI can take care of it.
>>
>> --
>> Regards,
>> Vimal Singh


-- 
Sincerely yours,
Mike.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
