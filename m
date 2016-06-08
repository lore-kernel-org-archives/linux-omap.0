From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v9 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Wed, 8 Jun 2016 14:39:07 +0300
Message-ID: <5bc321c0-fb36-7a4a-d054-ee73b12822d4@cogentembedded.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465376626-30122-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 6/8/2016 12:03 PM, Roger Quadros wrote:

> The OTG core will use struct otg_hcd_ops to interface
> with the HCD controller.

    Host controller driver (HCD) controller? Maybe just HC? :-)

> The main purpose of this interface is to avoid directly
> calling HCD APIs from the OTG core as they
> wouldn't be defined in the built-in symbol table if
> CONFIG_USB is m.
>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Acked-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> ---
>  include/linux/usb/hcd.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 66fc137..7914bed 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -400,6 +400,30 @@ struct hc_driver {
>
>  };
>
> +/**
> + * struct otg_hcd_ops - Interface between OTG core and HCD
> + *
> + * Provided by the HCD core to allow the OTG core to interface with the HCD
> + *
> + * @add: function to add the HCD
> + * @remove: function to remove the HCD
> + * @usb_bus_start_enum: function to immediately start bus enumeration
> + * @usb_control_msg: function to build and send of a control urb

    That "of" is not needed. And it's URB.

[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
