From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v5 00/16] OMAP2+ OneNAND driver update
Date: Thu, 11 Jan 2018 10:08:19 +0200
Message-ID: <5709e23c-a2f1-c890-cf8b-8f52f31d8b73@ti.com>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
 <20171130111840.41c92d34@bbrezillon> <20171130160936.GO28152@atomide.com>
 <434bd733-0ba2-6e75-9de5-017eef905fd2@ti.com> <20180109130812.GA338@lenoch>
 <20180109210114.s66rpdg2jjdps5bc@darkstar.musicnaut.iki.fi>
 <20180110092058.GA25351@lenoch>
 <20180110173519.xyug4egltni4f3qi@darkstar.musicnaut.iki.fi>
 <20180110212748.lbwwnktftqv3awzi@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180110212748.lbwwnktftqv3awzi@darkstar.musicnaut.iki.fi>
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
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/01/18 23:27, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jan 10, 2018 at 07:35:19PM +0200, Aaro Koskinen wrote:
>> On Wed, Jan 10, 2018 at 10:20:58AM +0100, Ladislav Michl wrote:
>>> On Tue, Jan 09, 2018 at 11:01:14PM +0200, Aaro Koskinen wrote:
>>>> On Tue, Jan 09, 2018 at 02:08:12PM +0100, Ladislav Michl wrote:
>>>>> Merge window is really close now and patches seems still to be untested on
>>>>> n8x0. So unless someone is going to test it soon, I'll pick used N800 on
>>>>> ebay :-/
>>>>
>>>> Today I tried to test them on Nokia N810, and I get:
>>>>
>>>> [    0.174804] omap-gpmc 6800a000.gpmc: GPMC revision 2.0
>>>> [    0.174865] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
>>>> [    0.177459] omap-gpmc 6800a000.gpmc: /ocp/gpmc@6800a000/onenand@0,0 has no 'bank-width' property
>>>> [    0.177612] omap-gpmc 6800a000.gpmc: failed to probe DT child 'onenand': -22
>>>>
>>>> With plain v4.15-rc7+ it probes fine.
>>>
>>> Thank you for testing. As stated in cover letter, you need also
>>> https://patchwork.kernel.org/patch/10043259/
>>> which can be also found in Roger's branch
>>> https://github.com/rogerq/linux/commits/for-v4.16/gpmc-omap-immutable
>>> (see previous replies in this thread and also discussion about OneNAND
>>> DT node)
>>
>> I applied it, and now get:
>>
>> [    0.174987] omap-gpmc 6800a000.gpmc: GPMC revision 2.0
>> [    0.175048] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
>> [    0.177703] omap-gpmc 6800a000.gpmc: Incompatible OneNAND node: missing compatible
>> [    0.177764] omap-gpmc 6800a000.gpmc: failed to probe DT child 'onenand': -22
> 
> Crap, I think something is wrong in my kexec. It seems to pass the DTB from an
> old kernel, although the new kernel has a new appended DTB... Need to
> investigate, sorry for noise.
> 
> A.
> 

Aaro,

You will still need to add "ti,omap2-onenand" compatible property to the n800/810 onenand node for it to work.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
