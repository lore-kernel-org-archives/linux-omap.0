From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Thu, 14 Jun 2012 15:08:10 +0800
Message-ID: <4FD98DDA.9050806@windriver.com>
References: <zumeng.chen@gmail.com>
 <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
 <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com>
 <4FD96CBF.5040106@windriver.com> <4FD98856.8070601@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1319015545415769694=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FD98856.8070601@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Zumeng Chen <zumeng.chen@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "Hiremath,
 Vaibhav" <hvaibhav@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, mike@compulab.co.il, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============1319015545415769694==
Content-Type: multipart/alternative;
	boundary="------------060202040300070302050202"

--------------060202040300070302050202
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

于 2012年06月14日 14:44, Igor Grinberg 写道:
> On 06/14/12 07:46, Zumeng Chen wrote:
>> >  于 2012年06月13日 20:18, Hiremath, Vaibhav 写道:
>>> >>  On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
>>>> >>>  From: Zumeng Chen<zumeng.chen@windriver.com>
>>>> >>>
>>>> >>>  If we don't set proper debouce time for ads7846, then there are
>>>> >>>  flooded interrupt counters of ads7846 responding to one time
>>>> >>>  touch on screen, so the driver couldn't work well.
>>>> >>>
>>>> >>>  And since most OMAP3 series boards pass NULL pointer of board_pdata
>>>> >>>  to omap_ads7846_init, so it's more proper to set it in driver level
>>>> >>>  after having gpio_request done.
>>>> >>>
>>>> >>>  This patch has been validated on 3530evm.
>>>> >>>
>>>> >>>  Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>>>> >>>  Signed-off-by: Syed Mohammed Khasim<khasim@ti.com>
>>>> >>>  ---
>>>> >>>     drivers/input/touchscreen/ads7846.c |    4 ++++
>>>> >>>     1 files changed, 4 insertions(+), 0 deletions(-)
>>>> >>>
>>>> >>>  diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>>>> >>>  index f02028e..459ff29 100644
>>>> >>>  --- a/drivers/input/touchscreen/ads7846.c
>>>> >>>  +++ b/drivers/input/touchscreen/ads7846.c
>>>> >>>  @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>>>> >>>             }
>>>> >>>
>>>> >>>             ts->gpio_pendown = pdata->gpio_pendown;
>>>> >>>  +#ifdef CONFIG_ARCH_OMAP3
>>>> >>>  +        /* 310 means about 10 microsecond for omap3 */
>>>> >>>  +        gpio_set_debounce(pdata->gpio_pendown, 310);
>>>> >>>  +#endif
>>>> >>>
>>> >>  Zumeng,
>>> >>
>>> >>  With my sign-off you are changing the original code, that too
>>> >>  without my sign-off and ack.
>>> >>  I wouldn't mind you to submit patches from my tree, but the expectation is
>>> >>  if you are changing the original code, it should be under your sign-off.
>> >  Thanks, good to learn. I'll remove in next time.
>>> >>  Coming to the patch, #ifdef in driver is not recommended, and this 10msec
>>> >>  delay is specific to OMAP GPIO and driver should not be aware of this,
>>> >>  that's where you will find the original patch handling it in board file.
>> >  According to the git blame of the board-omap3evm.c I think
>> >  96974a24 did a good thing to all the related codes for omap3
>> >  boards. So I think we can call board and driver as BSP level:-)
>> >  
>> >  If #ifdef in driver can save many codes, I guess it's deserved.
> No, platform/board specific ifdefs in the generic driver code are never
> deserved.
> How about the attached patch, does it fix the problem for you?
Sorry Igor, I just read your patch, yes, most are there, and we
just have to set get_pendown_state as you early said. Really
*thanks* for your drive :)

