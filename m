From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Date: Tue, 3 Jul 2018 12:59:34 +0530
Message-ID: <ee54c3ea-6200-33dd-83da-491f5fdd9f5c@ti.com>
References: <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
 <20180608062158.GI5738@atomide.com>
 <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
 <20180611062904.GO5738@atomide.com>
 <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
 <20180611070332.GP5738@atomide.com> <20180703070743.GG112168@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180703070743.GG112168@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, paul@pwsan.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 03 July 2018 12:37 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180611 07:06]:
>> * Faiz Abbas <faiz_abbas@ti.com> [180611 06:48]:
>>> Hi,
>>>
>>> On Monday 11 June 2018 11:59 AM, Tony Lindgren wrote:
>>>> * Faiz Abbas <faiz_abbas@ti.com> [180611 06:28]:
>>>>> Great. I thought I completely misunderstood you. But I don't see what
>>>>> adding another function will accomplish. A QUIRK flag used in the same
>>>>> function would work well enough>
>>>> Fine with me as long as the function stays simple for both
>>>> syss and sysc reset.
>>>>
>>>
>>>
>>> In general a reset status bit being in sysstatus is the norm and it
>>> being in sysconfig should be the "quirk" for which a flag needs to be
>>> added. What do you think?
>>
>> Sure makes sense to me.
>>
>>> As an aside, naming bitshifts by the name of the platform they were
>>> originally added in seems weird. There should be some generic mask
>>> saying "soft reset is the 0th bit". Currently I am using
>>> SYSC_OMAP4_SOFTRESET for a dra76x module. I guess it depends on how many
>>> different sysconfig types we have.
>>
>> Sure we could have a macro for that.
> 
> So what's the conclusion on this one? Are you going to do one
> more version of the ti-sysc driver patch?
> 

Yes. I have just now been able to get back to this. Will post a v4 by
tomorrow.

Thanks,
Faiz
