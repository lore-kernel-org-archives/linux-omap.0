From: Xiao Jiang <jgq516@gmail.com>
Subject: Re: [PATCH 0/3] omap3/omap4: add device tree support for wdt
Date: Wed, 30 May 2012 18:14:33 +0800
Message-ID: <4FC5F309.9080604@gmail.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
 <4FC50BA2.4070404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FC50BA2.4070404@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, wim@iguana.be, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Jon Hunter wrote:
> Hi Xiao Jiang,
>
> On 05/25/2012 05:42 AM, jgq516@gmail.com wrote:
>   
>> From: Xiao Jiang <jgq516@gmail.com>
>>
>> This series can be applied to dt branch of linux-omap tree.
>>     
>
> Thanks for sending this!
>
>   
>> Since omap24xx series has different wdt base addr (omap2420: 0x48022000 and
>> omap2430: 0x49016000) per commit 2817142f31bfbf26c216bf4f9192540c81b2d071, so
>> I don't add wdt node in omap2.dtsi just like omap3 and omap4, maybe different
>> dts files are needed for omap2420 and omap2430.
>>     
>
> Good point. I am wondering if we can simple drop the address from the
> wdt2 node for omap2. It is not really being used. May be Benoit can comment.
>
>   
Hmm, I think the address doesn't need anymore since the related hw_mod 
has the right addr as follows.

static struct omap_hwmod_addr_space omap2420_wd_timer2_addrs[] = {
        {  
                .pa_start       = 0x48022000,
                .pa_end         = 0x4802207f,
                .flags          = ADDR_TYPE_RT
        }, 
        { }
};

static struct omap_hwmod_addr_space omap2430_wd_timer2_addrs[] = {
        {  
                .pa_start       = 0x49016000,
                .pa_end         = 0x4901607f,
                .flags          = ADDR_TYPE_RT
        }, 
        { }
};

static struct omap_hwmod_addr_space omap3xxx_wd_timer2_addrs[] = {
        {   
                .pa_start       = 0x48314000,
                .pa_end         = 0x4831407f,
                .flags          = ADDR_TYPE_RT
        },  
        { } 
};

static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] = {
        {   
                .pa_start       = 0x4a313000,
                .pa_end         = 0x4a31407f,
                .flags          = ADDR_TYPE_RT
        },  
        { } 
};

Regards,
Xiao
> Cheers
> Jon
