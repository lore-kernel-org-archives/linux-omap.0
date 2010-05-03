From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 3 May 2010 12:41:35 +0300
Message-ID: <p2sda15981b1005030241va21fd23fx9fcc84c4502a1919@mail.gmail.com>
References: <1272815071-2827-1-git-send-email-ohad@wizery.com>
	<1272815071-2827-5-git-send-email-ohad@wizery.com> <20100503.083036.59656495.Hiroshi.DOYU@nokia.com>
	<20100503.090723.48519047.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60629 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0ECJl4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 05:41:56 -0400
Received: by gyg13 with SMTP id 13so1021395gyg.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 02:41:55 -0700 (PDT)
In-Reply-To: <20100503.090723.48519047.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

On Mon, May 3, 2010 at 9:07 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> w=
rote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Subject: Re: [PATCH v2 4/4] omap: mailbox: convert block api to kfifo
> Date: Mon, 03 May 2010 08:30:36 +0300 (EEST)
>
>> Hi Ohad,
>>
>> From: ext Ohad Ben-Cohen <ohad@wizery.com>
>> Subject: [PATCH v2 4/4] omap: mailbox: convert block api to kfifo
>> Date: Sun, 2 May 2010 17:44:31 +0200
>>
>>> The underlying buffering implementation of mailbox
>>> is converted from block API to kfifo due to the simplicity
>>> and speed of kfifo.
>>>
>>> The default size of the kfifo buffer is set to 256 bytes.
>>> This value is configurable at compile time (via
>>> CONFIG_OMAP_MBOX_KFIFO_SIZE), and can be changed at
>>> runtime (via the omap_kfifo_size module parameter).
>>
>> mbox_kfifo_size?
>
> It may be also nice if there's some checking of 'mbox_kfifo_size % 4 =
=3D=3D 0' along with 'CONFIG_OMAP_MBOX_KFIFO_SIZE % 4 =3D=3D 0'?

Good point. I'll send a new patch together with this:

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.=
c
index a500ac4..fb3d452 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -21,6 +21,7 @@
  *
  */

+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
@@ -394,6 +395,10 @@ static int __init omap_mbox_init(void)
        if (!mboxd)
                return -ENOMEM;

+       /* kfifo size sanity check: alignment and minimal size */
+       mbox_kfifo_size =3D ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
+       mbox_kfifo_size =3D max_t(unsigned int, mbox_kfifo_size,
sizeof(mbox_msg_t));
+
        return 0;
 }
 module_init(omap_mbox_init);


>
>>
>>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>>> ---
>>> If you want, you can also reach me at < ohadb at ti dot com >.
>>>
>>> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A09 +++
>>> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A04 +-
>>> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0107=
 +++++++++++++----------------
>>> =A03 files changed, 58 insertions(+), 62 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
