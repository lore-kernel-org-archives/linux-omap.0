From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] video: fbdev: Convert timers to use timer_setup()
Date: Thu, 9 Nov 2017 10:40:13 -0800
Message-ID: <CAGXu5jJHWHunEVKi-YUybMH+CnfOsaCgYoyO3zODG+GCKwB02A@mail.gmail.com>
References: <CGME20171024152032epcas3p4976e268e33d58750b7c09380e857bba0@epcas3p4.samsung.com>
 <20171024152026.GA104655@beast> <15752127.NCT7iFVURk@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15752127.NCT7iFVURk@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Lechner <david@lechnology.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sean Paul <seanpaul@chromium.org>, Jean Delvare <jdelvare@suse.de>, Hans de Goede <hdegoede@redhat.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-fbdev@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 9, 2017 at 9:08 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Tuesday, October 24, 2017 08:20:26 AM Kees Cook wrote:
>
>> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
>> index 933619da1a94..e88447eac32c 100644
>> --- a/drivers/video/fbdev/pxa3xx-gcu.c
>> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
>> @@ -513,16 +513,10 @@ pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
>>  #ifdef PXA3XX_GCU_DEBUG_TIMER
>>  static struct timer_list pxa3xx_gcu_debug_timer;
>>
>> -static void pxa3xx_gcu_debug_timedout(unsigned long ptr)
>> +static void pxa3xx_gcu_debug_timedout(struct timer_list *unused)
>>  {
>> -     struct pxa3xx_gcu_priv *priv = (struct pxa3xx_gcu_priv *) ptr;
>> -
>>       QERROR("Timer DUMP");
>
> QERROR() macro is using priv so this code now fails to build.

Ah, yes, I see. However, in looking at this, I don't think it ever
worked. The existing code does:

static void pxa3xx_gcu_init_debug_timer(void)
{
        pxa3xx_gcu_debug_timedout((unsigned long) &pxa3xx_gcu_debug_timer);
}
...
static void pxa3xx_gcu_debug_timedout(unsigned long ptr)
{
        struct pxa3xx_gcu_priv *priv = (struct pxa3xx_gcu_priv *) ptr;

        QERROR("Timer DUMP");
...

But pxa3xx_gcu_debug_timer is not a struct pxa3xx_gcu_priv, so
QERROR() will be reporting garbage.

I will send a patch that fixes this and switches to timer_setup(),
though it might make more sense to just remove the debug timer
entirely.

> [ Please compile these timer changes with PXA3XX_GCU_DEBUG and
>   PXA3XX_GCU_DEBUG_TIMER defined. ]

Hm, these appear to be manual knobs? What do you think about wiring
these up to a Kconfig so build tests for things like "make
allmodconfig" would enable it? This would allow for much greater build
coverage.

> Also please port your changes over fbdvev-for-next tree as
> currently this patch doesn't apply (fbdev tree contains
> "video: fbdev: pxa3xx_gcu: Use setup_timer and mod_timer"
> cleanup).

Sure thing, thanks!

-Kees

-- 
Kees Cook
Pixel Security
