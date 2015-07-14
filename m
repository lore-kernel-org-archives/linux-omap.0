From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 45/48] usb: gadget: net2280: add net2280_match_ep()
 function
Date: Tue, 14 Jul 2015 14:14:54 +0300
Message-ID: <55A4EF2E.9090306@cogentembedded.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
 <1436866776-5004-46-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1436866776-5004-46-git-send-email-r.baldyga@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org, balbi@ti.com
Cc: devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, johnyoun@synopsys.com, linuxppc-dev@lists.ozlabs.org, cernekee@gmail.com, nicolas.ferre@atmel.com, michal.simek@xilinx.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, andrzej.p@samsung.com, leoli@freescale.com, robert.jarzmik@free.fr, daniel@zonque.org, linux-geode@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 7/14/2015 12:39 PM, Robert Baldyga wrote:

> Add 'match_ep' callback to utilize chip-specific knowledge in endpoint matching
> process. Functions does the same that was done by chip-specific code inside
> of epautoconf. Now this code can be removed from there to separate generic code
> from platform specific logic.

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

[...]
> diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
> index 0295cf7..4933321 100644
> --- a/drivers/usb/gadget/udc/net2280.c
> +++ b/drivers/usb/gadget/udc/net2280.c
> @@ -1533,6 +1533,49 @@ static int net2280_pullup(struct usb_gadget *_gadget, int is_on)
>   	return 0;
>   }
>
> +static struct usb_ep *net2280_find_ep(struct usb_gadget *_gadget,
> +		const char *name)

    Shouldn't this be a generic function as before?

> +{
> +	struct usb_ep *ep;
> +
> +	list_for_each_entry(ep, &_gadget->ep_list, ep_list) {
> +		if (0 == strcmp(ep->name, name))

    Please make 0 the 2nd operand to ==.

> +			return ep;
> +	}
> +
> +	return NULL;
> +}
[...]

WBR, Sergei
