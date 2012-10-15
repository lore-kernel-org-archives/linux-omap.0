From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [balbi-usb:merge-result-for-greg 59/99] webcam.c:(.text+0x14afec):
 undefined reference to `config_ep_by_speed'
Date: Mon, 15 Oct 2012 09:49:20 +0200
Message-ID: <507BC000.10004@linutronix.de>
References: <20121012163902.GA19120@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121012163902.GA19120@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/12/2012 06:39 PM, Fengguang Wu wrote:
> Hi Sebastian,

Hi Fengguang,

> FYI, kernel build failed on
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git merge-result-for-greg
> head:   23953bde3e4d6aa8780dc054f6ad9882ac63f4f4
> commit: 721e2e91945bc2520d57d795dfe1b502ecec567c [59/99] usb: gadget: libcomposite: move composite.c into libcomposite
> config: i386-randconfig-b199 (attached as .config)
>
> All error/warnings:
>
> drivers/built-in.o: In function `uvc_function_set_alt':

Yes. I accidentally broke this and this still fails in 3.7-rc1. Greg
has a patch for this in his tree ("usb: gadget: Make webcam gadget
select USB_LIBCOMPOSITE") which fixes this.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
