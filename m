From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for DRA7xx
 based SoCs'
Date: Wed, 31 Jul 2013 11:32:34 +0530
Message-ID: <51F8A87A.9080002@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-2-git-send-email-rnayak@ti.com>
 <20130730131009.GA28162@radagast> <51F7CB2F.6070705@ti.com>
 <20130730142353.GL28162@radagast> <51F7CF6F.6050702@ti.com>
 <20130730153138.GA5978@radagast> <51F807EF.6020809@ti.com>
 <51F80939.7060403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F80939.7060403@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, tony@atomide.com, benoit.cousson@gmail.com, balbi@ti.com, Sricharan R <r.sricharan@ti.com>, ambresh@ti.com, sourav.poddar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 31 July 2013 12:13 AM, Nishanth Menon wrote:
> On 07/30/2013 01:37 PM, Sricharan R wrote:
>> Hi,
>> On Tuesday 30 July 2013 09:02 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Tue, Jul 30, 2013 at 08:06:31PM +0530, Sricharan R wrote:
>>>> On Tuesday 30 July 2013 07:53 PM, Felipe Balbi wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, Jul 30, 2013 at 07:48:23PM +0530, Sricharan R wrote:
>>>>>> On Tuesday 30 July 2013 06:40 PM, Felipe Balbi wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Tue, Jul 30, 2013 at 04:55:39PM +0530, Rajendra Nayak wrote:
>>>>>>>> @@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
>>>>>>>>   # define soc_is_omap543x()        is_omap543x()
>>>>>>>>   #endif
>>>>>>>>
>>>>>>>> +# if defined(CONFIG_SOC_DRA7XX)
>>>>>>>> +# undef soc_is_dra7xx
>>>>>>>> +# undef soc_is_dra75x
>>>>>>>> +# define soc_is_dra7xx()        is_dra7xx()
>>>>>>>> +# define soc_is_dra75x()        is_dra75x()
>>>>>>> since this platform is DT-only, couldn't we just believe DT-data to be
>>>>>>> correct of_machine_is_compatible() ? 2/3 of this patch would be removed.
>>>>>>>
>>>>>>> I patched this for OMAP5 (compile-tested only, no boards available) and
>>>>>>> came out with the patch below (still needs to be split):
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>>>>>>> index 08b7267..b3136e5 100644
>>>>>>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>>>>>>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>>>>>>> @@ -13,7 +13,7 @@
>>>>>>>
>>>>>>>   / {
>>>>>>>       model = "TI OMAP5 uEVM board";
>>>>>>> -    compatible = "ti,omap5-uevm", "ti,omap5";
>>>>>>> +    compatible = "ti,omap5-uevm", "ti,omap5432-es2.0", "ti,omap5";
>>>>>>>
>>>>>>   ok, nice and simpler way.
>>>>>>   But would this make different revisions, to appear the same ?
>>>>> well omap5-uevm is omap5432 es2.0 only, right ? If a new board comes up,
>>>>> it should be treated as such, then you can pass a different string to
>>>>> that new board's compatible attribute.
>>>>> s
>>>>   Yes for OMAP5. I was thinking in general about this approach.
>>>>   For example, for OMAP4 we have same board and
>>>>   different revisions can be socketed there.
>>>>
>>>>   For OMAP5, this is good.
>>> do we really production socketed boards? Well, at least Blaze has such
>>> thing. But do we have too many differences that need to be trated at
>>> arch/arm or should/could those be handled by reading IP's revision
>>> register (e.g. usb host erratas)
>>>
>>   OMAP4 SDP is socketed as well.
> a) OMAP4SDP is not production device
> b) OMAP4SDP uses SOM (System On Module)
> c) Socketted SOMs were used only during initial days of SoC
> d) almost all latest OMAP4 SDP switched to using soldered in SOM
> e) we claim compatibility of OMAP4 SDP with Blaze.
> 
> So, I dont think this is a rational argument for keeping soc checks with dts.

What about OMAP4 pandas? I for instance, have an old 4430 panda and I have no idea
if its a es2.1 or a es2.3 or something else. If we start relying on dt to pass the
right revision check then (we need to create different dts files for these to begin with) I
need to know exactly what silicon rev I am running on.

I know its good to completely get rid of all silicon rev checks and depend on IP revisions
but we have had various IPs which do not have proper rev checks. We have I guess most often
used these to identify PRCM differences.

Tony, what do you suggest we do for this series? Since we have just an es1.0 and one board
at this point for dra7xx, things would be fine even if we do a dt based parsing to identify
the device, and I am fine with it if thats what we feel is the right way forward.
For the rest of the DT only platforms (omap4/5/am335x) anyway getting rid of these rev checks
from the kernel and depending on DT parsing needs to be a separate series anyway and I dont
plan to address those as part of this series.

> 
>>   Ya, revision checks used only in few places and as you said
>>   we handle them using IP revisions, but that we have to look and clean
>>   up those places, if we really intend to do this for other socs.
> 
> I agree this is the right approach :).
> 
> 
