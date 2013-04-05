From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: OMAP4+: Correct L3 interrupts
Date: Fri, 5 Apr 2013 10:08:23 +0200
Message-ID: <515E8677.40404@ti.com>
References: <1365098790-9078-1-git-send-email-jon-hunter@ti.com>
 <515E6EAE.9000107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <515E6EAE.9000107-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/05/2013 08:26 AM, Santosh Shilimkar wrote:
> On Thursday 04 April 2013 11:36 PM, Jon Hunter wrote:
>> The L3 interrupt numbers are incorrect for OMAP4+ and are conflicting
>> with some of the timer interrupts causing the allocation of timer
>> interrupts to fail.
>>
>> The problem is caused by adding 32 to the interrupt number for the L3
>> interrupts to account for per processor interrupts (PPI) and software
>> generated interrupts (SGI) which typically are mapped to the first 32
>> interrupts in the ARM GIC. This is not necessary because the first
>> parameter of the ARM GIC interrupt property specifies the GIC interrupt
>> type (ie. SGI, PPI, etc). Hence, fix the interrupt number fo the L3
>> interrupts by substracting 32.
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
>> ---
>>
>> Please note that this problem is observed in Benoit's for_3.10/dts branch [1].
>>
>> [1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git
>>
> Thats correct. I overlooked the 32 addition part. This patch should
> also be pulled into Benoit's 3.10 tree.

Done. I've just applied it. But I will probably merge it with the
original patch, because having a broken patch and the fix in the same
pull request does not look right.

> For the patch,
> Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>

Thanks,
Benoit
