From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v8 4/8] ARM: davinci: Consolidate time keeping and irq
 enable
Date: Wed, 21 Mar 2012 15:33:33 +0000
Message-ID: <DF0F476B391FA8409C78302C7BA518B631800A07@DBDE01.ent.ti.com>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <1332274969-15782-5-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1332274969-15782-5-git-send-email-rob.lee@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Lee <rob.lee@linaro.org>, "len.brown@intel.com" <len.brown@intel.com>
Cc: "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "venki@google.com" <venki@google.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "ccross@google.com" <ccross@google.com>, "kernel@wantstofly.org" <kernel@wantstofly.org>, "Hilman,
 Kevin" <khilman@ti.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "arnd.bergmann@linaro.org" <arnd.bergmann@linaro.org>, "Hunter,
 Jon" <jon-hunter@ti.com>, "patches@linaro.org" <patches@linaro.org>, "jean.pihet@newoldbits.com" <jean.pihet@newoldbits.com>, rjw@sisk
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On Wed, Mar 21, 2012 at 01:52:45, Robert Lee wrote:
> Enable core cpuidle timekeeping and irq enabling and remove that
> handling from this code.
> 
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Jean Pihet<j-pihet@ti.com>

>  static struct cpuidle_driver davinci_idle_driver = {
> -	.name	= "cpuidle-davinci",
> -	.owner	= THIS_MODULE,
> +	.name		= "cpuidle-davinci",
> +	.owner		= THIS_MODULE,
> +	.states[0]	= ARM_CPUIDLE_WFI_STATE,
> +	.states[1]	= {
> +		.enter			= davinci_enter_idle,
> +		.exit_latency		= 10,
> +		.target_residency	= 100000,

Apart from your other fix patch, can you also update the
target residency of this state to 10000 as is the case
with current code? With the new value the board is entering
this state really infrequently.

Thanks,
Sekhar
