From: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: musb: fix the possible panic while resuming
Date: Thu, 26 Feb 2009 14:54:23 +0900
Message-ID: <4d34a0a70902252154p56733ae8g7a989112503251b@mail.gmail.com>
References: <4d34a0a70902250353i3c6e072bnd41af327bc77601b@mail.gmail.com>
	 <20090226001358.GK4639@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090226001358.GK4639@gandalf>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 26, 2009 at 9:13 AM, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> wrot=
e:
> On Wed, Feb 25, 2009 at 08:53:00PM +0900, Kim Kyuwon wrote:
>> From: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> While waking up, musb can cause a kernel panic. This patch is fixing
>> it by enabling the clock in the resume_early method.
>>
>> Signed-off-by: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> =A0drivers/usb/musb/musb_core.c | =A0 21 +++++++--------------
>> =A01 files changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_co=
re.c
>> index 2cc34fa..ae76ad7 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -2141,16 +2141,13 @@ static int __devexit musb_remove(struct
>> platform_device *pdev)
>>
>> =A0#ifdef =A0 =A0 =A0 CONFIG_PM
>>
>> -static int musb_suspend(struct platform_device *pdev, pm_message_t =
message)
>> +static int musb_suspend_late(struct platform_device *pdev, pm_messa=
ge_t state)
>> =A0{
>> - =A0 =A0 unsigned long =A0 flags;
>> - =A0 =A0 struct musb =A0 =A0 *musb =3D dev_to_musb(&pdev->dev);
>> + =A0 =A0 struct musb *musb =3D dev_to_musb(&pdev->dev);
>
> this hunk is unecessary, please revert. I'll also take a closer look
> tomorrow, it's already really late and need some nap (as suggested by
> greg, hehe :-p)
>

OK, but before I resend the patch, I have something to check again.

Now I know that, in addition to HSUSB_MC_NINT disabled by the previous
patch [ARM: OMAP: Disable USB interrupt in the musb_resume()
function], USBTLL_SWAKEUP and USBHOST_SWAKEUP can be also wake-up
source events to PRMC module. Sorry I didn't know that time. The
remote wake uses these two SWAKEUP. David, is my previous patch is
still NAK?

> --
> balbi
>



--=20
Q1
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
