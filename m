From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/7] OMAP: mux: Add support for control module split in
 several partitions
Date: Mon, 15 Nov 2010 22:46:50 +0100
Message-ID: <4CE1AA4A.10602@ti.com>
References: <1289511321-18532-1-git-send-email-b-cousson@ti.com> <1289511321-18532-3-git-send-email-b-cousson@ti.com> <20101115200316.GK9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41340 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758557Ab0KOVq0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 16:46:26 -0500
In-Reply-To: <20101115200316.GK9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Tony,

On 11/15/2010 9:03 PM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [101111 13:26]:
>> Starting on OMAP4, the pin mux configuration is located in two
>> different partitions of the control module (CODE_PAD and WKUP_PAD).
>> The first one is inside the core power domain whereas the second
>> one is inside the wakeup.
>> - Add the capability to add any number of partition during board init
>> time depending of Soc partitioning.
>> - Add some init flags as well in order to avoid explicit Soc version
>> check inside the mux core code.
>> - Add a comment with mux0 mode on top of omap_mux/board/<partition>
>> if the current mux mode is not the default one.
>
> Here's one more patch that I'd like to merge into this patch to avoid
> repeating the partition for each mux entry.

The memory vendors will not like you ;-)

> Assuming no more comments, I'll queue these for 2.6.38 merge window.

I'll update the series and re-post tomorrow.

Thanks,
Benoit

>
> Regards,
>
> Tony
>
>
> From: Tony Lindgren<tony@atomide.com>
> Date: Mon, 15 Nov 2010 11:52:20 -0800
> Subject: [PATCH] omap: mux: Save memory for struct omap_mux
>
> There's no need to repeat the partition for each mux entry.
> We can look up the partition for debugfs.
>
> Signed-off-by: Tony Lindgren<tony@atomide.com>
>
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -348,14 +348,37 @@ static const struct file_operations omap_mux_dbg_board_fops = {
>   	.release	= single_release,
>   };
>
> +static struct omap_mux_partition * omap_mux_get_partition(struct omap_mux *mux)
> +{
> +	struct omap_mux_partition *partition;
> +
> +	list_for_each_entry(partition,&mux_partitions, node) {
> +		struct list_head *muxmodes =&partition->muxmodes;
> +		struct omap_mux_entry *e;
> +
> +		list_for_each_entry(e, muxmodes, node) {
> +			struct omap_mux *m =&e->mux;
> +
> +			if (m == mux)
> +				return partition;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
>   static int omap_mux_dbg_signal_show(struct seq_file *s, void *unused)
>   {
>   	struct omap_mux *m = s->private;
> -	struct omap_mux_partition *partition = m->partition;
> +	struct omap_mux_partition *partition;
>   	const char *none = "NA";
>   	u16 val;
>   	int mode;
>
> +	partition = omap_mux_get_partition(m);
> +	if (!partition)
> +		return 0;
> +
>   	val = omap_mux_read(partition, m->reg_offset);
>   	mode = val&  OMAP_MUX_MODE7;
>
> @@ -391,6 +414,7 @@ static ssize_t omap_mux_dbg_signal_write(struct file *file,
>   	struct omap_mux *m;
>   	unsigned long val;
>   	int buf_size, ret;
> +	struct omap_mux_partition *partition;
>
>   	if (count>  OMAP_MUX_MAX_ARG_CHAR)
>   		return -EINVAL;
> @@ -411,7 +435,11 @@ static ssize_t omap_mux_dbg_signal_write(struct file *file,
>   	seqf = file->private_data;
>   	m = seqf->private;
>
> -	omap_mux_write(m->partition, (u16)val, m->reg_offset);
> +	partition = omap_mux_get_partition(m);
> +	if (!partition)
> +		return -ENODEV;
> +
> +	omap_mux_write(partition, (u16)val, m->reg_offset);
>   	*ppos += count;
>
>   	return count;
> @@ -440,7 +468,6 @@ static void __init omap_mux_dbg_create_entry(
>
>   	list_for_each_entry(e,&partition->muxmodes, node) {
>   		struct omap_mux *m =&e->mux;
> -		m->partition = partition;
>
>   		(void)debugfs_create_file(m->muxnames[0], S_IWUGO, mux_dbg_dir,
>   					  m,&omap_mux_dbg_signal_fops);
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -121,7 +121,6 @@ struct omap_mux {
>   	char	*muxnames[OMAP_MUX_NR_MODES];
>   #ifdef CONFIG_DEBUG_FS
>   	char	*balls[OMAP_MUX_NR_SIDES];
> -	struct omap_mux_partition *partition;
>   #endif
>   #endif
>   };
>

