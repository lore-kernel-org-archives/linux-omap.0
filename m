From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 RESEND 1/3] Documentation: dt: memory: ti-emif: add edac
 support under emif
Date: Tue, 26 Dec 2017 16:50:18 -0600
Message-ID: <CAL_Jsq+9=Py6tGgTQSKnBb3xJstPm=3cTP=pqWcCLvMJ83ajyQ@mail.gmail.com>
References: <1513959834-27901-1-git-send-email-t-kristo@ti.com> <20171226224819.6uekbnbd5tllaxb5@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171226224819.6uekbnbd5tllaxb5@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 26, 2017 at 4:48 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Dec 22, 2017 at 06:23:54PM +0200, Tero Kristo wrote:
>> Certain revisions of the TI EMIF IP contain ECC support in them. Reflect
>> this in the DT binding.
>
> "dt-bindings: edac: ..." is the preferred subject prefix.

Err, I mean "dt-bindings: memory-controllers: ..."

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
