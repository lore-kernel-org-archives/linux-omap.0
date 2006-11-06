From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: Broken N770
Date: Mon, 06 Nov 2006 21:24:01 +0100
Message-ID: <85odrkiase.fsf@orfeo.duckcorp.org>
References: <20061105194915.12776.qmail@web37903.mail.mud.yahoo.com>
	<85d580lv53.fsf@orfeo.duckcorp.org> <454F7FDF.1080101@gmail.com>
	<85zmb4iceg.fsf@orfeo.duckcorp.org> <454F9892.2050202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <454F9892.2050202@gmail.com> (Dirk Behme's message of "Mon, 06
	Nov 2006 21:18:26 +0100")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme <dirk.behme@googlemail.com> writes:

> Arnaud Patard (Rtp) wrote:
>>>Thanks for the hint! With patch previously sent
>>>n770_defconfig should compile again.
>>
>> Sorry, that's wrong. I'm using an up2date git tree with origin
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git/
>> and I still need patches.
>>
>> For instance : - there are still some users of pt_regs (patch sent
>> some time ago)
>
> Yes, but these are only warnings and they are already fixed by patch
> sent.
>
> For drivers/usb/core/hub.c I had to use
>
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008254.html

If you look at the full thread, you'll see that I'm using the same patch :)

>
>> - drivers/cbus/tahvo-usb.c is still using usb_otg.h. Patch not sent but
>> trivial to write.
>
> Mmh. For drivers/cbus/tahvo-usb.c my patch contains
>
> --- linux-osk.orig/drivers/cbus/tahvo-usb.c
> +++ linux-osk/drivers/cbus/tahvo-usb.c
> @@ -36,7 +36,7 @@
>  #include <linux/usb_ch9.h>
>  #include <linux/usb_gadget.h>
>  #include <linux/usb.h>
> -#include <linux/usb_otg.h>
> +#include <linux/usb/otg.h>
>  #include <linux/i2c.h>
>  #include <linux/workqueue.h>
>  #include <linux/kobject.h>
>
> What's wrong with this? For me using recent git it compiles. I have no
> usb_otg.h.

No, that's fine. I was talking about that change. As it's not in the current
git tree, I wanted to say that you need such a patch :)

>
>>>Is there any way to test self compiled kernel on N770
>>>without breaking flashed SW/image? Anything like download to
>>>RAM, e.g. used by uboots TFTP download on OSK?
>>
>> yes, there is. That's what I'm using ^^
>>
>> ./flasher-2.0 -l -b -k <my_kernel>
>
> Thanks, will try it.
>
> Cheers
>
> Dirk

Regards,
Arnaud
