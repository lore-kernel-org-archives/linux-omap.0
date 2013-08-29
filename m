From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: OMAP4+: Move SRAM data to DT
Date: Thu, 29 Aug 2013 19:14:50 +0530
Message-ID: <521F5052.90308@ti.com>
References: <1377775391-13103-1-git-send-email-rnayak@ti.com>
 <1377775391-13103-3-git-send-email-rnayak@ti.com> <521F4BE9.60004@ti.com>
 <521F4D41.4010303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <521F4D41.4010303@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 8/29/2013 7:01 PM, Santosh Shilimkar wrote:
> On Thursday 29 August 2013 09:26 AM, Sekhar Nori wrote:
>> On 8/29/2013 4:53 PM, Rajendra Nayak wrote:
>>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>>> index 22d9f2b..1ba6a77 100644
>>> --- a/arch/arm/boot/dts/omap4.dtsi
>>> +++ b/arch/arm/boot/dts/omap4.dtsi
>>> @@ -126,6 +126,11 @@
>>>  			pinctrl-single,function-mask = <0x7fff>;
>>>  		};
>>>  
>>> +		ocmcram: ocmcram@40304000 {
>>
>> This can now be changed to 0x40300000 now that you have moved to
>> gen_pool_alloc()?
>>
> NO.
> It won't work on secure devices since first 16 KB is occupied for
> default configuration. Its not worth trouble also to handle
> secure/non-secure considering the use of SRAM which is actually just
> limited to errata. 40304000 will work for both devices.

Okay, the same problem is not applicable to OMAP5 and other devices? I
am okay with this as such, may be just add a comment explaining why
there is an offset.

Thanks,
Sekhar
