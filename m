From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 0/7] omap hwspinlock dt support
Date: Tue, 18 Mar 2014 15:35:32 +0200
Message-ID: <CAK=WgbZ1M0JZE2BH0ukNo33hBuffTGbd3-DD0WCiwZ-akgvQ-Q@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <52F9282B.5000702@ti.com> <530B8C00.8020001@ti.com> <CAK=WgbZp_RQPCeZJyMRkNTQxaJsnGZ3DnjhSkYYR_-PAE_Kp4g@mail.gmail.com>
 <53239789.40600@ti.com> <CAK=WgbZCzA7JovSxnysHCQRZZWc3Z2j3AS8ekpM9fOZ160rmCA@mail.gmail.com>
 <532748B7.1080606@ti.com> <CAK=WgbYjtw+cxy5wX6pjK=Rpj6wOk6Cu+GrPuFN+sqtgDAY=_Q@mail.gmail.com>
 <53278950.5030905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53278950.5030905-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Tue, Mar 18, 2014 at 1:46 AM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> So far, we have not come across multiple controllers. I see your point,
> and I think this also depends on the semantics of how you exchange the
> lock id number. The agreement at the moment is on base_ids across
> multiple SoC components. If the semantics involve exchanging the
> controller instance, for example, then we might get away with it. But
> that probably involves adding additional helpers to retrieve controller
> instance in addition to lock number, or some other similar functions.

Yes, this could be done too, but I agree it is less simple with no real win.

> Sorry, I should have rephrased it better - by order, I meant the
> inherent order between board early code and other drivers. With DT, we
> cannot guarantee that right, as specific locks are requested from drivers.

Yeah.

> Understood. And we may have to assign the client association with a lock
> as well. These are core changes that were actually not needed in the
> non-DT case due to the inherent order as stated above. So, are you
> suggesting that we add one more property to the controller node to mark
> which are reserved, or rely on constructing this through DT tree parsing?

I guess this is a question to the DT folks; both approaches work from
hwspinlock perspective.

In the past Arnd Benoit and myself were happy with adding one more
property to the controller node, but this might be somewhat error
prone as it leaves room for mistakes - developers can add hwlock
phandles and forget to update the reserved property in the controller
node.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
