From: Kees Cook <keescook@chromium.org>
Subject: Re: video: fbdev: Convert timers to use timer_setup()
Date: Mon, 13 Nov 2017 19:18:02 -0800
Message-ID: <CAGXu5jJe6fGcB2yeki1+Z=2vxHZUzVem2D2TtgwYrEgfpvvL2w@mail.gmail.com>
References: <20171024152026.GA104655@beast> <20171114014555.GA32249@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171114014555.GA32249@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Lechner <david@lechnology.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sean Paul <seanpaul@chromium.org>, Jean Delvare <jdelvare@suse.de>, Hans de Goede <hdegoede@redhat.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-fbdev@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 13, 2017 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Oct 24, 2017 at 08:20:26AM -0700, Kees Cook wrote:
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly. One tracking pointer was added, and
>> one initialization was cleaned up.
>>
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: David Lechner <david@lechnology.com>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: Jean Delvare <jdelvare@suse.de>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-omap@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Hi Kees,
>
> this patch causes a large number of qemu crashes.
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000194
> pgd = c0004000
> [00000194] *pgd=00000000
> Internal error: Oops: 5 [#1] ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.0-next-20171113 #1
> Hardware name: ARM-Versatile (Device Tree Support)
> task: c04df238 task.stack: c04da000
> PC is at queue_work_on+0x1c/0x48
> ...
> [<c00371b0>] (queue_work_on) from [<c01f5504>] (cursor_timer_handler+0x20/0x44)
> [<c01f5504>] (cursor_timer_handler) from [<c005bedc>] (call_timer_fn+0x24/0xa0)
> [<c005bedc>] (call_timer_fn) from [<c005bfd4>] (expire_timers+0x7c/0x8c)
> [<c005bfd4>] (expire_timers) from [<c005c1ac>] (run_timer_softirq+0x88/0x184)
> [<c005c1ac>] (run_timer_softirq) from [<c00095f0>] (__do_softirq+0xe0/0x238)
> [<c00095f0>] (__do_softirq) from [<c0027634>] (irq_exit+0xb4/0xd0)
> [<c0027634>] (irq_exit) from [<c0053b0c>] (__handle_domain_irq+0x50/0xa8)
> [<c0053b0c>] (__handle_domain_irq) from [<c0009438>] (vic_handle_irq+0x54/0x94)
> [<c0009438>] (vic_handle_irq) from [<c00197a8>] (__irq_svc+0x68/0x84)
>
> See
> http://kerneltests.org/builders/qemu-arm-next/builds/806/steps/qemubuildcommand/logs/stdio
> for complete crash logs.
>
> Reverting the patch fixes the problem.
>
> Images for various other architectures crash as well in next-20171113,
> but I didn't bisect those. It looks like there are additional (possibly irq
> related) problems in the latest -next kernel; I don't know if those are
> also related to timer changes.

I think this is already fixed here:
https://marc.info/?l=linux-fbdev&m=151056635200583&w=2

If not, please let me know! :)

-Kees

-- 
Kees Cook
Pixel Security
