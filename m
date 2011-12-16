From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] usb: musb: fix pm_runtime mismatches
Date: Fri, 16 Dec 2011 02:59:57 +0200
Message-ID: <CAMP44s3eeTOBRiFwEL3FypDY_+-MReqYJJVO1URNrnFVFXzvDg@mail.gmail.com>
References: <1323990310-11905-2-git-send-email-felipe.contreras@gmail.com>
	<Pine.LNX.4.44L0.1112151821360.1644-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1112151821360.1644-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 16, 2011 at 1:22 AM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
> On Fri, 16 Dec 2011, Felipe Contreras wrote:
>
>> Properly call pm_runtime_put() afer pm_runttime_get() on errors.
>>
>> Untested.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0drivers/usb/musb/musb_gadget.c | =C2=A0 =C2=A01 +
>> =C2=A0drivers/usb/musb/omap2430.c =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A02 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_=
gadget.c
>> index 922148f..95bfd2d 100644
>> --- a/drivers/usb/musb/musb_gadget.c
>> +++ b/drivers/usb/musb/musb_gadget.c
>> @@ -1960,6 +1960,7 @@ static int musb_gadget_start(struct usb_gadget=
 *g,
>> =C2=A0err2:
>> =C2=A0 =C2=A0 =C2=A0 if (!is_otg_enabled(musb))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 musb_stop(musb);
>> + =C2=A0 =C2=A0 pm_runtime_put(musb->controller);
>> =C2=A0err0:
>> =C2=A0 =C2=A0 =C2=A0 return retval;
>> =C2=A0}
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430=
=2Ec
>> index ba85f27..4edfb91 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -385,6 +385,7 @@ static void omap2430_musb_disable(struct musb *m=
usb)
>>
>> =C2=A0static int omap2430_musb_exit(struct musb *musb)
>> =C2=A0{
>> + =C2=A0 =C2=A0 pm_runtime_put(musb->controller);
>> =C2=A0 =C2=A0 =C2=A0 del_timer_sync(&musb_idle_timer);
>>
>> =C2=A0 =C2=A0 =C2=A0 omap2430_low_level_exit(musb);
>
> Should these calls be pm_runtime_put_sync() instead of
> pm_runtime_put()?

I don't see why... The thing failed, it's not going to be used any
more so better let PM deactivate the device. But now that you point
this out, pm_runtime_put() on omap2430_musb_exit() should probably go
at the end of the function, after all the actions have been done.

I'll send an updated patch tomorrow, if there are no further comments.

Cheers.

--=20
=46elipe Contreras
