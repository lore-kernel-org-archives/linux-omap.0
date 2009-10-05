From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: introduce a new powerdomain walk helper
Date: Mon, 05 Oct 2009 14:18:09 +0300
Message-ID: <4AC9D5F1.8080400@gmail.com>
References: <1254380515-32175-1-git-send-email-dedekind1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64057 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378AbZJELTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 07:19:39 -0400
In-Reply-To: <1254380515-32175-1-git-send-email-dedekind1@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

On 10/01/2009 10:01 AM, Artem Bityutskiy wrote:
> From: Artem Bityutskiy<Artem.Bityutskiy@nokia.com>
>
> The 'pwrdm_for_each()' function walks powerdomains with a spinlock
> locked, so the the callbacks cannot do anything which may sleep.
> This patch introduces a 'pwrdm_for_each_nolock()' helper which does
> the same, but without the spinlock locked. This fixes the following
> lockdep warning:
>
> [    0.000000] WARNING: at kernel/lockdep.c:2460 lockdep_trace_alloc+=
0xac/0xec()
> [    0.000000] Modules linked in:
> (unwind_backtrace+0x0/0xdc) from [<c0045464>] (warn_slowpath_common+0=
x48/0x60)
> (warn_slowpath_common+0x48/0x60) from [<c0067dd4>] (lockdep_trace_all=
oc+0xac/0xec)
> (lockdep_trace_alloc+0xac/0xec) from [<c009da14>] (kmem_cache_alloc+0=
x1c/0xd0)
> (kmem_cache_alloc+0x1c/0xd0) from [<c00b21d8>] (d_alloc+0x1c/0x1a4)
> (d_alloc+0x1c/0x1a4) from [<c00a887c>] (__lookup_hash+0xd8/0x118)
> (__lookup_hash+0xd8/0x118) from [<c00a9f20>] (lookup_one_len+0x84/0x9=
4)
> (lookup_one_len+0x84/0x94) from [<c010d12c>] (debugfs_create_file+0x8=
c/0x20c)
> (debugfs_create_file+0x8c/0x20c) from [<c010d320>] (debugfs_create_di=
r+0x1c/0x20)
> (debugfs_create_dir+0x1c/0x20) from [<c000e8cc>] (pwrdms_setup+0x60/0=
x90)
> (pwrdms_setup+0x60/0x90) from [<c002e010>] (pwrdm_for_each+0x30/0x80)
> (pwrdm_for_each+0x30/0x80) from [<c000e79c>] (pm_dbg_init+0x7c/0x14c)
> (pm_dbg_init+0x7c/0x14c) from [<c00232b4>] (do_one_initcall+0x5c/0x1b=
8)
> (do_one_initcall+0x5c/0x1b8) from [<c00083f8>] (kernel_init+0x90/0x10=
c)
> (kernel_init+0x90/0x10c) from [<c00242c4>] (kernel_thread_exit+0x0/0x=
8)
>
> Signed-off-by: Artem Bityutskiy<Artem.Bityutskiy@nokia.com>

I guess this patch was actually for Tony, as this warning is seen on l-=
o.
Tony, any plans to pick this up?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
