From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
Date: Sun, 14 Aug 2016 19:54:28 -0400
Message-ID: <CAP=VYLo4ptVzhPjKoiiakbCgBSmpQndNzf0LHWxCZs7LiZ7PYw@mail.gmail.com>
References: <1471058078-5579-1-git-send-email-sre@kernel.org> <1471058078-5579-6-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471058078-5579-6-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 12, 2016 at 11:14 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> This driver adds support for Nokia H4+ procotol used
> for example by Nokia's internet tablets (N770 - N950).
> ---
>  drivers/bluetooth/Kconfig     |  10 +
>  drivers/bluetooth/Makefile    |   1 +
>  drivers/bluetooth/hci_ldisc.c |   6 +
>  drivers/bluetooth/hci_nokia.c | 734 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_nokia.h | 140 ++++++++
>  drivers/bluetooth/hci_uart.h  |   8 +-
>  6 files changed, 898 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/bluetooth/hci_nokia.c
>  create mode 100644 drivers/bluetooth/hci_nokia.h
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index cf50fd2e96df..c32d9d5ad1d2 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -86,6 +86,16 @@ config BT_HCIUART_H4
>
>           Say Y here to compile support for HCI UART (H4) protocol.
>
> +config BT_HCIUART_NOKIA
> +       bool "UART Nokia H4+ protocol support"

If the option is a bool, then you don't need module.h or any MODULE
macros, nor do you need any __exit or unregister related code.

Alternatively, if there is a use case for it to be modular, then maybe you
want to change the above to a tristate.

Paul.
--

> +       depends on BT_HCIUART
> +       help
> +         Nokia H4+ is serial protocol for communication between Bluetooth
> +         device and host. This protocol is required for Bluetooth devices
> +         with UART interface in Nokia devices.
> +
> +         Say Y here to compile support for Nokia's H4+ protocol.
> +
>  config BT_HCIUART_BCSP
>         bool "BCSP protocol support"
>         depends on BT_HCIUART


[...]

> +       { .compatible = "nokia,ti,wl1271-bluetooth", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
> +
> +static struct platform_driver platform_nokia_driver = {
> +       .driver = {
> +               .name = "nokia-bluetooth",
> +               .of_match_table = nokia_bluetooth_of_match,
> +       },
> +       .probe = nokia_bluetooth_probe,
> +};
> +
> +int __init nokia_init(void)
> +{
> +       platform_driver_register(&platform_nokia_driver);
> +       return hci_uart_register_proto(&nokia_proto);
> +}
> +
> +int __exit nokia_deinit(void)
> +{
> +       platform_driver_unregister(&platform_nokia_driver);
> +       return hci_uart_unregister_proto(&nokia_proto);
> +}
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
