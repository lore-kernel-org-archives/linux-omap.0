From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/1] usb: musb: call pm_runtime_{get,put}_sync before
 reading vbus registers
Date: Wed, 28 Feb 2018 13:59:43 -0800
Message-ID: <20180228215943.GI5448@atomide.com>
References: <20180227222740.2150-1-merlijn@wizzup.org>
 <20180227222740.2150-2-merlijn@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180227222740.2150-2-merlijn@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: linux-omap@vger.kernel.org, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Merlijn Wajer <merlijn@wizzup.org> [180227 22:29]:
> Without pm_runtime_{get,put}_sync calls in place, reading
> vbus status via /sys causes the following error:
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
> pgd = b333e822
> [fa0ab060] *pgd=48011452(bad)
> 
> [<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
> [<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
> [<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
> [<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
> [<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
> [<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
> [<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
> [<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)
> 
> Solution was suggested by Tony Lindgren <tony@atomide.com>.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>

Thanks for fixing this. Assuming it passes Bin's tests:

Acked-by: Tony Lindgren <tony@atomide.com>
