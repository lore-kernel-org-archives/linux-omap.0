From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/7] mfd: omap: control: core system
	control driver
Date: Wed, 8 Aug 2012 06:48:50 -0700
Message-ID: <20120808134849.GC11011@atomide.com>
References: <4FEB4B46.9020904@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FEB4B46.9020904@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: amit.kucheria@linaro.org, kishon@ti.com, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120627 11:09]:
> +
> +/* TODO: Add helpers for 16bit and byte access */
> +#ifdef CONFIG_MFD_OMAP_CONTROL
> +u32 omap_control_status_read(u16 offset);
> +#else
> +static inline u32 omap_control_status_read(u16 offset)
> +{
> +	return 0;
> +}
> +#endif

This should be an exported function instead. And it should
not need the offset as a parameter as the SCM core should know
where to find it's control_status register.

Regards,

Tony
