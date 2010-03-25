From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch-2.6.35 09/11] usb: musb: Makefile: remove unexistent
 config option
Date: Thu, 25 Mar 2010 08:38:12 +0200
Message-ID: <20100325063812.GN29419@nokia.com>
References: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
 <1269435318-29153-10-git-send-email-felipe.balbi@nokia.com>
 <4BAA28D8.70705@ru.mvista.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BAA28D8.70705-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 24, 2010 at 03:59:36PM +0100, ext Sergei Shtylyov wrote:
>Felipe Balbi wrote:
>
>> Remove the unexistent CONFIG_USB_INVENTRA_MUSB_HAS_AHB_ID
>> option from our Makefile.
>>
>> Problem reported by Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/usb/musb/Makefile |    4 ----
>>  1 files changed, 0 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
>> index a1677f9..4266d79 100644
>> --- a/drivers/usb/musb/Makefile
>> +++ b/drivers/usb/musb/Makefile
>> @@ -74,10 +74,6 @@ endif
>>
>>  # FIXME remove all these extra "-DMUSB_* things, stick to CONFIG_*
>>
>> -ifeq ($(CONFIG_USB_INVENTRA_MUSB_HAS_AHB_ID),y)
>> -	EXTRA_CFLAGS += -DMUSB_AHB_ID
>> -endif
>> -
>>
>
>   You forgot to remove FIXME.

there's still -DDEBUG there. Maybe it doesn't really matter.

>
>WBR, Sergei

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
