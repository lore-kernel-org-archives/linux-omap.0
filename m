From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 0/3] misc: new serdev based drivers for w2sg00x4 GPS module
 and w2cbw003 wifi/bluetooth
Date: Mon, 22 May 2017 21:26:39 -0500
Message-ID: <CAL_Jsq+fmi2QwE7J8xv47ece1b+jqnOo99NghfjtocnrRvBkPg@mail.gmail.com>
References: <cover.1495363443.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1495363443.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, May 21, 2017 at 5:44 AM, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
> Since our proposed API was not acceptable and the new serdev API has arrived in 4.11 kernels,
> we finally took the challenge to update the w2sg and w2cbw drivers to use the serdev API.
>
> The approach is to write a "man in the middle" driver which is on one side a serdev client
> which directly controls the UART where the device is connected to and on the other side
> presents a new tty port so that user-space software can talk to the chips as if they would
> directly talk to the UART of the SoC (e.g. ttyO1). This is similar to connecting to a remote
> serial device e.g. through USB (ttyACM) or Bluetooth UART profiles.
>
> For example gpsd or hciattach expect a /dev/tty they can control (flow control, baud rate
> etc.).

I understand from the prior discussion why you want to pass the data
thru for gps, but why do you need to do that for BT?

> Here is the result of our first hack which is working as a demo on GTA04 devices (and the
> w2cbw driver can also be used to control a GTA04 variant with WL1837).
>
> Since it is just a demo hack, the code is not yet cleaned up, nor does it completely pass
> check-patch, nor follows 100% the coding styles. And certainly has some bugs.
>
> The most significant issue is that calling tty_port_register_device() inside of the
> serdev probe() function makes the serdev probe() function to be entered a second
> time. This does not lead to big problems since we currently have minor = 0
> and this makes the second call assume the device is not available.
>
> But we have no idea why this happens and how it can be prevented.

Johan's fixes may help there, but it is intended to be temporary to
have a separate API for registering tty ports with or without serdev.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
