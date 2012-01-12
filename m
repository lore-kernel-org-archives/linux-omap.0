From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usb: musb: drop superfluous pm_runtime calls around musb_shutdown
Date: Thu, 12 Jan 2012 17:55:57 +0200
Message-ID: <CANOLnOMj-Z7T8tcgjr-r1RrGFPpohbtvOg=FG6fVJR3ua17bxg@mail.gmail.com>
References: <1326374498-22968-1-git-send-email-notasas@gmail.com>
	<CAMP44s3PnWCmCD1ip1EP9wMBDeOZ0EacpFTOTvASxYcFJh+W6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMP44s3PnWCmCD1ip1EP9wMBDeOZ0EacpFTOTvASxYcFJh+W6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 12, 2012 at 5:45 PM, Felipe Contreras
<felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jan 12, 2012 at 3:21 PM, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
>> Since commit 4f9edd2d7e8d "usb: musb: Fix the crash issue during reb=
oot"
>> musb_shutdown() does pm_runtime_get_sync/pm_runtime_put by itself, s=
o
>> this no longer needs to be done by the caller. Also, musb_exit_debug=
fs()
>> doesn't access the device, so just drop those runtime_pm calls.
>
> I don't understand what is the relationship with 4f9edd2d7e8d and
> musb_shutdown(), it seems this patch is basically reverting
> 4f9edd2d7e8d.

No it's not, read my patch and it's description again. 4f9edd2d7e8d is
patching musb_shutdown(), mine musb_remove().

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