Regards,
Zumeng
> -- Regards, Igor.
> ads7846.patch
>
>
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> index 1706ebc..c187586 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -63,28 +63,30 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>   	struct spi_board_info *spi_bi =&ads7846_spi_board_info;
>   	int err;
>
> -	if (board_pdata&&  board_pdata->get_pendown_state) {
> -		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
> -		if (err) {
> -			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
> -			return;
> -		}
> -		gpio_export(gpio_pendown, 0);
> -
> -		if (gpio_debounce)
> -			gpio_set_debounce(gpio_pendown, gpio_debounce);
> +	err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
> +	if (err) {
> +		pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
> +		return;
>   	}
>   	
> +	if (gpio_debounce)
> +		gpio_set_debounce(gpio_pendown, gpio_debounce);
> +
>   	spi_bi->bus_num	= bus_num;
>   	spi_bi->irq	= gpio_to_irq(gpio_pendown);
>
>   	if (board_pdata) {
>   		board_pdata->gpio_pendown = gpio_pendown;
>   		spi_bi->platform_data = board_pdata;
> +		if (board_pdata->get_pendown_state)
> +			gpio_export(gpio_pendown, 0);
>   	} else {
>   		ads7846_config.gpio_pendown = gpio_pendown;
>   	}
>
> +	if (!board_pdata || (board_pdata&&  !board_pdata->get_pendown_state))
> +		gpio_free(gpio_pendown);
> +
>   	spi_register_board_info(&ads7846_spi_board_info, 1);
>   }
>   #else


--------------060202040300070302050202
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    于 2012年06月14日 14:44, Igor Grinberg 写道:
    <blockquote cite="mid:4FD98856.8070601@compulab.co.il" type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">On 06/14/12 07:46, Zumeng Chen wrote:
</pre>
        <blockquote type="cite" style="color: rgb(0, 0, 0);">
          <pre wrap=""><span class="moz-txt-citetags">&gt; </span>于 2012年06月13日 20:18, Hiremath, Vaibhav 写道:
</pre>
          <blockquote type="cite" style="color: rgb(0, 0, 0);">
            <pre wrap=""><span class="moz-txt-citetags">&gt;&gt; </span>On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
</pre>
            <blockquote type="cite" style="color: rgb(0, 0, 0);">
              <pre wrap=""><span class="moz-txt-citetags">&gt;&gt;&gt; </span>From: Zumeng Chen<a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:zumeng.chen@windriver.com">&lt;zumeng.chen@windriver.com&gt;</a>
<span class="moz-txt-citetags">&gt;&gt;&gt;</span>
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>If we don't set proper debouce time for ads7846, then there are
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>flooded interrupt counters of ads7846 responding to one time
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>touch on screen, so the driver couldn't work well.
<span class="moz-txt-citetags">&gt;&gt;&gt;</span>
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>And since most OMAP3 series boards pass NULL pointer of board_pdata
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>to omap_ads7846_init, so it's more proper to set it in driver level
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>after having gpio_request done.
<span class="moz-txt-citetags">&gt;&gt;&gt;</span>
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>This patch has been validated on 3530evm.
<span class="moz-txt-citetags">&gt;&gt;&gt;</span>
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>Signed-off-by: Zumeng Chen<a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:zumeng.chen@windriver.com">&lt;zumeng.chen@windriver.com&gt;</a>
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>Signed-off-by: Syed Mohammed Khasim<a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:khasim@ti.com">&lt;khasim@ti.com&gt;</a>
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>---
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>  drivers/input/touchscreen/ads7846.c |    4 ++++
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>  1 files changed, 4 insertions(+), 0 deletions(-)
<span class="moz-txt-citetags">&gt;&gt;&gt;</span>
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>index f02028e..459ff29 100644
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>--- a/drivers/input/touchscreen/ads7846.c
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>+++ b/drivers/input/touchscreen/ads7846.c
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>@@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>          }
<span class="moz-txt-citetags">&gt;&gt;&gt;</span>
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>          ts-&gt;gpio_pendown = pdata-&gt;gpio_pendown;
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>+#ifdef CONFIG_ARCH_OMAP3
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>+        /* 310 means about 10 microsecond for omap3 */
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>+        gpio_set_debounce(pdata-&gt;gpio_pendown, 310);
<span class="moz-txt-citetags">&gt;&gt;&gt; </span>+#endif
<span class="moz-txt-citetags">&gt;&gt;&gt;</span>
</pre>
            </blockquote>
            <pre wrap=""><span class="moz-txt-citetags">&gt;&gt; </span>Zumeng,
