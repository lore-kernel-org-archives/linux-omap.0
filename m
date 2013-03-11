From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/8] memory: emif: Correct the lpmode timeout calculation
Date: Mon, 11 Mar 2013 11:04:02 +0530
Message-ID: <513D6CCA.4000906@ti.com>
References: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com> <1362978365-5593-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362978365-5593-2-git-send-email-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

minor nit.
$subject
s/Correct/Fix

On Monday 11 March 2013 10:35 AM, Lokesh Vutla wrote:
> The driver tries to round up the specified timeout cycles to
> the next power of 2 value. But this is done wrongly.
> Correcting this here.
>
Change needs to be improved here. See below.
 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/memory/emif.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
> index df08736..622638c 100644
> --- a/drivers/memory/emif.c
> +++ b/drivers/memory/emif.c
> @@ -732,9 +732,9 @@ static u32 get_pwr_mgmt_ctrl(u32 freq, struct emif_data *emif, u32 ip_rev)
>  	if (timeout < 16) {
>  		timeout = 0;
>  	} else {
> -		timeout = __fls(timeout) - 3;
>  		if (timeout & (timeout - 1))
So from the change, it appears that, the timeout
check for power of 2 should be done before updating
the variable which seems to be the right fix.

> -			timeout++;
> +			timeout <<= 1;
> +		timeout = __fls(timeout) - 3;
>  	}
>  
>  	switch (lpmode) {
> 
So just make changelog verbose as well as add a
comment about the calculation in the code.

Otherwise, patch looks fine to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
