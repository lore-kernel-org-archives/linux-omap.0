From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 12/14] media: wl128x-radio: move from TI_ST to hci_ll driver
Date: Wed, 9 Jan 2019 19:23:01 -0600
Message-ID: <CAL_JsqKzR_rsDithiUpBUzK3STM+O4xA=z9ihpfYSSf1KswpMw@mail.gmail.com>
References: <20181221011752.25627-1-sre@kernel.org> <20181221011752.25627-13-sre@kernel.org>
 <C85D80C9-2B00-4161-B934-9D70E2B173D0@holtmann.org> <20190109181156.yamhult6bpwkhx74@earth.universe>
 <0C9AD246-B511-4E59-888F-47EAB034D4BF@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0C9AD246-B511-4E59-888F-47EAB034D4BF@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Sebastian Reichel <sre@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 9, 2019 at 1:24 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sebastian,
>
> >>> +static int ll_register_fm(struct ll_device *lldev)
> >>> +{
> >>> +   struct device *dev = &lldev->serdev->dev;
> >>> +   int err;
> >>> +
> >>> +   if (!of_device_is_compatible(dev->of_node, "ti,wl1281-st") &&
> >>> +       !of_device_is_compatible(dev->of_node, "ti,wl1283-st") &&
> >>> +       !of_device_is_compatible(dev->of_node, "ti,wl1285-st"))
> >>> +           return -ENODEV;
> >>
> >> do we really want to hardcode this here? Isn't there some HCI
> >> vendor command or some better DT description that we can use to
> >> decide when to register this platform device.
> >
> > I don't know if there is some way to identify the availability
> > based on some HCI vendor command. The public documentation from
> > the WiLink chips is pretty bad.
>
> can we have some boolean property in the DT file then instead of hardcoding this in the driver.

Implying the feature based on the compatible is how this is normally
done for DT. Though typically we'd put the flag in driver match data
rather than code it like this.

However, I'd assume that FM radio depends on an antenna connection (to
the headphone) which a board may or may not have even though the chip
supports it. For that reason, I'm okay with a boolean here.

Rob
