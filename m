From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 4/4] remoteproc/wkup_m3: add a remoteproc driver for TI
 Wakeup M3
Date: Sat, 16 May 2015 11:43:26 +0300
Message-ID: <CAK=WgbaooxQyTYJ8rTP5ss9_hMuWbvYjeAJTKq5kVqYuXaweuA@mail.gmail.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
 <1427917039-43206-5-git-send-email-d-gerlach@ti.com> <CAK=WgbaQPK1x6k8iq8DDCSRpna4HRyDJ-MTU+DTAst6VZy13_Q@mail.gmail.com>
 <5550C43F.3070507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5550C43F.3070507-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Mon, May 11, 2015 at 6:01 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> We don't have any carveouts or usage of any external DDR, as this
> processor is used during Power Management, like cpuidle or suspend path,
> and is used to control the MPU and DDR states. The resource table is
> very simple and straight-forward [1].

Ok thanks.

Could you please document in the patch how the WkupM3 memory is
managed? Perhaps add to this latter explanation of yours also what
stands behind the umem/dmem names, justify usage of '__force' and
document the code around the l4_offset math (which I suspect may not
always be correct, as it seems the value of l4_offset depends on the
order of mem resources returned by platform_get_resource_byname).

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
