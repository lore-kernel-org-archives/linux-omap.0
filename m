From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: dts: AM4372: Add the wkup_m3_ipc node
Date: Thu, 21 Jan 2016 13:55:49 -0800
Message-ID: <20160121215549.GP19432@atomide.com>
References: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
 <1437167284-25659-5-git-send-email-d-gerlach@ti.com>
 <20150805103155.GB16878@atomide.com>
 <569D486B.6080000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <569D486B.6080000-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [160118 12:18]:
> Hi Tony,
> On 08/05/2015 05:31 AM, Tony Lindgren wrote:
> >* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [150717 14:10]:
> >>From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> >>
> >>Add the Wakeup M3 IPC device node for the wkup_m3_ipc driver on
> >>AM4372 SoC. This node uses the IPC registers, part of the Control
> >>Module, and is therefore added as a child of the scm node.
> >
> >Applying the last two patches in this series into omap-for-v4.3/dt
> >thanks.
> >
> >Probably the send-no-irq quirk you can do in the driver based
> >on the compatible flag like I suggested in the related mailbox
> >thread so not applying those until that's been discussed.
> 
> Now that this compatible flag for the mbox driver has been accepted here:
> 8e3c5952144f ("mailbox/omap: Add ti,mbox-send-noirq quirk to fix AM33xx CPU
> Idle") can the first two patches in this series get picked up. I tested
> applying to v4.4 and they still apply cleanly.

OK applying into omap-for-v4.5/fixes thanks.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
