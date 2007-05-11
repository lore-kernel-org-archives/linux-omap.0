From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH] TWL4030 Keypad driver - incorporated review comments
Date: Thu, 10 May 2007 20:00:35 -0500
Message-ID: <4643C033.3020209@gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47E26872@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47E26872@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Syed Mohammed, Khasim stated on 5/10/2007 7:19 PM:
> I feel like not doing this, fundamental reason is we don't have an open TRM for TWL4030, this code is new to community and I don't want to confuse developers more. This though takes some kind of space is easy to understand and comment on. I can definitely revisit once I see some kind of usage of TWL4030 driver in community and having a public TRM to explain the same. Also I am just targeting drivers to get into some respectable form in GIT then we can improve them for more functionality and 
>   
I can send a patch for the same if you'd like to save yourself the
effort ;).... but just hoping to save git some bytes.. and hoping to see
some readable(it did take me a short while{due to the dud head i am}
that _M is infact a mask) code instead :D ... hoping to see a *public*
TRM may not happen even for 2430 - it needs to be recieved thru FAEs..
folks can get the T2 TRMs thru FAEs if they so desire..
Here are some more 1 cent comments in arnd 15 mins of patch look through:
> +#define OMAP_TWL4030KP_LOG_LEVEL    1
why enable debug by default?
> +void omap_kp_timer(unsigned long data)
> +{
> +    schedule_work(&timer_work);
> +}
ofcourse possibly workitem schedule overheads.. versus userlevel thread
running and scheduling it..

> +#define SCAN_RATE        HZ/20
what if I change my HZ to say 1000? should I not have this as a
configurable option -> just thinking....

> +#if (OMAP_TWL4030KP_LOG_LEVEL >= 1)
> +char *switch_name[NUM_ROWS][NUM_COLS] = {
this could have been static

> +		for (col = 0; col < NUM_COLS; col++) {
> +			int key;
> +
> +			if (!(changed & (1 << col)))
> +				continue;
Cant we use changed and a while loop to iterate less instead of a continue?

+	omap_twl4030kp->id.vendor	= 0x0001;
+	omap_twl4030kp->id.product	= 0x0001;
+	omap_twl4030kp->id.version	= 0x0003;
what are those? is there some registration values?
+	if (ret < 0) goto err3;
coding standard? should not goto err3 go below the if()?
+	/* Set Pre Scalar Field PTV to 4 */
+	reg = BIT_LK_PTV_REG_PTV_M & (BIT_PTV_REG_PTV4 << BIT_LK_PTV_REG_PTV);
why if i already have a bunch of _M masks defined - I am confused on this :)?
+#if (OMAP_TWL4030KP_LOG_LEVEL >= 1)
+	printk
+	  ("****TWL4030 keypad module configuration registers dump****\n");
+	twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEYP_CTRL_REG);
+	printk("Register REG_KEYP_CTRL_REG : %X\n", reg);

arent we supposed to use that kernel debug printk?
>  /* Placeholder for 2430SDP specific defines */
> -#define OMAP24XX_ETHR_START		 0x08000300
> +#define OMAP24XX_ETHR_START		0x08000300
what is this change anyway?
> -#define NR_IRQS				(IH_TWL4030_END)
> +
> +/* TWL4030 GPIO Interrupts */
> +#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_END)
> +#define IH_TWL4030_GPIO_END		(IH_TWL4030_BASE+18)
> +#define NR_IRQS				(IH_TWL4030_GPIO_END)
>  
<snip>
> +
> +#define TWL4030_GPIO_MIN		0
> +#define TWL4030_GPIO_MAX		18
> +#define TWL4030_GPIO_MAX_CD		2
> +#define TWL4030_GPIO_IRQ_NO(n)		(IH_TWL4030_GPIO_BASE+n)
> +#define TWL4030_GPIO_IS_INPUT		1
> +#define TWL4030_GPIO_IS_OUTPUT		0
> +#define TWL4030_GPIO_IS_ENABLE		1

Should'nt this be a different patch - something like t2-gpio?

Regards,
Nishanth Menon
