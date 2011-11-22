From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Tue, 22 Nov 2011 16:39:52 +0530
Message-ID: <CAJuYYwT_useS-8cH+qfDu5t7wh73yUuJAVXMjP5CXBS2VM3bag@mail.gmail.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
	<1321274409-24643-2-git-send-email-rnayak@ti.com>
	<20111114172312.GI31337@atomide.com> <4EC1EB9D.1000503@ti.com>
	<CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
	<CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
	<CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On 17 November 2011 19:27, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Nov 17, 2011 at 12:26 PM, Thomas Abraham
> <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> For now, the Samsung GPIO, Pinconfig and Pinmux information is
>> represented in device tree as listed below.
>
> Does this mean that the understanding of this format is merged into
> the mainline kernel drivers or is it keps out-of-tree?


All existing dt support in samsung drivers use this format and it
works fine. But I could not complete work on time and pull request for
samsung-dt support for 3.2 was delayed and hence rejected. So for now,
it is out of tree but available in linux-next.

>
>> i2c@1C004000 {
>> =A0 =A0 =A0 =A0 =A0compatible =3D "...";
>> =A0 =A0 =A0 =A0 =A0reg =3D <0x... 0x..>;
>> =A0 =A0 =A0 =A0 =A0 gpios =3D <&gpa0 2 2 3 0>,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<&gpa0 3 2 3 0>;
>> =A0 =A0 =A0 =A0 =A0...
>> };
>>
>> The format of the gpio specifier is
>> <[Pad Controller phandle] [pin number within the controller] [Pin Mux
>> Function] [Pull Up/Down] [Drive Strength]>
>>
>> From a perspective of writing a 'gpios' property for a device node,
>> this is quite simple. Looking up the hardware manual of the SoC can
>> provide all the values that should be used in the gpio specifier.
>
> That may not be as simple as it seems if all you have is the
> device tree and no manual, but I get the picture.
>
>> The GPIO/PinCtrl driver can provide a translate function that picks up
>> the values for the gpio specifier and writes the same value to the
>> pad-controller registers. But, this a deviation from the existing
>> pinctrl subsystem code which mainly relies on name of the pin-group
>> and pin-function.
>>
>> Does this seem to be a feasible option for specifying
>> gpio/pinconfig/pinmux dt bindings?
>
> I would prefer the above to use the nice generic enums from the
> pin control subsystem's pinmux and pinconf properties in the
> end so the device tree on its own is understandable without
> any manual whatsoever, but we'll see about that.


This may lead to linux specific information getting into the device
tree. And that might not be acceptable.

>
> Maybe I'm mistaken about the device tree ambitions, but
> I was sort of hoping that it would not contain too much
> custom magic numbers that need to be cross-referenced
> elsewhere ... or rather - the more understandable the device
> tree is, the more we win.

Device tree is expected to describe the hardware. So to
cross-reference the hardware manual to understand device tree should
be fine I guess. For instance, GPIO numbers in dts would be written as
a numeric number and not a enum or other format. And by looking up the
manual, we understand the actual details of the GPIO pin.

If dt-compiler had a option to support #define like in C, the numbers
could have been made more easier to understand. Like, 3 to mean
GPIO_PULL_UP in Exynos dts file.

Thanks,
Thomas.
