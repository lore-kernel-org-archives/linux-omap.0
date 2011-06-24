From: Jaswinder Singh <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mfd: omap: Restore TLL initialization
Date: Fri, 24 Jun 2011 12:33:09 +0530
Message-ID: <BANLkTikODvHRWa6HHaWZr2Gy0SjBbn2J-w@mail.gmail.com>
References: <1308862894-13802-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTikFFUREhKyPaZrhHZje0KeaA3ef8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTikFFUREhKyPaZrhHZje0KeaA3ef8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ti-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 24 June 2011 11:52, Munegowda, Keshava <keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote=
:
> On Fri, Jun 24, 2011 at 2:31 AM, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
>> The commit
>> =A07e6502d577106fb5b202bbaac64c5f1b065 'mfd: Add omap-usbhs runtime =
PM support'
>> besides moving to RPM, removes necessary TLL initialization as well.
>>
>> Restore the TLL initialization, without which device detection fails=
=2E
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> if you move to RPM, you should'tn access these configuration/reset
> registers in your driver.
Sorry I don't get it.  Obviously the RPM backend here doesn't initializ=
e
the TLL and if it only manages the clocks, can't we safely assume that
the pm_runtime_get_sync will get clocks to speed and the driver does
the TLL init ?

> moreover, the patch 'mfd: Add omap-usbhs runtime PM support' is
> already reverted.
Ok, though if the ultimate goal is to move on to RPM, this would be a
step back.
Btw, which tree could I find the revert in ?

Thanks,
Jassi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
