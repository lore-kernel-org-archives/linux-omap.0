From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Tue, 07 Dec 2010 16:20:21 +0300
Message-ID: <4CFE3495.5090204@ru.mvista.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com> <4CFCBCF1.9010902@ru.mvista.com> <19F8576C6E063C45BE387C64729E739404BCE3A1EC@dbde02.ent.ti.com> <4CFD19A7.5020902@ru.mvista.com> <20101206175445.GF8345@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101206175445.GF8345-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 06-12-2010 20:54, Tony Lindgren wrote:

>>>>> As the control.h have been moved to new location and it's
>>>>> uses are not allowed to drivers directly so moving the phy
>>>>> control, interrupt clear and reset functionality to board
>>>>> files.

>>>>     I'm not fond of the whole approach. I'm not sure why accesses to the
>>>> control registers are such a no-no, taking into account that one needs to
>>>> access such regisyter to clear the interrupt...

> Because drivers should arch independent and any tinkering of the
> platform level registers will lead into pains later on that
> I end up having to deal with.

> To me it seem you just init to separate out the transceiver,
> right?

    We also have to install a hook to clear the MUSB level interrupt via the 
control register -- that's a thing that makes me dubious about not allowing 
drivers to access the control registers.

> Tony

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
