From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sun, 28 Aug 2011 01:20:27 +0800
Message-ID: <CACVXFVNrck4u3d7EaRwuwSVO9J-_0jDQ07U0PCw55FZUxsCszA@mail.gmail.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
	<20110827151317.GA10013@kroah.com>
	<CACVXFVM_p_XPyOOgz7kbEo93SCCxPa4X_vjYGm+fUGMPSFM4EA@mail.gmail.com>
	<20110827160746.GA11076@kroah.com>
	<CACVXFVNz_ic_PPM_vNn1Dz85A2z94kRFso4rcqrvJfuLSqRSCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVNz_ic_PPM_vNn1Dz85A2z94kRFso4rcqrvJfuLSqRSCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Aug 28, 2011 at 12:57 AM, Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org> wro=
te:

>> Are you sure? =A0Have you read the documentation about memory barrie=
rs to
>> confirm this?
>
> I read the doc again, :-), and it mentions few about mb/wmb/rmb, I th=
ink
> my above description is still not correct. Generally speaking, mb onl=
y
> means there is a order between two accesses.
>
> Now I think only one mb() after 'dummy->hw_token =3D token;' is enoug=
h:
> HC will read the up-to-date value of qtd->hw_token after mb() is exec=
uted
> because of the effect of the mb(), which should be guaranteed by mb.

Looks like there is still another similar problem in qh_link_async():
the last wmb
should be changed into mb, because HC will read 'head->hw->hw_next' fro=
m qh
descriptor and this pointer in qh is read only for HC. But this problem=
 can't be
observed on ARM, since wmb on ARM is same with mb.

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
