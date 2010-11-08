From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/6] OMAP4: hwmod data: add mmu hwmod for ducati and tesla
Date: Mon, 8 Nov 2010 18:21:01 -0500
Message-ID: <4CD885DD.7020909@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>	<1289006396-27230-4-git-send-email-omar.ramirez@ti.com>	<4CD5BEFF.40301@ti.com>
	<AANLkTim=5bgGo1cnkWJCPF4HmMnQrBhP_sPCK3rRKUPS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTim=5bgGo1cnkWJCPF4HmMnQrBhP_sPCK3rRKUPS@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, "Raja,
	Govindraj" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Gupta,
	Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan,
	Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

On 11/7/2010 11:18 AM, Ramirez Luna, Omar wrote:
> On Sat, Nov 6, 2010 at 3:47 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>>
>>> Add mmu hwmod data for ducati and tesla.
>>
>> s/ducati/ipu/
>> s/tesla/dsp/
>>
>> Please do not use internal codename.
>
> Tried to avoid confusion with what was originally in the driver, agree
> with the change.
>
>> Here again, you completely changed the omap4 existing data for (almost)
>> nothing.
>>
>> I agree, the original code was not considering the mmu as a hwmod but only
>> the core of the subsystem: mmu + cache.
>>
>> But as far as I can see, you just added a new mmu class, a dev_attr, and the
>> hwmod remain almost the same.
>> Otherwise, you replaced the proper names by the bad one, and you removed
>> important data (hw reset for ex).
>>
>> Please start from the original code and fix what is missing or wrong but do
>> not re-write everything.
>
> I wrote this one from scratch, I didn't see that there were pieces to
> handle some stuff since the code is buried in a private tree.

Not true at all... It was sent to l-o:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32854.html

And stored in a supposedly private tree, which appears to be public:
http://dev.omapzoom.org/?p=swarch/linux-omap-adv.git;a=summary

> I cared to dug up the mailbox one, but completely missed this one.
>
>>> +/* mmu */
>>> +
>>> +static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
>>> +       .name = "mmu",
>>> +};
>>
>> That change is OK. The remaining part seems to be completely broken.
>>
>>> +
>>> +/* ducati mmu */
>>> +
>>> +static struct omap_hwmod omap44xx_ducati_mmu_hwmod;
>>> +
>>> +static struct omap_hwmod_addr_space omap44xx_ducati_mmu_addrs[] = {
>>> +       {
>>> +               .pa_start       = OMAP4_MMU1_BASE,
>>> +               .pa_end         = OMAP4_MMU1_BASE + SZ_4K - 1,
>>> +               .flags          = ADDR_TYPE_RT,
>>> +       },
>>> +};
>>> +
>>> +/* l3_main_1 ->    ducati mmu */
>>> +static struct omap_hwmod_ocp_if omap44xx_l3_main_1__ducati_mmu = {
>>> +       .master         =&omap44xx_l3_main_1_hwmod,
>>> +       .slave          =&omap44xx_ducati_mmu_hwmod,
>>> +       .addr           = omap44xx_ducati_mmu_addrs,
>>> +       .clk            = "dpll_mpu_m2_ck",
>>
>> Are you sure of that?
>
> No, this was supposed to be the hwmod main_clk... the ocp_if clk
> should be l3_div.
>
> I will add these changes and the ones you mention as "mmu + cache",
> and see how it goes from there.

Please do not do any change on that code base, just use the original 
code and update it if needed.

Benoit
