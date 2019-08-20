From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 0/8] soc: ti: Add OMAP PRM driver
Date: Tue, 20 Aug 2019 11:51:10 -0500
Message-ID: <88446f5f-60ae-1205-33e5-a225a2764c72@ti.com>
References: <1565164139-21886-1-git-send-email-t-kristo@ti.com>
 <432a70fc-2683-42ca-3ac7-9775efa3ca41@ti.com>
 <b991f374-9e2a-5f1d-d48d-5f50a3c41756@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b991f374-9e2a-5f1d-d48d-5f50a3c41756@ti.com>
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
To: Tero Kristo <t-kristo@ti.com>, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 8/20/19 2:54 AM, Tero Kristo wrote:
> On 20.8.2019 2.20, Suman Anna wrote:
>> Hi Tero,
>>
>> On 8/7/19 2:48 AM, Tero Kristo wrote:
>>> Hi,
>>>
>>> This series adds OMAP PRM driver which initially supports only reset
>>> handling. Later on, power domain support can be added to this to get
>>> rid of the current OMAP power domain handling code which resides
>>> under the mach-omap2 platform directory. Initially, reset data is
>>> added for AM3, OMAP4 and DRA7 SoCs.
>>
>> Wakeup M3 remoteproc driver is fully upstream, so we should be able to
>> test that driver as well if you can add the AM4 data. That will also
>> unblock my PRUSS.
>>
>> If you can add the data to others as well, it will help in easier
>> migration of the individual drivers, otherwise the ti-sysc interconnect,
>> hwmod, and hwmod reset data combinations will all have to be supported
>> in code.
> 
> Ok, so you are saying you would need the PRM data for am4 in addition? I
> can generate that one also.

Yes, if you can include the data for AM4 and OMAP5 as well, then we can
convert all the SoCs other than OMAP2/OMAP3 at the same time as per your
comment on bindings. Almost all of the active remoteprocs will be
covered by these.

OMAP3 ISP driver is also fully upstream, so we would have to manage its
legacy compatibility.

regards
Suman

> 
> -Tero
> 
>>
>> regards
>> Suman
>>
>>>
>>> I've been testing the reset handling logic with OMAP remoteproc
>>> driver which has been converted to use generic reset framework. This
>>> part is a work in progress, so will be posting patches from that part
>>> later on.
>>>
>>> -Tero
>>>
>>> -- 
>>>
>>
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
