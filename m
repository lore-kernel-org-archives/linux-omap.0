From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 2/3] Add pm-debug counters
Date: Wed, 15 Oct 2008 12:54:12 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE39430A104C0@vaebe110.NOE.Nokia.com>
References: <1223995198-19985-1-git-send-email-peter.de-schrijver@nokia.com><1223995198-19985-2-git-send-email-peter.de-schrijver@nokia.com><1223995198-19985-3-git-send-email-peter.de-schrijver@nokia.com> <871vyicrp3.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34940 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbYJOJyt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 05:54:49 -0400
Content-class: urn:content-classes:message
In-Reply-To: <871vyicrp3.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jouni.hogander@nokia.com, Peter.De-Schrijver@nokia.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org



>"ext Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
>
>> This patch provides the debugfs entries and a function which will be=
=20
>> called by the PM code to register the time spent per domain=20
>per state.
>>
>> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com=
>
>> ---
>>  arch/arm/mach-omap2/pm-debug.c                |  175=20
>+++++++++++++++++++++++++
>>  arch/arm/mach-omap2/pm.h                      |    2 +
>>  2 files changed, 177 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/pm-debug.c=20
>> b/arch/arm/mach-omap2/pm-debug.c index 0b5c044..4ba6cec 100644
>> --- a/arch/arm/mach-omap2/pm-debug.c
>> +++ b/arch/arm/mach-omap2/pm-debug.c
>> @@ -29,6 +29,8 @@
>> =20
>>  #include <mach/clock.h>
>>  #include <mach/board.h>
>> +#include <mach/powerdomain.h>
>> +#include <mach/clockdomain.h>
>> =20
>>  #include "prm.h"
>>  #include "cm.h"
>> @@ -288,4 +290,177 @@ void omap2_pm_dump(int mode, int=20
>resume, unsigned int us)
>>  		printk("%-20s: 0x%08x\n", regs[i].name, regs[i].val);  }
>> =20
>> +#ifdef CONFIG_DEBUG_FS
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>> +
>> +struct dentry *pm_dbg_dir;
>> +
>> +static int pm_dbg_init_done;
>> +
>> +enum {
>> +	DEBUG_FILE_COUNTERS =3D 0,
>> +	DEBUG_FILE_TIMERS,
>> +};
>> +
>> +static const char pwrdm_state_names[][4] =3D {
>> +	"OFF",
>> +	"RET",
>> +	"INA",
>> +	"ON"
>> +};
>> +
>> +void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {
>> +	s64 t;
>> +	struct timespec now;
>> +
>> +	if (!pm_dbg_init_done)
>> +		return ;
>> +
>> +	/* Update timer for previous state */
>> +	getnstimeofday(&now);
>> +	t =3D timespec_to_ns(&now);
>> +
>> +	pwrdm->state_timer[prev] +=3D t - pwrdm->timer;
>> +
>> +	pwrdm->timer =3D t;
>> +}
>> +
>> +static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void=20
>> +*user) {
>> +	struct seq_file *s =3D (struct seq_file *)user;
>> +
>> +	if (strcmp(clkdm->name, "emu_clkdm") =3D=3D 0 ||
>> +		strcmp(clkdm->name, "wkup_clkdm") =3D=3D 0)
>> +		return 0;
>
>Why emu and wkup are not taken into account? If wkup is closed=20
>out here, I think also prm_clkdm and cm_clkdm should be.
>
>> +
>> +	seq_printf(s, "%s->%s (%d)", clkdm->name,
>> +			clkdm->pwrdm.ptr->name,
>> +			atomic_read(&clkdm->usecount));
>> +	seq_printf(s, "\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void=20
>> +*user) {
>> +	struct seq_file *s =3D (struct seq_file *)user;
>> +	int i;
>> +
>> +	if (strcmp(pwrdm->name, "emu_pwrdm") =3D=3D 0 ||
>> +		strcmp(pwrdm->name, "wkup_pwrdm") =3D=3D 0)
>> +		return 0;
>
>Why emu is closed out here? It has pwstst register.

I closed out emu and wkup powerdomains here because they
did not show any useful information. They are missing either
prepwstst or pwstst register and this debug stuff relies on
accessibility of both of them. If you do not have one, you
get "interesting" results (missing prepwstst =3D> OFF count hits
the roof as the software assumes you are entering off mode
during each sleep period, missing pwstst =3D> you are in OFF state
always.) You could show the current state for emu powerdomain yes,
but not counters.

>I think=20
>also dpll1..5_pwrdm should be closed out here. I'm not sure=20
>why those are even modelled in a clocktree.

I tracked the powerdomain code a bit, and it seems dpll1...dpll5
are mapped to some real software accessible powerdomains. E.g. we
have dpll1 -> MPU_MOD. Now, a side effect of this is that when you
access such a powerdomain, you may alter the HW registers of another
powerdomain, which you probably did not want to do. Nasty part of this
is that some code does pwrdm_for_each() calls to modify status of
all powerdomains, like pm34xx.c. Question for Paul: Is the powerdomain
code safe against this kind of stuff?=20

>
>> +
>> +	if (pwrdm->state !=3D pwrdm_read_pwrst(pwrdm))
>> +		printk(KERN_ERR "pwrdm state mismatch(%s) %d !=3D %d\n",
>> +			pwrdm->name, pwrdm->state,=20
>pwrdm_read_pwrst(pwrdm));
>> +
>> +	seq_printf(s, "%s (%s)", pwrdm->name,
>> +			pwrdm_state_names[pwrdm->state]);
>> +	for (i =3D 0; i < 4; i++)
>> +		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
>> +			pwrdm->state_counter[i]);
>> +
>> +	seq_printf(s, "\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void=20
>> +*user) {
>> +	struct seq_file *s =3D (struct seq_file *)user;
>> +	int i;
>> +
>> +	if (strcmp(pwrdm->name, "emu_pwrdm") =3D=3D 0 ||
>> +		strcmp(pwrdm->name, "wkup_pwrdm") =3D=3D 0)
>> +		return 0;
>
>Same comment as above.
>
>> +
>> +	pwrdm_state_switch(pwrdm);
>> +
>> +	seq_printf(s, "%s (%s)", pwrdm->name,
>> +		pwrdm_state_names[pwrdm->state]);
>> +
>> +	for (i =3D 0; i < 4; i++)
>> +		seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
>> +			pwrdm->state_timer[i]);
>> +
>> +	seq_printf(s, "\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static void pm_dbg_show_counters(struct seq_file *s, void *unused) =
{
>> +	pwrdm_for_each(pwrdm_dbg_show_counter, s);
>> +	clkdm_for_each(clkdm_dbg_show_counter, s); }
>> +
>> +static void pm_dbg_show_timers(struct seq_file *s, void *unused) {
>> +	pwrdm_for_each(pwrdm_dbg_show_timer, s); }
>> +
>> +static int pm_dbg_open(struct inode *inode, struct file *file) {
>> +	switch ((int)inode->i_private) {
>> +	case DEBUG_FILE_COUNTERS:
>> +		return single_open(file, pm_dbg_show_counters,
>> +			&inode->i_private);
>> +	case DEBUG_FILE_TIMERS:
>> +	default:
>> +		return single_open(file, pm_dbg_show_timers,
>> +			&inode->i_private);
>> +	};
>> +}
>> +
>> +static const struct file_operations debug_fops =3D {
>> +	.open           =3D pm_dbg_open,
>> +	.read           =3D seq_read,
>> +	.llseek         =3D seq_lseek,
>> +	.release        =3D single_release,
>> +};
>> +
>> +static int __init pwrdms_setup(struct powerdomain *pwrdm, void=20
>> +*unused) {
>> +	int i;
>> +	s64 t;
>> +	struct timespec now;
>> +
>> +	getnstimeofday(&now);
>> +	t =3D timespec_to_ns(&now);
>> +
>> +	for (i =3D 0; i < 4; i++)
>> +		pwrdm->state_timer[i] =3D 0;
>> +
>> +	pwrdm->timer =3D t;
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init pm_dbg_init(void)
>> +{
>> +	struct dentry *d;
>> +
>> +	printk(KERN_INFO "pm_dbg_init()\n");
>> +
>> +	d =3D debugfs_create_dir("pm_debug", NULL);
>> +	if (IS_ERR(d))
>> +		return PTR_ERR(d);
>> +
>> +	(void) debugfs_create_file("count", S_IRUGO,
>> +		d, (void *)DEBUG_FILE_COUNTERS, &debug_fops);
>> +	(void) debugfs_create_file("time", S_IRUGO,
>> +		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
>> +
>> +	pwrdm_for_each(pwrdms_setup, NULL);
>> +
>> +	pm_dbg_init_done =3D 1;
>> +
>> +	return 0;
>> +}
>> +late_initcall(pm_dbg_init);
>> +
>> +#endif
>> +
>>  #endif
>> diff --git a/arch/arm/mach-omap2/pm.h=20
>b/arch/arm/mach-omap2/pm.h index=20
>> 68c9278..fb6693b 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -31,6 +31,7 @@ extern void serial_console_fclk_mask(u32 *f1, u32=20
>> *f2);  extern void pm_init_serial_console(void);  extern void=20
>> serial_console_sleep(int enable);  extern int omap2_pm_debug;
>> +extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)=
;
>>  #else
>>  #define omap2_read_32k_sync_counter()		0
>>  #define serial_console_sleep(enable)		do {} while (0);
>> @@ -38,5 +39,6 @@ extern int omap2_pm_debug;
>>  #define omap2_pm_dump(mode, resume, us)		do {} while (0);
>>  #define serial_console_fclk_mask(f1, f2)		do {} while (0);
>>  #define omap2_pm_debug				0
>> +#define pm_dbg_update_time(pwrdm, prev) do {} while (0);
>>  #endif /* CONFIG_PM_DEBUG */
>>  #endif
>> --
>> 1.5.6.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe=20
>linux-omap"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
>--
>Jouni H=F6gander
>
>--
>To unsubscribe from this list: send the line "unsubscribe=20
>linux-omap" in the body of a message to=20
>majordomo@vger.kernel.org More majordomo info at =20
>http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
