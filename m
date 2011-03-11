From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] can : AM3517EVM : add platform specific init
Date: Fri, 11 Mar 2011 15:19:43 +0300
Message-ID: <4D7A135F.5030004@ru.mvista.com>
References: <1299775153-16766-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299775153-16766-1-git-send-email-abhilash.kv@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Sriramakrishnan <srk@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello.

On 10-03-2011 19:39, Abhilash K V wrote:

> CAN module on AM3517 requires programming of IO expander
> as part of init sequence. Added transceiver_switch
> callback to handle this.

> Signed-off-by: Sriramakrishnan<srk@ti.com>
> Reviewed-by:  Vaibhav Hiremath<hvaibhav@ti.com>
> Signed-off-by: Abhilash K V<abhilash.kv@ti.com>
> ---
>   arch/arm/mach-omap2/board-am3517evm.c |   18 ++++++++++++++++++
>   1 files changed, 18 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
> index 2e4aad2..782d72d 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -734,6 +734,23 @@ static struct omap_board_mux board_mux[] __initdata = {
>   };
>   #endif
>
> +/*
> + * HECC information
> + */
> +
> +#define CAN_STB         214
> +static void hecc_phy_control(int on)
> +{
> +        int r;
> +
> +        r = gpio_request(CAN_STB, "can_stb");
> +        if (r) {
> +                printk(KERN_ERR "failed to get can_stb \n");

    Have you run the patch thru checkpatch.pl? IIRC, it warns about spaces 
before '\n'...

WBR, Sergei
