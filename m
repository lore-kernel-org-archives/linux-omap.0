From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5 v9] mfd: omap: usb: Runtime PM support
Date: Fri, 16 Sep 2011 13:01:58 +0530
Message-ID: <CAP05o4JxUPBM=PqguRL8-Mvgyf=wgxvg7UWMcRo2WXe2jmCUVA@mail.gmail.com>
References: <1316092970-2440-1-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-2-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-3-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-4-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-5-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-6-git-send-email-keshava_mgowda@ti.com>
	<4E729AFB.6010008@am.sony.com>
	<CAP05o4JK9zdZ8P5o0Di+obDwYjur0p=TC-n9weznqx_odMzycw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAP05o4JK9zdZ8P5o0Di+obDwYjur0p=TC-n9weznqx_odMzycw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: frank.rowand-mEdOJwZ7QcZBDgjK7y7TUQ@public.gmane.org
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "b-cousson-l0cyMroinI0@public.gmane.org" <b-cousson-l0cyMroinI0@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "gadiyar-l0cyMroinI0@public.gmane.org" <gadiyar-l0cyMroinI0@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org" <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "khilman-l0cyMroinI0@public.gmane.org" <khilman-l0cyMroinI0@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org" <johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, "vishwanath.bs-l0cyMroinI0@public.gmane.org" <vishwanath.bs-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 16, 2011 at 11:17 AM, Munegowda, Keshava
<keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
> On Fri, Sep 16, 2011 at 6:10 AM, Frank Rowand <frank.rowand-mEdOJwZ7QcbF11Dp+j+f1g@public.gmane.org=
om> wrote:
>> On 09/15/11 06:22, Keshava Munegowda wrote:
>>> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>>
>>> The usbhs core driver does not enable/disable the interface and
>>> functional clocks; These clocks are handled by hwmod and runtime pm=
,
>>> hence instead of the clock enable/disable, the runtime pm APIS are
>>> used. however,the port clocks are handled by the usbhs core.
>>>
>>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>> Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
>>> ---
>>> =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A03 -
>>> =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 | =A0731 +++++++=
++++++--------------------
>>> =A0drivers/usb/host/ehci-omap.c =A0 =A0 =A0 =A0 =A0| =A0 17 +-
>>> =A0drivers/usb/host/ohci-omap3.c =A0 =A0 =A0 =A0 | =A0 18 +-
>>> =A04 files changed, 295 insertions(+), 474 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-=
omap/include/plat/usb.h
>>> index 17d3c93..2b66dc2 100644
>>
>> Patch 5/5 is white space mangled. =A0The tabs have been changed into=
 spaces.
>>
>> -Frank
>

Hi Frank
          I tried the checkpatch with --strict option; its not showing
anything here. may be some problem with your editor/browser.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
