From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] USB: musb-gadget: enable autoclear for OUT transfer
 in both DMA 0 and DMA 1
Date: Tue, 7 Sep 2010 21:26:16 +0800
Message-ID: <AANLkTincwFFDke-61+ZPsKgv2cOSyYFrSu0qgT0Yxtnd@mail.gmail.com>
References: <1282920723-12459-1-git-send-email-tom.leiming@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03291AE04A@dbde02.ent.ti.com>
	<AANLkTim8WC_2H3tUL4nU9LD2xDjzUbB1ERhMQeA20z1K@mail.gmail.com>
	<4C8512BC.2080003@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C8512BC.2080003-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/9/7 Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>:
> Hello.
>
> Ming Lei wrote:
>
>>> Which codebase is this patch meant for?
>>> I don't see the hb_mult in current mainline code?
>
>>> Are there any patches which this one depends on?
>
>> This depends on the two iso for device mode patches:
>> =A0 =A0 =A0 =A0 http://marc.info/?l=3Dlinux-usb&m=3D128076716001885&=
w=3D2
>> =A0 =A0 =A0 =A0 http://marc.info/?l=3Dlinux-usb&m=3D128076716901924&=
w=3D2
>
>> I plan to resend the two patches above and the double buffer patches
>> later.
>
> =A0 I recommend that you change the ordering of patches so that fixes=
 come
> first, and new features last. I.e. this patch should precede the seco=
nd one
> of those two above.

Good point, I will resend all the fix patches first, then the
isochronous support
patch.

thanks,

--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
