From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
Date: Tue, 20 May 2014 14:10:09 +0530
Message-ID: <537B14E9.2050108@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
 <5370CBD5.3060107@ti.com> <20140512143604.GB31772@atomide.com>
 <5370E172.20009@ti.com> <20140512154850.GG31772@atomide.com>
 <5375C8E8.1020209@ti.com> <537AE8A7.4080307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <537AE8A7.4080307@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Archit Taneja <archit@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 May 2014 11:01 AM, Archit Taneja wrote:
> Hi,
> 
> On Friday 16 May 2014 01:44 PM, Tomi Valkeinen wrote:
>> On 12/05/14 18:48, Tony Lindgren wrote:
>>
>>>>> Also, I'm wondering why we still have .clk and .opt_clks entries in the
>>>>> hwmod data for am43xx and omap5 which are both device tree based with
>>>>> all the clocks coming from .dts files?
>>>>
>>>> I think they are needed for the omap_device/hwmod stuff to work. Only
>>>> omapdss driver knows about the clocks defined in the .dts files, and the
>>>> omap_device/hwmod code still needs to do the reset and maybe some other
>>>> tasks that require the clocks.
>>>
>>> We're already populating the hwmod data from dts entries, that's done by
>>> omap_device_build_from_dt. Why aren't we doing that for dt defined clocks?
>>>
>>> I'd rather not start adding new data that will then just be removed, that's
>>> what people call "pointless extra churn".
>>
>> I don't know why. I have to say I'm not 100% sure if that's done or not,
>> but at least I can't find where it's done.
> 
> The reason why clocks are needed from hwmod data is because we still don't populate hwmod fields like main_clk and opt_clock from DT clocks.
> 
> The reason why this isn't done yet is because we currently haven't figured out a clean way to tell hwmod what clock is the main_clk, and what clocks are optional clocks.
> 
> One of the proposed methods was to assume the clock named to be "fck" as main_clk, and the remaining clocks as optional clocks for hwmod. That method wasn't agreed upon, this looks like the thread which discusses this:
> 
> http://marc.info/?l=linux-arm-kernel&m=138928084823142&w=2

So I started to look through this again and I realized most of the opt clock information
is actually unused within hwmod and does not even need to be there. I just proposed an RFC here to clean some of that [1]

The only modules which do need this seem to be gpio and dss (though we still need to check if all the newer platforms
need this, or this is one of those things just carried forward because some old platform had an issue with gpio and dss
ocp reset)

As far as DSS is concerned, this is used within the custom reset function (not within hwmod) in display.c in mach-omap2/
Its just that the current code relies on hwmod structures, which can very easily now extract this from DT instead.

That just leaves gpio, which should be the only clock information that will have to exist in hwmod till we figure out
how to move it to DT. All the main_clks from hwmod can very easily to moved to DT as already proposed using something like
'fck' to identify them.

[1] http://marc.info/?l=linux-omap&m=140057445618162&w=2

> 
> Archit
> 
> 
