From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: add bluetooth
Date: Sat, 15 Apr 2017 20:56:57 -0500
Message-ID: <CAL_JsqJfytNJMuXQ-eAqxsoVNDMO73omS67F_Onw_XQh9E6FHg@mail.gmail.com>
References: <20170415221832.16175-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170415221832.16175-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Apr 15, 2017 at 5:18 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Droid 4 has wl1835 connected to the OMAP's UART4 port, which is
> used for Bluetooth and most likely can also be used for controlling
> the FM radio and GPS receivers.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Hi,
>
> Thanks to the work of Rob adding Bluetooth support for Droid 4 was
> straight forward :) I did a short test scanning for available devices
> using bluetoothctl. For that I had to rebind the bluetooth device,
> since it has been initialized before rootfs/firmware was available
> (builtin driver):
>
> echo serial0-0 > /sys/bus/serial/drivers/hci-ti/unbind
> echo serial0-0 > /sys/bus/serial/drivers/hci-ti/bind
>
> According to my research the FM module should be functional on
> Droid 4 and the wl1835's GPS is also used. Rob, do you have a
> plans for supporting the extra resources?

I don't think the h/w I have can do FM or GPS. At least there's no
headphone jack to serve as the FM antenna. For GPS, it seems support
for that is not publicly available. Maybe an antenna is not needed to
get the control interface working. It would be nice to integrate
though and then we can kill off the shared transport driver. Marcel
had mentioned that the Intel BT driver provides a regmap interface to
its FM driver. Not sure if that would work for TI.

Rob
