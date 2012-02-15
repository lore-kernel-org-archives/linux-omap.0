From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Possible circular locking dependency (3.3-rc2)
Date: Wed, 15 Feb 2012 13:09:10 -0700
Message-ID: <20120215200910.GE25779@ponder.secretlab.ca>
References: <20120208124147.GF16334@legolas.emea.dhcp.ti.com>
 <CACVXFVMfmabcH57da-prx=J950KEoFtfb-zsuBWn7VY3NaMUUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACVXFVMfmabcH57da-prx=J950KEoFtfb-zsuBWn7VY3NaMUUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: balbi@ti.com, Linus Walleij <linus.walleij@stericsson.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

=46elipe, can you confirm whether or not Ming's patch below solves your
problem?

g.

On Mon, Feb 13, 2012 at 10:53:20PM +0800, Ming Lei wrote:
> Hi,
>=20
> On Wed, Feb 8, 2012 at 8:41 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi guys,
> >
> > I have just triggered the folllowing:
> >
> > [ =A0 84.860321] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [ =A0 84.860321] [ INFO: possible circular locking dependency detec=
ted ]
> > [ =A0 84.860321] 3.3.0-rc2-00026-ge4e8a39 #474 Not tainted
> > [ =A0 84.860321] --------------------------------------------------=
-----
> > [ =A0 84.860321] bash/949 is trying to acquire lock:
> > [ =A0 84.860321] =A0(sysfs_lock){+.+.+.}, at: [<c0275358>] gpio_val=
ue_store+0x24/0xcc
> > [ =A0 84.860321]
> > [ =A0 84.860321] but task is already holding lock:
> > [ =A0 84.860321] =A0(s_active#22){++++.+}, at: [<c016996c>] sysfs_w=
rite_file+0xdc/0x184
> > [ =A0 84.911468]
> > [ =A0 84.911468] which lock already depends on the new lock.
> > [ =A0 84.911468]
> > [ =A0 84.920043]
> > [ =A0 84.920043] the existing dependency chain (in reverse order) i=
s:
> > [ =A0 84.920043]
> > [ =A0 84.927886] -> #1 (s_active#22){++++.+}:
> > [ =A0 84.927886] =A0 =A0 =A0 =A0[<c008f640>] check_prevs_add+0xdc/0=
x150
> > [ =A0 84.927886] =A0 =A0 =A0 =A0[<c008fc18>] validate_chain.clone.2=
4+0x564/0x694
> > [ =A0 84.927886] =A0 =A0 =A0 =A0[<c0090cdc>] __lock_acquire+0x49c/0=
x980
> > [ =A0 84.951660] =A0 =A0 =A0 =A0[<c0091838>] lock_acquire+0x98/0x10=
0
> > [ =A0 84.951660] =A0 =A0 =A0 =A0[<c016a8e8>] sysfs_deactivate+0xb0/=
0x100
> > [ =A0 84.962982] =A0 =A0 =A0 =A0[<c016b1b4>] sysfs_addrm_finish+0x2=
c/0x6c
> > [ =A0 84.962982] =A0 =A0 =A0 =A0[<c016b8bc>] sysfs_remove_dir+0x84/=
0x98
> > [ =A0 84.962982] =A0 =A0 =A0 =A0[<c02590d8>] kobject_del+0x10/0x78
> > [ =A0 84.974670] =A0 =A0 =A0 =A0[<c02c29e8>] device_del+0x140/0x170
> > [ =A0 84.974670] =A0 =A0 =A0 =A0[<c02c2a24>] device_unregister+0xc/=
0x18
> > [ =A0 84.985382] =A0 =A0 =A0 =A0[<c0276894>] gpio_unexport+0xbc/0xd=
c
> > [ =A0 84.985382] =A0 =A0 =A0 =A0[<c02768c8>] gpio_free+0x14/0xfc
> > [ =A0 85.001708] =A0 =A0 =A0 =A0[<c0276a28>] unexport_store+0x78/0x=
8c
> > [ =A0 85.001708] =A0 =A0 =A0 =A0[<c02c5af8>] class_attr_store+0x18/=
0x24
> > [ =A0 85.007293] =A0 =A0 =A0 =A0[<c0169990>] sysfs_write_file+0x100=
/0x184
> > [ =A0 85.018981] =A0 =A0 =A0 =A0[<c0109d48>] vfs_write+0xb4/0x148
> > [ =A0 85.018981] =A0 =A0 =A0 =A0[<c0109fd0>] sys_write+0x40/0x70
> > [ =A0 85.018981] =A0 =A0 =A0 =A0[<c0013cc0>] ret_fast_syscall+0x0/0=
x3c
> > [ =A0 85.035003]
> > [ =A0 85.035003] -> #0 (sysfs_lock){+.+.+.}:
> > [ =A0 85.035003] =A0 =A0 =A0 =A0[<c008f54c>] check_prev_add+0x680/0=
x698
> > [ =A0 85.035003] =A0 =A0 =A0 =A0[<c008f640>] check_prevs_add+0xdc/0=
x150
> > [ =A0 85.052093] =A0 =A0 =A0 =A0[<c008fc18>] validate_chain.clone.2=
4+0x564/0x694
> > [ =A0 85.052093] =A0 =A0 =A0 =A0[<c0090cdc>] __lock_acquire+0x49c/0=
x980
> > [ =A0 85.052093] =A0 =A0 =A0 =A0[<c0091838>] lock_acquire+0x98/0x10=
0
> > [ =A0 85.069885] =A0 =A0 =A0 =A0[<c047e280>] mutex_lock_nested+0x3c=
/0x2f4
> > [ =A0 85.069885] =A0 =A0 =A0 =A0[<c0275358>] gpio_value_store+0x24/=
0xcc
> > [ =A0 85.069885] =A0 =A0 =A0 =A0[<c02c18dc>] dev_attr_store+0x18/0x=
24
> > [ =A0 85.087158] =A0 =A0 =A0 =A0[<c0169990>] sysfs_write_file+0x100=
/0x184
> > [ =A0 85.087158] =A0 =A0 =A0 =A0[<c0109d48>] vfs_write+0xb4/0x148
> > [ =A0 85.098297] =A0 =A0 =A0 =A0[<c0109fd0>] sys_write+0x40/0x70
> > [ =A0 85.098297] =A0 =A0 =A0 =A0[<c0013cc0>] ret_fast_syscall+0x0/0=
x3c
> > [ =A0 85.109069]
> > [ =A0 85.109069] other info that might help us debug this:
> > [ =A0 85.109069]
> > [ =A0 85.117462] =A0Possible unsafe locking scenario:
> > [ =A0 85.117462]
> > [ =A0 85.117462] =A0 =A0 =A0 =A0CPU0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0CPU1
> > [ =A0 85.128417] =A0 =A0 =A0 =A0---- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0----
> > [ =A0 85.128417] =A0 lock(s_active#22);
> > [ =A0 85.128417] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0lock(sysfs_lock);
> > [ =A0 85.128417] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0lock(s_active#22);
> > [ =A0 85.142486] =A0 lock(sysfs_lock);
> > [ =A0 85.151794]
> > [ =A0 85.151794] =A0*** DEADLOCK ***
> > [ =A0 85.151794]
> > [ =A0 85.151794] 2 locks held by bash/949:
> > [ =A0 85.158020] =A0#0: =A0(&buffer->mutex){+.+.+.}, at: [<c01698b8=
>] sysfs_write_file+0x28/0x184
> > [ =A0 85.170349] =A0#1: =A0(s_active#22){++++.+}, at: [<c016996c>] =
sysfs_write_file+0xdc/0x184
> > [ =A0 85.170349]
> > [ =A0 85.178588] stack backtrace:
> > [ =A0 85.178588] [<c001b824>] (unwind_backtrace+0x0/0xf0) from [<c0=
08de64>] (print_circular_bug+0x100/0x114)
> > [ =A0 85.193023] [<c008de64>] (print_circular_bug+0x100/0x114) from=
 [<c008f54c>] (check_prev_add+0x680/0x698)
> > [ =A0 85.193023] [<c008f54c>] (check_prev_add+0x680/0x698) from [<c=
008f640>] (check_prevs_add+0xdc/0x150)
> > [ =A0 85.212524] [<c008f640>] (check_prevs_add+0xdc/0x150) from [<c=
008fc18>] (validate_chain.clone.24+0x564/0x694)
> > [ =A0 85.212524] [<c008fc18>] (validate_chain.clone.24+0x564/0x694)=
 from [<c0090cdc>] (__lock_acquire+0x49c/0x980)
> > [ =A0 85.233306] [<c0090cdc>] (__lock_acquire+0x49c/0x980) from [<c=
0091838>] (lock_acquire+0x98/0x100)
> > [ =A0 85.233306] [<c0091838>] (lock_acquire+0x98/0x100) from [<c047=
e280>] (mutex_lock_nested+0x3c/0x2f4)
> > [ =A0 85.242614] [<c047e280>] (mutex_lock_nested+0x3c/0x2f4) from [=
<c0275358>] (gpio_value_store+0x24/0xcc)
> > [ =A0 85.261840] [<c0275358>] (gpio_value_store+0x24/0xcc) from [<c=
02c18dc>] (dev_attr_store+0x18/0x24)
> > [ =A0 85.261840] [<c02c18dc>] (dev_attr_store+0x18/0x24) from [<c01=
69990>] (sysfs_write_file+0x100/0x184)
> > [ =A0 85.271240] [<c0169990>] (sysfs_write_file+0x100/0x184) from [=
<c0109d48>] (vfs_write+0xb4/0x148)
> > [ =A0 85.290008] [<c0109d48>] (vfs_write+0xb4/0x148) from [<c0109fd=
0>] (sys_write+0x40/0x70)
> > [ =A0 85.298400] [<c0109fd0>] (sys_write+0x40/0x70) from [<c0013cc0=
>] (ret_fast_syscall+0x0/0x3c)
> > -bash: echo: write error: Operation not permitted
> >
> > the way to trigger is:
> >
> >
> > root@legolas:~# cd /sys/class/gpio/
> > root@legolas:/sys/class/gpio# echo 2 > export
> > root@legolas:/sys/class/gpio# echo 2 > unexport
> > root@legolas:/sys/class/gpio# echo 2 > export
> > root@legolas:/sys/class/gpio# cd gpio2/
> > root@legolas:/sys/class/gpio/gpio2# echo 1 > value
>=20
> Looks 'sysfs_lock' needn't to be held for unregister, so the patch be=
low may
> fix the problem.
>=20
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 17fdf4b..d773540 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -873,6 +873,7 @@ void gpio_unexport(unsigned gpio)
>  {
>  	struct gpio_desc	*desc;
>  	int			status =3D 0;
> +	struct device		*dev =3D NULL;
>=20
>  	if (!gpio_is_valid(gpio)) {
>  		status =3D -EINVAL;
> @@ -884,19 +885,20 @@ void gpio_unexport(unsigned gpio)
>  	desc =3D &gpio_desc[gpio];
>=20
>  	if (test_bit(FLAG_EXPORT, &desc->flags)) {
> -		struct device	*dev =3D NULL;
>=20
>  		dev =3D class_find_device(&gpio_class, NULL, desc, match_export);
>  		if (dev) {
>  			gpio_setup_irq(desc, dev, 0);
>  			clear_bit(FLAG_EXPORT, &desc->flags);
> -			put_device(dev);
> -			device_unregister(dev);
>  		} else
>  			status =3D -ENODEV;
>  	}
>=20
>  	mutex_unlock(&sysfs_lock);
> +	if (dev) {
> +		device_unregister(dev);
> +		put_device(dev);
> +	}
>  done:
>  	if (status)
>  		pr_debug("%s: gpio%d status %d\n", __func__, gpio, status);
>=20
>=20
> thanks,
> --=20
> Ming Lei
