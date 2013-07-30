From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/8] ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
Date: Tue, 30 Jul 2013 18:18:44 +0530
Message-ID: <51F7B62C.9010407@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-4-git-send-email-rnayak@ti.com> <51F7B100.2020600@ti.com>
 <51F7B3E0.9020005@ti.com> <51F7B483.8060908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F7B483.8060908@ti.com>
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
Cc: paul@pwsan.com, khilman@linaro.org, tony@atomide.com, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 30 July 2013 06:11 PM, Nishanth Menon wrote:
> On 07/30/2013 07:38 AM, Rajendra Nayak wrote:
>> On Tuesday 30 July 2013 05:56 PM, Nishanth Menon wrote:
>>> On 07/30/2013 06:25 AM, Rajendra Nayak wrote:
>>>> From: R Sricharan <r.sricharan@ti.com>
>>> [...]
>>>>    # Clock framework
>>>>    obj-$(CONFIG_ARCH_OMAP2)        += $(clock-common) clock2xxx.o
>>>> @@ -181,6 +187,8 @@ obj-$(CONFIG_SOC_AM33XX)        += $(clock-common) dpll3xxx.o
>>>>    obj-$(CONFIG_SOC_AM33XX)        += cclock33xx_data.o
>>>>    obj-$(CONFIG_SOC_OMAP5)            += $(clock-common)
>>>>    obj-$(CONFIG_SOC_OMAP5)            += dpll3xxx.o dpll44xx.o
>>>> +obj-$(CONFIG_SOC_DRA7XX)        += $(clock-common)
>>>> +obj-$(CONFIG_SOC_DRA7XX)        += dpll3xxx.o dpll44xx.o
>>>>
>>>
>>> are these in sync with DRA7 support being introduced for clock data in [1]?
>>
>> I don't want to have a dependency on those patches since I am not sure of them
>> making it into 3.12.
> 
> Then we have to undo these changes again in clock data support. the chip wont bootup anyways without clock data information, so why not try and keep the changes that Tero is doing independent of these changes?

I still have something with clock data information which boots which I am maintaining out of tree till the clock movement to DT is sorted out.
Maybe what you are suggesting is quite trivial and I am unable to understand. Are you suggesting we do no compile $(clock-common) and the
dpll files for DRA7? Is that what you are worried we might have to revert?

> 
>>
>>>
>>>
>>> [1] http://marc.info/?l=linux-omap&m=137456411706971&w=2
>>>
>>
> 
> 
