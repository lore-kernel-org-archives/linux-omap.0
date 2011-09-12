From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] arm: omap: usb: enable I/O wakeups of ehci and ohci
 hwmods of omap4
Date: Mon, 12 Sep 2011 12:06:31 +0530
Message-ID: <CAP05o4+L=RtVr_653WRukwBtQX+8KyBNStmRjg7sk4tEoNY77w@mail.gmail.com>
References: <1315579967-24945-1-git-send-email-keshava_mgowda@ti.com>
	<1315579967-24945-2-git-send-email-keshava_mgowda@ti.com>
	<87mxedwoyu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87mxedwoyu.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, Kishon Vijay Abraham <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 9, 2011 at 11:57 PM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
>
>> From: Kishon Vijay Abraham <kishon-l0cyMroinI0@public.gmane.org>
>>
>> For ehci and ohci hwmods, the omap4 I/O wakeup capablity is enabled.
>> for ehci in phy mode,
>> =A0 =A0 =A0 - the DAT0 and DIR I/O pad is set as wakeup capable
>> for ohci in serial mode
>> =A0 =A0 =A0 - usbb*_mm_rxdp is set as I/O wakeup for 6 pin serial mo=
de
>> =A0 =A0 =A0 - usbb*_mm_rxrcv is set as I/O wakeup for 4 pin serial m=
ode
>> =A0 =A0 =A0 - usbb*_mm_txen is set as I/O wakeup for 3 pin serial mo=
de
>> =A0 =A0 =A0 - usbb*_mm_txdat is set as I/O wakeup for 2 pin serial m=
ode
>>
>> Signed-off-by: Kishon Vijay Abraham <kishon-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>
> What if the end user doesn't want this device to be a wakeup source?
>
> Currently, the IO pad wakeup for these pins is enabled unconditionall=
y.
> While having it enabled as a wakeup source by default is fine, it sho=
uld
> not generate wakeups if the user has disable them by doing:
>
> =A0 =A0$ echo disabled > /sys/devices/.../power/wakeup

OK, I will do this.

keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
