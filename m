From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 4/4] omap2: powerdomain: Inroduce cpu_pm notifiers for
 context save/restore
Date: Fri, 18 May 2018 10:02:06 +0530
Message-ID: <7df065c3-5154-5059-891c-2855e3cdbe00@ti.com>
References: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
 <1526483821-25585-5-git-send-email-j-keerthy@ti.com>
 <20180517214507.GS98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180517214507.GS98604@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Friday 18 May 2018 03:15 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180516 15:21]:
>> +	/* Only AM43XX can lose pwrdm context during rtc-ddr suspend */
>> +	if (soc_is_am43xx()) {
>> +		nb.notifier_call = cpu_notifier;
>> +		cpu_pm_register_notifier(&nb);
>> +	}
>> +
> 
> Hmm in patch 3/4 you add omap4_pwrdm_save_context(), I think
> that we'd want to run with the notifier for cpuidle on omap4?

Okay i believe that is not needed for cpuidle on omap4. PRCM on wakeup
domain so save/restore not needed for powerdomain on omap4.

Tero can confirm the same.

Should i rename omap4_pwrdm_save_context to am43xx_pwrdm_save_context to
avoid confusion?

Regards,
Keerthy

> 
> Regards,
> 
> Tony
> 
