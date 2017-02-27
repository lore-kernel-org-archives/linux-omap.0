From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: ARM: OMAP2+: Grab reference to device nodes where needed
Date: Mon, 27 Feb 2017 15:34:05 -0800
Message-ID: <20170227233405.GA16546@roeck-us.net>
References: <1486853948-20978-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1486853948-20978-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Qi Hou <qi.hou@windriver.com>, linux-omap@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

ping ... this problem is now seen in mainline.

Guenter

On Sat, Feb 11, 2017 at 02:59:08PM -0800, Guenter Roeck wrote:
> After commit 'of: fix of_node leak caused in of_find_node_opts_by_path',
> the following error may be reported when running omap images.
> 
> OF: ERROR: Bad of_node_put() on /ocp@68000000
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.10.0-rc7-next-20170210 #1
> Hardware name: Generic OMAP3-GP (Flattened Device Tree)
> [<c0310604>] (unwind_backtrace) from [<c030bbf4>] (show_stack+0x10/0x14)
> [<c030bbf4>] (show_stack) from [<c05add8c>] (dump_stack+0x98/0xac)
> [<c05add8c>] (dump_stack) from [<c05af1b0>] (kobject_release+0x48/0x7c)
> [<c05af1b0>] (kobject_release)
> 	from [<c0ad1aa4>] (of_find_node_by_name+0x74/0x94)
> [<c0ad1aa4>] (of_find_node_by_name)
> 	from [<c1215bd4>] (omap3xxx_hwmod_is_hs_ip_block_usable+0x24/0x2c)
> [<c1215bd4>] (omap3xxx_hwmod_is_hs_ip_block_usable) from
> [<c1215d5c>] (omap3xxx_hwmod_init+0x180/0x274)
> [<c1215d5c>] (omap3xxx_hwmod_init)
> 	from [<c120faa8>] (omap3_init_early+0xa0/0x11c)
> [<c120faa8>] (omap3_init_early)
> 	from [<c120fb2c>] (omap3430_init_early+0x8/0x30)
> [<c120fb2c>] (omap3430_init_early)
> 	from [<c1204710>] (setup_arch+0xc04/0xc34)
> [<c1204710>] (setup_arch) from [<c1200948>] (start_kernel+0x68/0x38c)
> [<c1200948>] (start_kernel) from [<8020807c>] (0x8020807c)
> 
> of_find_node_by_name() drops the reference to the passed device node,
> so it is necessary to grab an extra one if it is still needed after the
> call.
> 
> Cc: Qi Hou <qi.hou@windriver.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 56f917ec8621..d4ca1e3964c3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -3117,6 +3117,7 @@ static int __init omap3xxx_hwmod_is_hs_ip_block_usable(struct device_node *bus,
>  	if (!bus)
>  		return (omap_type() == OMAP2_DEVICE_TYPE_GP) ? 1 : 0;
>  
> +	of_node_get(bus);
>  	if (of_device_is_available(of_find_node_by_name(bus, dev_name)))
>  		return 1;
>  
> @@ -3189,15 +3190,20 @@ int __init omap3xxx_hwmod_init(void)
>  
>  	if (h_sham && omap3xxx_hwmod_is_hs_ip_block_usable(bus, "sham")) {
>  		r = omap_hwmod_register_links(h_sham);
> -		if (r < 0)
> +		if (r < 0) {
> +			of_node_put(bus);
>  			return r;
> +		}
>  	}
>  
>  	if (h_aes && omap3xxx_hwmod_is_hs_ip_block_usable(bus, "aes")) {
>  		r = omap_hwmod_register_links(h_aes);
> -		if (r < 0)
> +		if (r < 0) {
> +			of_node_put(bus);
>  			return r;
> +		}
>  	}
> +	of_node_put(bus);
>  
>  	/*
>  	 * Register hwmod links specific to certain ES levels of a
