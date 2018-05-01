From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: powerdomain: use raw_smp_processor_id() for
 trace
Date: Tue, 1 May 2018 07:50:40 -0700
Message-ID: <20180501145040.GH5671@atomide.com>
References: <1520589020-14018-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1520589020-14018-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [180309 01:51]:
> smp_processor_id() checks preemption if CONFIG_DEBUG_PREEMPT is enabled,
> causing a warning dump during boot:
> 
> [    5.042377] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> [    5.050281] caller is pwrdm_set_next_pwrst+0x48/0x88
> [    5.055330] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.14.24-g57341df0b4 #1
> 
> Use the raw_smp_processor_id() for the trace instead, this value does
> not need to be perfectly correct. The alternative of disabling preempt
> is too heavy weight operation to be applied in PM hot path for just
> tracing purposes.

Sorry just noticed this is still pending while looking through
my inbox. Applying into omap-for-v4.17/fixes.

Regards,

Tony
