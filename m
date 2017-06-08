From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv3] Bluetooth: hci_ll: Add compatible values for more WL chips
Date: Thu, 8 Jun 2017 16:02:11 -0500
Message-ID: <CAL_JsqKh0MMiKjPbzcy+4tCagvyYHM72fyCfYaiWcpBc2ZCy1w@mail.gmail.com>
References: <20170608205845.4903-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608205845.4903-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 8, 2017 at 3:58 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Add compatible values for WiLink chips from 128x and 180x series.
> Also the DT binding already contained compatible values for the 127x
> series, but the driver did not. This brings the list on par with
> the list from wlcore (the wifi driver).
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
> Hi,
>
> This patch originally was part of the "Motorola Droid 4: Add WL1285C support"
> series. It can be queued standalone via the bluetooth tree, though.
>
> Changes since PATCHv2:
>  * none
> Changes since PATCHv1:
>  * patch did not exist
>
> -- Sebastian
> ---
>  Documentation/devicetree/bindings/net/ti,wilink-st.txt | 6 ++++++
>  drivers/bluetooth/hci_ll.c                             | 8 ++++++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
