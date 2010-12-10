From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/9 v3] usb: musb: Remove board_data parameter from musb_platform_init()
Date: Sat, 11 Dec 2010 00:07:19 +0300
Message-ID: <4D029687.7010008@ru.mvista.com>
References: <1285201660-26309-1-git-send-email-hemahk@ti.com> <871v8c629u.fsf@deeprootsystems.com> <4D027FEA.9050206@ru.mvista.com> <20101210202906.GB23759@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101210202906.GB23759-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

Greg KH wrote:

>>>> Removed the board_data parameter being passed to musb_platform_init function
>>>> as board data can be extracted from device structure which is already member of
>>>> musb structure.

>>>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>>> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>>>> Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
>>>> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

>>> For the davinci changes:

>>> Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>

>>> Kevin
>>>> ---
>>>> drivers/usb/musb/blackfin.c  |    2 +-
>>>> drivers/usb/musb/davinci.c   |    2 +-
>>>> drivers/usb/musb/musb_core.c |    2 +-
>>>> drivers/usb/musb/musb_core.h |    2 +-
>>>> drivers/usb/musb/omap2430.c  |    6 ++++--
>>>> drivers/usb/musb/tusb6010.c  |    2 +-
>>>> 6 files changed, 9 insertions(+), 7 deletions(-)

>>    Grr. This misses changes to da8xx.c and am35x.c -- which breaks
>> the compilation for them!
>>    Greg, could you drop it from your usb-next branch? Or should we
>> send a patch adding these glue layers?

> I can't drop patches from a git branch, sorry, it doesn't work that way
> anymore.

    That's why I really prefer quilt to git. :-)

> greg k-h

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
