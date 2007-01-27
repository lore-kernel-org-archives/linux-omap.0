From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warnings in musb_procfs.c
Date: Sat, 27 Jan 2007 07:40:14 +0100
Message-ID: <45BAF3CE.7090806@googlemail.com>
References: <45B1C052.4020809@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <45B1C052.4020809@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme wrote:
> ARM: OMAP: Fix warnings in musb_procfs.c:

What's about this one? Do I overlooked any comments?

It's the last one in my pending patches list ;)

Orginal post:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008903.html

> drivers/usb/musb/musb_procfs.c: In function 'musb_proc_write':
> drivers/usb/musb/musb_procfs.c:651: warning: ignoring return
> value of 'copy_from_user', declared with attribute
> warn_unused_result
> drivers/usb/musb/musb_procfs.c:725: warning: ignoring return
> value of 'copy_from_user', declared with attribute
> warn_unused_result
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 
> 
> ------------------------------------------------------------------------
> 
> Index: linux-osk/drivers/usb/musb/musb_procfs.c
> ===================================================================
> --- linux-osk.orig/drivers/usb/musb/musb_procfs.c
> +++ linux-osk/drivers/usb/musb/musb_procfs.c
> @@ -648,7 +648,8 @@ static int musb_proc_write(struct file *
>  
>  	/* MOD_INC_USE_COUNT; */
>  
> -	copy_from_user(&cmd, buffer, 1);
> +	if(unlikely(copy_from_user(&cmd, buffer, 1)))
> +		return -EFAULT;
>  	switch (cmd) {
>  	case 'C':
>  		if (pBase) {
> @@ -722,7 +723,10 @@ static int musb_proc_write(struct file *
>  				int i = 0, level = 0, sign = 1;
>  				int len = min(count - 1, (unsigned long)8);
>  
> -				copy_from_user(&digits, &buffer[1], len);
> +				if(unlikely(copy_from_user(&digits,
> +							   &buffer[1],
> +							   len)))
> +					return -EFAULT;
>  
>  				/* optional sign */
>  				if (*p == '-') {
> 
