From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/7] memory: omap-gpmc: Refactor OneNAND support
Date: Fri, 10 Nov 2017 10:12:22 +0200
Message-ID: <b59f9975-bc59-97c4-ddb2-57637de12e2c@ti.com>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091253.lvrzi5kbaykkxlcb@lenoch> <20171109175626.GD28152@atomide.com>
 <20171109181004.g55vx4iveo5sulpt@lenoch> <20171109182645.GE28152@atomide.com>
 <20171109183408.xbc4bacawv7li54l@lenoch> <20171109184828.GF28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171109184828.GF28152@atomide.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/11/17 20:48, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [171109 18:35]:
>> On Thu, Nov 09, 2017 at 10:26:45AM -0800, Tony Lindgren wrote:
>>> Well we should have the dependencies merged first to avoid breaking
>>
>> Yes, that's what cover letter says :-)
>> Also, I still count on your suggestion to merge it via mtd tree.
> 
> Well only after it has been tested :) At this point I'd say
> we're best off waiting for v4.16 merge window on the clean
> up too as the merge window is about to open.
> 
>>> git bisect. After applying this and the first patch I see:
>>>
>>> omap-gpmc 6e000000.gpmc: /ocp@68000000/gpmc@6e000000/onenand@0,0 has no 'bank-width' property
>>> omap-gpmc 6e000000.gpmc: failed to probe DT child 'onenand': -22
>>>
>>> So seems like more dts changes are needed to test this.
>>
>> Argh... You are right, I should add this into serie:
>> https://patchwork.kernel.org/patch/10043259/

You don't need to resend that patch as it has been already
reviewed and in my v4.16 queue. Just indicate in the cover letter that this
series depends on that patch.

> 
> Well don't we still need the related dts changes posted
> and merged first> 
> Regards,
> 
> Tony
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
