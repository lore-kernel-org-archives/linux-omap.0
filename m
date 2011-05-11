From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap3: cm-t3517: fix section mismatch warning
Date: Wed, 11 May 2011 10:37:38 +0300
Message-ID: <4DCA3CC2.8080006@compulab.co.il>
References: <1303850474-25106-1-git-send-email-grinberg@compulab.co.il>
	<4DC01FB2.9060806@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4DC01FB2.9060806@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

ping x2


Can this one get into .39?


On 05/03/11 18:30, Igor Grinberg wrote:

> ping!
>
> Just to make sure you haven't missed this one liner ;)
>
>
> On 04/26/11 23:41, Igor Grinberg wrote:
>> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x11014): Section mismatch
>> in reference from the function cm_t3517_init_usbh() to the (unknown
>> reference) .init.data:(unknown)
>> The function cm_t3517_init_usbh() references
>> the (unknown reference) __initdata (unknown).
>> This is often because cm_t3517_init_usbh lacks a __initdata
>> annotation or the annotation of (unknown) is wrong.
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>>  arch/arm/mach-omap2/board-cm-t3517.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
>> index a27e3ee..802cb60 100644
>> --- a/arch/arm/mach-omap2/board-cm-t3517.c
>> +++ b/arch/arm/mach-omap2/board-cm-t3517.c
>> @@ -178,7 +178,7 @@ static struct usbhs_omap_board_data cm_t3517_ehci_pdata __initdata = {
>>  	.reset_gpio_port[2]  = -EINVAL,
>>  };
>>  
>> -static int cm_t3517_init_usbh(void)
>> +static int __init cm_t3517_init_usbh(void)
>>  {
>>  	int err;
>>  

-- 
Regards,
Igor.
