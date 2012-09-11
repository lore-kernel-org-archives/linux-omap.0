From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 3/3] usb: musb: omap: Add device tree support for
 omap musb glue
Date: Tue, 11 Sep 2012 11:34:56 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB0E00@DBDE01.ent.ti.com>
References: <1347354580-5895-1-git-send-email-kishon@ti.com>
 <1347354580-5895-4-git-send-email-kishon@ti.com>	<504F0A33.9060606@ti.com>
 <CAAe_U6LwGn+qbSox7BofTg7sJUxqytew3s_73MOYZytHs2qEWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAAe_U6LwGn+qbSox7BofTg7sJUxqytew3s_73MOYZytHs2qEWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Balbi,
 Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 11, 2012 at 16:54:37, ABRAHAM, KISHON VIJAY wrote:
> Hi,
> 
> On Tue, Sep 11, 2012 at 3:23 PM, Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org> wrote:
> >
> >
> > On 9/11/2012 2:39 PM, Kishon Vijay Abraham I wrote:
> >> Added device tree support for omap musb driver and updated the
> >> Documentation with device tree binding information.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  Documentation/devicetree/bindings/usb/omap-usb.txt |   33 ++++++++++++
> >>  drivers/usb/musb/omap2430.c                        |   54 ++++++++++++++++++++
> >>  2 files changed, 87 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/usb/omap-usb.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
> >> new file mode 100644
> >> index 0000000..29a043e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> >> @@ -0,0 +1,33 @@
> >> +OMAP GLUE
> >> +
> >> +OMAP MUSB GLUE
> >> + - compatible : Should be "ti,omap4-musb" or "ti,omap3-musb"
> >> + - ti,hwmods : must be "usb_otg_hs"
> >> + - multipoint : Should be "1" indicating the musb controller supports
> >> +   multipoint. This is a MUSB configuration-specific setting.
> >> + - num_eps : Specifies the number of endpoints. This is also a
> >> +   MUSB configuration-specific setting. Should be set to "16"
> >> + - ram_bits : Specifies the ram address size. Should be set to "12"
> >> + - interface_type : This is a board specific setting to describe the type of
> >> +   interface between the controller and the phy. It should be "0" or "1"
> >> +   specifying ULPI and UTMI respectively.
> >> + - mode : Should be "3" to represent OTG. "1" signifies HOST and "2"
> >> +   represents PERIPHERAL.
> >> + - power : Should be "50". This signifies the controller can supply upto
> >> +   100mA when operating in host mode.
> >> +
> >> +SOC specific device node entry
> >> +usb_otg_hs: usb_otg_hs@4a0ab000 {
> >> +     compatible = "ti,omap4-musb";
> >> +     ti,hwmods = "usb_otg_hs";
> >> +     multipoint = <1>;
> >> +     num_eps = <16>;
> >> +     ram_bits = <12>;
> >> +};
> >
> >
> > reg and interrupt properties are missing here.
> >
> > I would encourage to specify "reg" and "interrupt" properties in every
> > node getting newly added to the OMAP DTS files.
> 
> Sure. will add that in my next version.
> 

I saw there is some discussion going-on for which baseline to use, so make 
sure that you test the patches on top of below patch (already available in 
linux-omap/devel-dt)

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=b82b04e8eb27abe0cfe9cd7bf4fee8bb1bb9b013


Thanks,
Vaibhav
> Thanks
> Kishon
> 
