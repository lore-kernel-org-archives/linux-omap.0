From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: Queueing b0a688ddcc50 "usb: musb: cppi41: allow it to work again"
 for -stable
Date: Fri, 2 Oct 2015 14:16:50 -0300
Message-ID: <CAAEAJfALjV2BCJwzd20TQA3CWa1VZRM5vPv6CydrBuMJc=vVAw@mail.gmail.com>
References: <CAAEAJfC7z=dvw_5vgXDBWVQdKA5jDpfECYv4Jy67YaT7219uJA@mail.gmail.com>
	<20151002160902.GF5552@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151002160902.GF5552-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 2 October 2015 at 13:09, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Fri, Oct 02, 2015 at 02:23:45AM -0300, Ezequiel Garcia wrote:
>> Hello,
>>
>> Commit b0a688ddcc50 "usb: musb: cppi41: allow it to work again" seem=
s
>> to fix a regression. It applies cleanly on v4.1 and removes the
>> "musb-hdrc musb-hdrc.1.auto: Need DT for the DMA engine." error.
>>
>> Any chance you can queue it for -stable?
>
> Have a look at Documentation/stable_kernel_rules.txt, you can do a pr=
oper
> request for Greg and he will make sure it gets there.
>

Sure, I will.

Maybe next time you could add a Cc: stable to these kinds of fixes, alo=
ng with
a proper Fixes tag, so the -stable folks can pick them automatically.

Thanks!
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
