From: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5] Doc/DT: hdmi-connector: add HPD GPIO documentation
Date: Mon, 12 May 2014 11:06:08 +0530
Message-ID: <53705DC8.1050903@ti.com>
References: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com> <1399638727-23254-5-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399638727-23254-5-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 09 May 2014 06:02 PM, Tomi Valkeinen wrote:
> Add binding documentation for HDMI connector's HPD GPIO.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>   Documentation/devicetree/bindings/video/hdmi-connector.txt | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/video/hdmi-connector.txt b/Documentation/devicetree/bindings/video/hdmi-connector.txt
> index ccccc19e2573..acd5668b1ce1 100644
> --- a/Documentation/devicetree/bindings/video/hdmi-connector.txt
> +++ b/Documentation/devicetree/bindings/video/hdmi-connector.txt
> @@ -7,6 +7,7 @@ Required properties:
>
>   Optional properties:
>   - label: a symbolic name for the connector
> +- hpd-gpios: HPD GPIO number

Would there ever be more than one HPD gpio?

Archit

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
