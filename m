From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] Power off on state counter debugging
Date: Thu, 04 Sep 2008 22:20:44 +0300
Message-ID: <48C0350C.6080005@deeprootsystems.com>
References: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com> <1216904434-7545-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:33709 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbYIDTUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 15:20:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so513762fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 12:20:48 -0700 (PDT)
In-Reply-To: <1216904434-7545-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Peter 'p2' De Schrijver wrote:
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  arch/arm/mach-omap2/Makefile                  |    2 +-
>  arch/arm/mach-omap2/off-state-counter-debug.c |   50 +++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/off-state-counter-debug.c

How about calling this powerdomain-debug.c and conditionally compiling 
based on CONFIG_PM_DEBUG.

There will probably be some other things besides off-mode counters to 
add here down the road.

Kevin

> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 0d8507c..a48f832 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -5,7 +5,7 @@
>  # Common support
>  obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
>  		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
> -		clockdomain.o
> +		clockdomain.o off-state-counter-debug.o
>  
>  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>  
> diff --git a/arch/arm/mach-omap2/off-state-counter-debug.c b/arch/arm/mach-omap2/off-state-counter-debug.c
> new file mode 100644
> index 0000000..7db54b6
> --- /dev/null
> +++ b/arch/arm/mach-omap2/off-state-counter-debug.c
> @@ -0,0 +1,50 @@
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <asm/arch/powerdomain.h>
> +
> +
> +int show_off_mode_count(struct powerdomain *pwrdm, void *user)
> +{
> +	struct seq_file *s = (struct seq_file *)user;
> +
> +	if (strcmp(pwrdm->name, "emu_pwrdm") &&
> +		strcmp(pwrdm->name, "wkup_pwrdm"))
> +		seq_printf(s, "%s : %d\n", pwrdm->name, pwrdm->offstate_count);
> +
> +	return 0;
> +}
> +
> +int show_off_mode_counters(struct seq_file *s, void *unused)
> +{
> +	pwrdm_for_each(show_off_mode_count, s);
> +
> +	return 0;
> +}
> +
> +static int off_mode_counter_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, show_off_mode_counters, &inode->i_private);
> +}
> +
> +static const struct file_operations debug_fops = {
> +	.open	= off_mode_counter_open,
> +	.read	= seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static int __init off_mode_counter_debug(void)
> +{
> +	struct dentry *d;
> +
> +	d = debugfs_create_dir("off_mode_counters", NULL);
> +	if (IS_ERR(d))
> +		return PTR_ERR(d);
> +
> +	debugfs_create_file("count", S_IRUGO,
> +				d, NULL, &debug_fops);
> +
> +	return 0;
> +}
> +
> +late_initcall(off_mode_counter_debug);

