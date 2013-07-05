From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 4/5] usb: musb: dsps: use proper child nodes
Date: Fri, 05 Jul 2013 17:15:07 +0200
Message-ID: <51D6E2FB.3040303@linutronix.de>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de> <1373031178-8871-5-git-send-email-bigeasy@linutronix.de> <CAFqH_529D9rEJJ2rk3jGm0aGt4ZXBpP=R3azAKUxyp9vA-Nf4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFqH_529D9rEJJ2rk3jGm0aGt4ZXBpP=R3azAKUxyp9vA-Nf4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/05/2013 05:08 PM, Enric Balletbo Serra wrote:
> Hi Sebastian,

Hi Enric,

> I'm trying to test these patches but I've problems, I've following error,
> 
> [   10.096492] musb-dsps 47400000.usb: failed to get memory for instance 0
> [   10.103481] musb-dsps 47400000.usb: failed to create child pdev
> 
> I'm missing something ?

This is printed if you don't have the memory for the child device. Did
you update your device tree?

> 
> Thanks in advance,
>      Enric

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
