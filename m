From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: video: fbdev: Convert timers to use timer_setup()
Date: Mon, 13 Nov 2017 17:45:55 -0800
Message-ID: <20171114014555.GA32249@roeck-us.net>
References: <20171024152026.GA104655@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171024152026.GA104655@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Lechner <david@lechnology.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sean Paul <seanpaul@chromium.org>, Jean Delvare <jdelvare@suse.de>, Hans de Goede <hdegoede@redhat.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 24, 2017 at 08:20:26AM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly. One tracking pointer was added, and
> one initialization was cleaned up.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Lechner <david@lechnology.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi Kees,

this patch causes a large number of qemu crashes.

Unable to handle kernel NULL pointer dereference at virtual address 00000194
pgd = c0004000
[00000194] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.0-next-20171113 #1
Hardware name: ARM-Versatile (Device Tree Support)
task: c04df238 task.stack: c04da000
PC is at queue_work_on+0x1c/0x48
...
[<c00371b0>] (queue_work_on) from [<c01f5504>] (cursor_timer_handler+0x20/0x44)
[<c01f5504>] (cursor_timer_handler) from [<c005bedc>] (call_timer_fn+0x24/0xa0)
[<c005bedc>] (call_timer_fn) from [<c005bfd4>] (expire_timers+0x7c/0x8c)
[<c005bfd4>] (expire_timers) from [<c005c1ac>] (run_timer_softirq+0x88/0x184)
[<c005c1ac>] (run_timer_softirq) from [<c00095f0>] (__do_softirq+0xe0/0x238)
[<c00095f0>] (__do_softirq) from [<c0027634>] (irq_exit+0xb4/0xd0)
[<c0027634>] (irq_exit) from [<c0053b0c>] (__handle_domain_irq+0x50/0xa8)
[<c0053b0c>] (__handle_domain_irq) from [<c0009438>] (vic_handle_irq+0x54/0x94)
[<c0009438>] (vic_handle_irq) from [<c00197a8>] (__irq_svc+0x68/0x84)

See
http://kerneltests.org/builders/qemu-arm-next/builds/806/steps/qemubuildcommand/logs/stdio
for complete crash logs.

Reverting the patch fixes the problem.

Images for various other architectures crash as well in next-20171113,
but I didn't bisect those. It looks like there are additional (possibly irq
related) problems in the latest -next kernel; I don't know if those are
also related to timer changes.

Guenter

---
git bisect log:

# bad: [c348a99ee55feac43b5b62a5957c6d8e2b6c3abe] Add linux-next specific files for 20171113
# good: [bebc6082da0a9f5d47a1ea2edc099bf671058bd4] Linux 4.14
git bisect start 'HEAD' 'v4.14'
# bad: [ef01732397847b006e3a9147829739c490b8272c] Merge remote-tracking branch 'crypto/master'
git bisect bad ef01732397847b006e3a9147829739c490b8272c
# good: [16337aaf7b06176148e7007dc20e34cd1e634a0f] Merge remote-tracking branch 'v4l-dvb/master'
git bisect good 16337aaf7b06176148e7007dc20e34cd1e634a0f
# good: [2ae21cf527da0e5cf9d7ee14bd5b0909bb9d1a75] tcp: Namespace-ify sysctl_tcp_early_retrans
git bisect good 2ae21cf527da0e5cf9d7ee14bd5b0909bb9d1a75
# good: [fdae5f37a88caed9d2105f5a1ff609322f9e5416] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect good fdae5f37a88caed9d2105f5a1ff609322f9e5416
# bad: [01ff3f27ce88684a034bfad8fe5f5f99db04030e] Merge remote-tracking branch 'mac80211-next/master'
git bisect bad 01ff3f27ce88684a034bfad8fe5f5f99db04030e
# good: [e5b9855372a0f3d53d8e84b51d781a736e5b7e99] Merge branch 'device-properties' into linux-next
git bisect good e5b9855372a0f3d53d8e84b51d781a736e5b7e99
# bad: [1417face305e9e10f8e65216e9bcb7a74c4e42ff] Merge remote-tracking branch 'thermal/next'
git bisect bad 1417face305e9e10f8e65216e9bcb7a74c4e42ff
# bad: [e7528eca7b6e5b7d7d5b9dbcf39b31a535bfb32f] Merge remote-tracking branch 'pm/linux-next'
git bisect bad e7528eca7b6e5b7d7d5b9dbcf39b31a535bfb32f
# good: [ab798b908737e999e5d9bcebe972e9d5002583cc] video: fbdev: au1200fb: Style clean up
git bisect good ab798b908737e999e5d9bcebe972e9d5002583cc
# good: [0101f48ae50d700becafbbba2c57005174c54658] video: fbdev: aty: radeon_pm: mark expected switch fall-throughs
git bisect good 0101f48ae50d700becafbbba2c57005174c54658
# bad: [1fc1d27c1ab07a8830a0139f45508a49c6d71729] Merge remote-tracking branch 'fbdev/fbdev-for-next'
git bisect bad 1fc1d27c1ab07a8830a0139f45508a49c6d71729
# good: [ac831a379d34109451b3c41a44a20ee10ecb615f] fbdev: controlfb: Add missing modes to fix out of bounds access
git bisect good ac831a379d34109451b3c41a44a20ee10ecb615f
# bad: [6c78935777d12ead2d32adf3eb525a24faf02d04] video: fbdev: Convert timers to use timer_setup()
git bisect bad 6c78935777d12ead2d32adf3eb525a24faf02d04
# good: [e4a67df75a7b93b1bcddf576fa9122da2305dc8b] video: fbdev: pxa3xx_gcu: Convert timers to use timer_setup()
git bisect good e4a67df75a7b93b1bcddf576fa9122da2305dc8b
# first bad commit: [6c78935777d12ead2d32adf3eb525a24faf02d04] video: fbdev: Convert timers to use timer_setup()
