From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ti-st: use device handles and add device tree binding
Date: Tue, 26 Jan 2016 09:47:04 -0600
Message-ID: <CAL_JsqLpU_5EKQyALMvfBFQL52ncFx+LvdTibLb2AUtVuTn=vw@mail.gmail.com>
References: <1450870253-8694-1-git-send-email-eyalr@ti.com>
 <8665E2433BC68541A24DFFCA87B70F5B23759A5B@DFRE01.ent.ti.com>
 <20151229183534.GM12450@rob-hp-laptop> <8665E2433BC68541A24DFFCA87B70F5B2376B680@DFRE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8665E2433BC68541A24DFFCA87B70F5B2376B680-1tpBd5JUCm6IQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Jan 17, 2016 at 1:57 AM, Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> wrote:
> Sorry for the delayed response.
>
>> -----Original Message-----
>> From: Rob Herring [mailto:robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
>> Sent: Tuesday, December 29, 2015 8:36 PM
>> To: Reizer, Eyal
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
>> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; pawel.moll-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
>> ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org;
>> linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
>> Subject: Re: [PATCH 1/3] ti-st: use device handles and add device tree binding
>>
>> On Wed, Dec 23, 2015 at 11:38:29AM +0000, Reizer, Eyal wrote:
>> > - Add support for getting the platform data which includes the uart
>> >   used and gpio pin used for enable from device tree.
>> >
>> > - Fix the implementation for using device handle for the uart and
>> >   gpiod for the enable pin, instead of device name (as string) used
>> >   for the uart and pio number which are both bad practice.
>> >
>> > Signed-off-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>

[...]

>> > +Optional properties:
>> > + - nshutdown-gpios : specifies attributes for gpio ping used for enabling
>> > +   the bluetooth,gps and FM sub systems
>> > + - serial-device : the phandle for the phisical uart used for interacting
>> > +   with the wilink device
>>
>> There have been multiple discussions on serial slave devices recently.
>> I'm not going to accept any device binding without a common uart slave
>> device binding first.
>>
>
> Perhaps I am reading it wrong but I think this is a different discussion.
> The shared transport driver is already in the kernel for pretty long time.
> AFAIK the original author is not around to maintain it.
> Currently it is useless  as no bindings exist for it and all customers I have seen using ti_st that upgrade
> to newer kernels have broken support and have to manually patch the kernel for adding bindings for it.

If should not be required to have a binding. You could still enumerate
it the old way even for DT platforms. It should not have been broken
if an upstream platform supported it.

> Having a new uart slave device that may provide similar functionality is a different discussion as it would
> require a total different implementation.
> But what do we do now with the implementation that is already there.
> Don't we want it to work and at least have working bindings for it?

For the kernel yes, the implementation would certainly be different,
but that is not what I'm saying. The bindings should be unaffected by
kernel implementation. You can't do it one way for what you need now
and then change the DT binding when the kernel changes. It is an API.
We should be able to reach conclusion on binding side. The kernel side
can move to a uart device subsystem if/when that exists.

Essentially, we need a common binding doc that defines:

- location of uart slave nodes
- common properties (baudrate, flow-control, etc.

That's not very much. We (DT maintainers) have been clear that we want
to see devices as child nodes of the UART they are attached to.
There's mainly been debate about using a phandle instead. I'll be fine
with using a phandle instead of a child node, but only after we have
some clear need for it.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
