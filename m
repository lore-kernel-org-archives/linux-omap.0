From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5 v11] mfd: omap: usb: Runtime PM support for EHCI and
 OHCI drivers
Date: Thu, 22 Sep 2011 19:06:10 +0530
Message-ID: <CAP05o4L5h5J7YBupH2KJJ5Bbmdq+a78Z_OORETtnLj59ZtSZJw@mail.gmail.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com>
	<CACVXFVOoHM14AqqH0CSpwNPef1QL+7MtgZOQZhYVSdgA=5KR4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVOoHM14AqqH0CSpwNPef1QL+7MtgZOQZhYVSdgA=5KR4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 22, 2011 at 7:02 PM, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> On Thu, Sep 22, 2011 at 7:37 PM, Keshava Munegowda
> <keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
>> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>
>> The Hwmod structures and Runtime PM features are implemented
>> For EHCI and OHCI drivers of OMAP3 and OMAP4.
>> The global suspend/resume of EHCI and OHCI
>> is validated on OMAP3430 sdp board with these patches.
>>
>> These patches are re-based to Kevin's pm branch :
>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
>
> Is kernel.org up now? :-)
>
> thanks,
> --
> Ming Lei


no!

its kevin tree, which  i took it 3 weeks back. :-(

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
