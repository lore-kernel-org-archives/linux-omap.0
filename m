From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 16/25] OMAP4: PM: Program CPU1 to hit OFF when off-lined
Date: Mon, 12 Sep 2011 14:12:55 -0700
Message-ID: <87mxe9ea7c.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-17-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315144466-9395-17-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:17 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Program non-boot CPUs to hit lowest supported power state
> when it is off-lined using cpu hotplug framework.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

[...]

> @@ -39,15 +43,15 @@ void platform_cpu_die(unsigned int cpu)
>  	 * we're ready for shutdown now, so do it
>  	 */
>  	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
> -		printk(KERN_CRIT "Secure clear status failed\n");
> +		pr_err("Secure clear status failed\n");

nit: pr_crit() exists if you want to keep the same level.  Or did you
lower the level on purpose?

Kevin