<span class="moz-txt-citetags">&gt;&gt;</span>
<span class="moz-txt-citetags">&gt;&gt; </span>With my sign-off you are changing the original code, that too
<span class="moz-txt-citetags">&gt;&gt; </span>without my sign-off and ack.
<span class="moz-txt-citetags">&gt;&gt; </span>I wouldn't mind you to submit patches from my tree, but the expectation is
<span class="moz-txt-citetags">&gt;&gt; </span>if you are changing the original code, it should be under your sign-off.
</pre>
          </blockquote>
          <pre wrap=""><span class="moz-txt-citetags">&gt; </span>Thanks, good to learn. I'll remove in next time.
</pre>
          <blockquote type="cite" style="color: rgb(0, 0, 0);">
            <pre wrap=""><span class="moz-txt-citetags">&gt;&gt; </span>Coming to the patch, #ifdef in driver is not recommended, and this 10msec
<span class="moz-txt-citetags">&gt;&gt; </span>delay is specific to OMAP GPIO and driver should not be aware of this,
<span class="moz-txt-citetags">&gt;&gt; </span>that's where you will find the original patch handling it in board file.
</pre>
          </blockquote>
          <pre wrap=""><span class="moz-txt-citetags">&gt; </span>According to the git blame of the board-omap3evm.c I think
<span class="moz-txt-citetags">&gt; </span>96974a24 did a good thing to all the related codes for omap3
<span class="moz-txt-citetags">&gt; </span>boards. So I think we can call board and driver as BSP level <span class="moz-smiley-s1" title=":-)"><span>:-)</span></span>
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>If #ifdef in driver can save many codes, I guess it's deserved.
</pre>
        </blockquote>
        <pre wrap="">No, platform/board specific ifdefs in the generic driver code are never
deserved.
How about the attached patch, does it fix the problem for you?
</pre>
      </div>
    </blockquote>
    Sorry Igor, I just read your patch, yes, most are there, and we<br>
    just have to set get_pendown_state as you early said. Really<br>
    *thanks* for your drive :)<br>
    <br>
    Regards,<br>
    Zumeng<br>
    <blockquote cite="mid:4FD98856.8070601@compulab.co.il" type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">
<div class="moz-txt-sig">-- 
Regards,
Igor.
</div></pre>
      </div>
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 16px;" lang="zh-CN">
        <pre wrap="">
<fieldset class="mimeAttachmentHeader"><legend class="mimeAttachmentName">ads7846.patch</legend></fieldset>
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 1706ebc..c187586 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -63,28 +63,30 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 	struct spi_board_info *spi_bi = &amp;ads7846_spi_board_info;
 	int err;
 
-	if (board_pdata &amp;&amp; board_pdata-&gt;get_pendown_state) {
-		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
-		if (err) {
-			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
-			return;
-		}
-		gpio_export(gpio_pendown, 0);
-
-		if (gpio_debounce)
-			gpio_set_debounce(gpio_pendown, gpio_debounce);
+	err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
+	if (err) {
+		pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
+		return;
 	}
 	
+	if (gpio_debounce)
+		gpio_set_debounce(gpio_pendown, gpio_debounce);
+
 	spi_bi-&gt;bus_num	= bus_num;
 	spi_bi-&gt;irq	= gpio_to_irq(gpio_pendown);
 
 	if (board_pdata) {
 		board_pdata-&gt;gpio_pendown = gpio_pendown;
 		spi_bi-&gt;platform_data = board_pdata;
+		if (board_pdata-&gt;get_pendown_state)
+			gpio_export(gpio_pendown, 0);
 	} else {
 		ads7846_config.gpio_pendown = gpio_pendown;
 	}
 
+	if (!board_pdata || (board_pdata &amp;&amp; !board_pdata-&gt;get_pendown_state))
+		gpio_free(gpio_pendown);
+
 	spi_register_board_info(&amp;ads7846_spi_board_info, 1);
 }
 #else
</pre>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------060202040300070302050202--


--===============1319015545415769694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1319015545415769694==--
