From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] TSC2102 Touchscreen
Date: Thu, 19 Oct 2006 16:44:36 +0300
Message-ID: <20061019134434.GF9983@atomide.com>
References: <fb249edb0608180307t2fe9ea51wde113d1a8182b51f@mail.gmail.com>
	<20060818130937.72819.qmail@web37915.mail.mud.yahoo.com>
	<fb249edb0609131214m3ff6114dl3b3cc2edb78fdf3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0609131214m3ff6114dl3b3cc2edb78fdf3e@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060913 22:16]:
> On 18/08/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> >Few comments here too:
> >
> >+#include <linux/platform_device.h>
> >+#include <linux/kbd_kern.h>
> >
> >Why you need kbd_kern.h ?
> 
> It was my attempt to tell the kernel to not blank the console when I'm
> typing something using an on-screen keyboard in a tty, like when
> typing with a keyboard. I can see that it's not the right place for
> this code -- it should probably either be done in userspace, the gpm
> way, or be generic for all touchscreen devices like it is for
> keyboards.
> 
> Attached is a cleaner version of the patch.

Pushing today.

Tony
