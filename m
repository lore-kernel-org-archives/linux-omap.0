From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: fixup doc comments in omap_device
Date: Mon, 11 Nov 2019 12:49:50 -0800
Message-ID: <20191111204950.GZ5610@atomide.com>
References: <20191106115945.4298-1-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191106115945.4298-1-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Ben Dooks (Codethink) <ben.dooks@codethink.co.uk> [191106 04:00]:
> The documentation comments in this file are out of
> date with the code, so fix this to avoid the
> following warnings:
> 
> arch/arm/mach-omap2/omap_device.c:133: warning: Function parameter or member 'pdev' not described in 'omap_device_build_from_dt'
> arch/arm/mach-omap2/omap_device.c:133: warning: Excess function parameter 'pdev_name' description in 'omap_device_build_from_dt'
> arch/arm/mach-omap2/omap_device.c:133: warning: Excess function parameter 'pdev_id' description in 'omap_device_build_from_dt'
> arch/arm/mach-omap2/omap_device.c:133: warning: Excess function parameter 'oh' description in 'omap_device_build_from_dt'
> arch/arm/mach-omap2/omap_device.c:133: warning: Excess function parameter 'pdata' description in 'omap_device_build_from_dt'
> arch/arm/mach-omap2/omap_device.c:133: warning: Excess function parameter 'pdata_len' description in 'omap_device_build_from_dt'
> arch/arm/mach-omap2/omap_device.c:309: warning: Function parameter or member 'pdev' not described in 'omap_device_get_context_loss_count'
> arch/arm/mach-omap2/omap_device.c:309: warning: Excess function parameter 'od' description in 'omap_device_get_context_loss_count'
> arch/arm/mach-omap2/omap_device.c:335: warning: Function parameter or member 'ohs' not described in 'omap_device_alloc'
> arch/arm/mach-omap2/omap_device.c:335: warning: Function parameter or member 'oh_cnt' not described in 'omap_device_alloc'
> arch/arm/mach-omap2/omap_device.c:335: warning: Excess function parameter 'oh' description in 'omap_device_alloc'
> arch/arm/mach-omap2/omap_device.c:335: warning: Excess function parameter 'pdata' description in 'omap_device_alloc'
> arch/arm/mach-omap2/omap_device.c:335: warning: Excess function parameter 'pdata_len' description in 'omap_device_alloc'
> arch/arm/mach-omap2/omap_device.c:659: warning: Function parameter or member 'pdev' not described in 'omap_device_register'
> arch/arm/mach-omap2/omap_device.c:659: warning: Excess function parameter 'od' description in 'omap_device_register'
> arch/arm/mach-omap2/omap_device.c:682: warning: Function parameter or member 'pdev' not described in 'omap_device_enable'
> arch/arm/mach-omap2/omap_device.c:682: warning: Excess function parameter 'od' description in 'omap_device_enable'
> arch/arm/mach-omap2/omap_device.c:713: warning: Function parameter or member 'pdev' not described in 'omap_device_idle'
> arch/arm/mach-omap2/omap_device.c:713: warning: Excess function parameter 'od' description in 'omap_device_idle'

Thanks applying into omap-for-v5.5/soc.

Tony
