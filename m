From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]  H4 / 2430SDP ethernet IRQ flags fix
Date: Thu, 16 Nov 2006 02:32:15 +0200
Message-ID: <20061116003215.GI21064@atomide.com>
References: <20061115232522.GG21064@atomide.com>
	<77C7F7CB1230A74A9D19C0C111E6EDBE01E4220D@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01E4220D@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [061116 01:36]:
> Hi Tony,
> 
> +#ifdef CONFIG_ARCH_OMAP1
> +#define	SMC_IRQ_FLAGS	(machine_is_omap_innovator() ?
> IRQF_TRIGGER_RISING : \
> +				IRQF_TRIGGER_FALLING)
> +#else
> +#define SMC_IRQ_FLAGS		IRQF_TRIGGER_LOW
> +#endif
> 
> This looks fine to me, please push this one.

Thanks, pushed.

Regards,

Tony
