From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v7 0/3] arm/dts: Add device tree data for AM33XX devices
Date: Fri, 7 Sep 2012 10:01:36 -0700
Message-ID: <20120907170135.GY1303@atomide.com>
References: <1346924304-27425-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA293E9@DBDE01.ent.ti.com>
 <5049B245.9080807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5049B245.9080807-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org> [120907 01:38]:
> Hi Anil,
> 
> On 09/07/2012 07:30 AM, AnilKumar, Chimata wrote:
> > On Thu, Sep 06, 2012 at 15:08:21, AnilKumar, Chimata wrote:
> >> Add pinctrl and d_can device tree data to AM33XX family of devices.
> >> First two patches add support for pinctrl DT data and third one
> >> adds dcan DT data.
> >>
> >> Reason behind combining these patches is to apply cleanly on
> >> linux-omap tree, because these are sequential patches.
> >>Yes, 
> >> These patches were tested on AM335x-Bone, AM335x-EVM and based
> >> on linux-omap:master with this patch
> >> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg74393.html
> >>
> > 
> > If there are no changes in this patch series ACK from
> > reviewers (esp. Tony, koen and Marc) will help.
> 
> Yes, indeed. The series looks good to me, but it will be nice to get
> some acks from people who commented previous revision.

Acked two of them, but there's still some gpio-leds.c discussion
going on that should be resolved first.

Tony
