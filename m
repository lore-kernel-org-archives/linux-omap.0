From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/4] usb: otg: twl4030: use devres API for regulator
 get and request irq
Date: Fri, 15 Mar 2013 14:00:33 +0200
Message-ID: <CANOLnOMxej7dSbQeVKZEjEN+WAFR5qLz5hO0q8NiPvQguNKcgw@mail.gmail.com>
References: <1363242239-1061-1-git-send-email-kishon@ti.com>
	<1363242239-1061-3-git-send-email-kishon@ti.com>
	<20130314154811.GA3001@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130314154811.GA3001-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 14, 2013 at 5:48 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Thu, Mar 14, 2013 at 11:53:57AM +0530, Kishon Vijay Abraham I wrot=
e:
>> Used devres APIs devm_request_threaded_irq and devm_regulator_get fo=
r
>> requesting irq and for getting regulator respectively.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>
> please refresh this on top of my testing branch, you should be patchi=
ng
> drivers/usb/phy/phy-twl4030-usb.c

Does that mean I need to rebase my series on your testing branch too?

>
> --
> balbi

--=20
Gra=FEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
