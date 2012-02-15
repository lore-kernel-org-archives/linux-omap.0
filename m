From: Govindraj <govindraj.ti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] usb: host: ehci: allow ehci_* symbols to be unused
Date: Wed, 15 Feb 2012 21:27:35 +0530
Message-ID: <CAAL8m4z72at5heepktM1ieQHFKkApzVY9OzO-hte-U=AZfA=nw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1202141505400.1544-100000@iolanthe.rowland.org> <1329291266-15798-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329291266-15798-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 15, 2012 at 1:04 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> not all platforms will use all of those ehci_*
> symbols on their hc_driver structure. Sometimes
> we might need to provide a modified version of
> a certain method or not provide it at all, as is
> the case with OMAPs which don't support port handoff
> feature.
>
> Whenever we compile a kernel for an OMAP board with
> EHCI enabled, we get compile warnings:
>
> drivers/usb/host/ehci-hub.c:1079: warning: 'ehci_relinquish_port' \
> =A0 =A0 =A0 =A0defined but not used
> drivers/usb/host/ehci-hub.c:1088: warning: 'ehci_port_handed_over' \
> =A0 =A0 =A0 =A0defined but not used
>
> In order to cleanup those warnings, we're adding
> __maybe_unused annotation to those functions.
>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>
> Changes from v1:
> =A0 =A0 =A0 =A0- only add __maybe_used to relinquish_port, port_hande=
d_over
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0and port_change
>
> =A0drivers/usb/host/ehci-hub.c | =A0 =A08 +++++---
> =A01 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.=
c
> index 77bbb23..01011dd 100644
> --- a/drivers/usb/host/ehci-hub.c
> +++ b/drivers/usb/host/ehci-hub.c
> @@ -107,7 +107,7 @@ static void ehci_handover_companion_ports(struct =
ehci_hcd *ehci)
> =A0 =A0 =A0 =A0ehci->owned_ports =3D 0;
> =A0}
>
> -static int ehci_port_change(struct ehci_hcd *ehci)
> +static int __maybe_unused ehci_port_change(struct ehci_hcd *ehci)

should be __maybe_used ? and in rest of the patch

> =A0{
> =A0 =A0 =A0 =A0int i =3D HCS_N_PORTS(ehci->hcs_params);
>
> @@ -1076,7 +1076,8 @@ error_exit:
> =A0 =A0 =A0 =A0return retval;
> =A0}
>
> -static void ehci_relinquish_port(struct usb_hcd *hcd, int portnum)
> +static void __maybe_unused ehci_relinquish_port(struct usb_hcd *hcd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int portnum)
> =A0{
> =A0 =A0 =A0 =A0struct ehci_hcd =A0 =A0 =A0 =A0 *ehci =3D hcd_to_ehci(=
hcd);
>
> @@ -1085,7 +1086,8 @@ static void ehci_relinquish_port(struct usb_hcd=
 *hcd, int portnum)
> =A0 =A0 =A0 =A0set_owner(ehci, --portnum, PORT_OWNER);
> =A0}
>
> -static int ehci_port_handed_over(struct usb_hcd *hcd, int portnum)
> +static int __maybe_unused ehci_port_handed_over(struct usb_hcd *hcd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int portnum)
> =A0{
> =A0 =A0 =A0 =A0struct ehci_hcd =A0 =A0 =A0 =A0 *ehci =3D hcd_to_ehci(=
hcd);
> =A0 =A0 =A0 =A0u32 __iomem =A0 =A0 =A0 =A0 =A0 =A0 *reg;
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
