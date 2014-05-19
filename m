From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/6] usb: dwc3: dwc3-omap: Remove x_major calculation
 from revision register
Date: Mon, 19 May 2014 15:05:58 +0400
Message-ID: <5379E596.7010308@cogentembedded.com>
References: <1400488377-10605-1-git-send-email-george.cherian@ti.com> <1400488377-10605-2-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400488377-10605-2-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 19-05-2014 12:32, George Cherian wrote:

> Remove the x_major calculation logic from the wrapper revision register
> to differentiate between OMAP5 and AM437x. This was done to find the
> register offsets of wrapper register. Now that We do it using dt
> compatible, remove the whole logic.

> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/usb/dwc3/dwc3-omap.c | 35 +++--------------------------------
>   1 file changed, 3 insertions(+), 32 deletions(-)

> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 1160ff4..53f6490 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
[...]
> @@ -448,32 +442,9 @@ static int dwc3_omap_probe(struct platform_device *pdev)
[...]
> -	/* For OMAP5(ES2.0) and AM437x x_major is 2 even though there are
> -	 * changes in wrapper registers, Using dt compatible for aegis
> +	/* Differentiate between OMAP5 and AM437x
> +	 * For OMAP5(ES2.0) and AM437x x_major is 2 even though there are
> +	 * changes in wrapper registers, Using dt compatible for AM437x

    This sentence doesn't look complete...

>   	 */
>
>   	if (of_device_is_compatible(node, "ti,am437x-dwc3")) {

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
