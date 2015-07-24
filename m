From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 4/6] usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API
 to take 'chain' parameter
Date: Fri, 24 Jul 2015 15:51:19 +0300
Message-ID: <55B234C7.6050200@cogentembedded.com>
References: <1437720436-4261-1-git-send-email-kishon@ti.com>
 <1437720436-4261-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437720436-4261-5-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 7/24/2015 9:47 AM, Kishon Vijay Abraham I wrote:

> No functional change. Added a new parameter in _dwc3_ep0_start_trans_ to
> indicate whether the TRB is a chained TRB or last TRB. This is in
> preparation for adding chained TRB support for ep0.

> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/usb/dwc3/ep0.c |   15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)

> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 4998074..d1a2be1 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -56,7 +56,7 @@ static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
>   }
>
>   static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
> -		u32 len, u32 type)
> +		u32 len, u32 type, unsigned chain)

    I'm seeing you always pass *false*, so why not just *bool* here?

[...]

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
