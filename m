From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: wakeupgen: AM43x adaptation
Date: Wed, 9 Oct 2013 12:52:47 +0530
Message-ID: <52550447.5070805@ti.com>
References: <1378378535-2967-1-git-send-email-afzal@ti.com>
 <20131008212436.GR8313@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131008212436.GR8313@atomide.com>
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
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wednesday 09 October 2013 02:54 AM, Tony Lindgren wrote:
> * Afzal Mohammed <afzal@ti.com> [130905 04:03]:

>> -#define MAX_NR_REG_BANKS	5
>> -#define MAX_IRQS		160
>> +/* maximum value correspond to that of AM43x */
>> +#define MAX_NR_REG_BANKS	7
>> +#define MAX_IRQS		224
>> +#define DEFAULT_NR_REG_BANKS	5
>> +#define DEFAULT_IRQS		160
>>  #define WKG_MASK_ALL		0x00000000
>>  #define WKG_UNMASK_ALL		0xffffffff
>>  #define CPU_ENA_OFFSET		0x400
> 
> How about define it like this to avoid updating things
> in multiple places for new SoCs:
> 
> #define AM43X_NR_REG_BANKS	7
> #define MAX_NR_REG_BANKS	AM43X_NR_REG_BANKS

Yes that is better

>>  	for (i = 0; i < irq_banks; i++) {
>>  		wakeupgen_writel(0, i, CPU0_ID);
>> -		wakeupgen_writel(0, i, CPU1_ID);
>> +		if (!am43x)
>> +			wakeupgen_writel(0, i, CPU1_ID);
>>  	}
> 
> Why not use soc_is_am43xx() directly here?

Ok, it has been changed in the new version.

Regards
Afzal
