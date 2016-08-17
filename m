From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 3/7] dt: bindings: Add nokia-bluetooth
Date: Wed, 17 Aug 2016 08:11:03 -0500
Message-ID: <CAL_JsqLcDzTZ++h+e7D-n0xbt7LgryK6jfGJDNEcAaU=Dn4b0w@mail.gmail.com>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-4-git-send-email-sre@kernel.org> <20160816135155.GA20948@rob-hp-laptop>
 <20160816232855.qgempm64zgp36ufd@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160816232855.qgempm64zgp36ufd@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 16, 2016 at 6:28 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Hi Rob,
>
> On Tue, Aug 16, 2016 at 08:51:55AM -0500, Rob Herring wrote:
>> On Sat, Aug 13, 2016 at 05:14:34AM +0200, Sebastian Reichel wrote:
>> > ---
>> >  .../devicetree/bindings/net/nokia-bluetooth.txt    | 43 ++++++++++++++++++++++
>> >  1 file changed, 43 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>> > new file mode 100644
>> > index 000000000000..a0fceabb4cce
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>> > @@ -0,0 +1,43 @@
>> > +Nokia bluetooth UART devices
>> > +------
>> > +
>> > +Some vendors have custom versions of their chips, that can be found in Nokia
>> > +devices. These chips are controlled differently, than the non-Nokia version,
>> > +so a different binding is required. All chips listed here implement the Nokia
>> > +H4+ protocol.
>> > +
>> > +Required properties:
>> > +
>> > +  - compatible: should be one of the following:
>> > +   * "nokia,brcm,bcm2048"
>> > +   * "nokia,ti,wl1271-bluetooth"
>>
>> Perhaps these should be 2 separate strings. Something like
>> '"nokia,n900-bt", "brcm,bcm2048"'. However, if they are in no way
>> compatible with the default version from the vendors, then just a single
>> string is fine, but it doesn't need to be aligned to the vendor
>> compatible string. So just "nokia,n900-bcm2048" or similar is fine.
>
> The default bcm2048 variant uses different initialization process
> and does not use word alignment as far as I know. I think having
> "brcm,bcm2048" in the compatible string is wrong.

Okay.

> I guess "brcm,bcm2048-nokia" would also be an option, since the
> chip has been built buy broadcom, but it has a custom Nokia
> interface.

That would be okay. Though, in theory Nokia could have different
products with bcm2048 all with different versions.

I was going with defining it as a board level compatible string. Even
if chips are the same, s/w can need to know board level differences so
using the board vendor and name are common.

>> > +  - reset-gpios:           Should specify the gpio for bluetooth reset
>> > +  - host-wakeup-gpios:             Should specify the gpio for host wakeup
>>
>> Should be interrupt instead?
>
> Yes this is mostly an interrupt, but I need to read the current
> line state.

When? If the interrupt is level triggered, then you can get the line
state based on whether you get an interrupt or not. If this needs to
be a wakeup source (see the wakeup source binding), then it needs to
be an interrupt.

Reading the line state is a common problem. It would be nice if the
irq API provided a function to read the line state though that is not
always possible.

>
>> > +  - bluetooth-wakeup-gpios:        Should specify the gpio for bluetooth wakeup
>>
>> State direction and active state for gpios.
>
> ok.
>
>> > +  - clock-names:           Should be "sysclk"
>> > +  - clocks:                        Should contain a clock phandle for system clock
>> > +
>> > +Example:
>> > +
>> > +/ {
>> > +   /* controlled (enabled/disabled) directly by wl1271 */
>> > +   vctcxo: vctcxo {
>> > +           compatible = "fixed-clock";
>> > +           #clock-cells = <0>;
>> > +           clock-frequency = <38400000>;
>> > +   };
>> > +};
>> > +
>> > +&uart2 {
>>
>> I want to see a common serial device binding doc before accepting any
>> device bindings. It's not going to say much initially other than devices
>> are child nodes of uarts. Perhaps something on baudrate settings.
>
> Neil added a short sentence about this in "[RFC 2/7] tty: add
> support for "tty slave" devices". I just took the unmodified patch
> from Neil (*), so it's not in its own patch.

But that is in the 8250 binding. It needs to be a common binding.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
