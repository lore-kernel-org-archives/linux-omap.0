From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 1/4] ARM: OMAP4+: PM: Consolidate MPU subsystem PM
 code for re-use
Date: Fri, 5 Apr 2013 19:07:57 +0530
Message-ID: <515ED3B5.2040502@ti.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-2-git-send-email-santosh.shilimkar@ti.com>
 <20130405131935.GM11464@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130405131935.GM11464@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 05 April 2013 06:49 PM, Felipe Balbi wrote:
> On Fri, Apr 05, 2013 at 06:29:00PM +0530, Santosh Shilimkar wrote:
>> OMAP5 and future OMAP based SOCs has backward compatible MPUSS
>> IP block with OMAP4. It's programming model is mostly similar.
> 
> s/It's/Its/
> s/mostly //
> 
> (similar already expands to 'almost the same' :-)
> 
>> @@ -355,6 +389,12 @@ int __init omap4_mpuss_init(void)
>>  
>>  	save_l2x0_context();
>>  
>> +	if (cpu_is_omap44xx()) {
>> +		omap_pm_ops.finish_suspend = omap4_finish_suspend;
>> +		omap_pm_ops.resume = omap4_cpu_resume;
>> +		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
>> +	}
> 
> why don't you just rename omap4_* into omap_* and add cpu-based checks
> there in order to handle differences between omap4 and omap5?
> 
The whole idea is to handle all these SOC specific stuff in init and
not sprinkle the checks in runtime code.

> If implementation will be almost the same for both, you might be able to
> save on some more duplication, no ?
> 
The implementation is not same and hence. If it was same, I wouldn't
have introduced function pointers :)

Regards,
Santosh
