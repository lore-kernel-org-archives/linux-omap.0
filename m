From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] rtc: rtc-twl: make driver DT only
Date: Tue, 22 Nov 2016 23:33:00 +0100
Message-ID: <20161122223300.3mgdlvrkhwcasthe@piout.net>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-3-git-send-email-Nicolae_Rosia@mentor.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCKYNX7Y3IMBBJUP2PAQKGQEKVKET7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1478945246-32056-3-git-send-email-Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 12/11/2016 at 12:07:25 +0200, Nicolae Rosia wrote :
> @@ -625,15 +631,11 @@ static int twl_rtc_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(twl_rtc_pm_ops, twl_rtc_suspend, twl_rtc_resume);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id twl_rtc_of_match[] = {
>  	{.compatible = "ti,twl4030-rtc", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, twl_rtc_of_match);
> -#endif
> -
> -MODULE_ALIAS("platform:twl_rtc");
>  
>  static struct platform_driver twl4030rtc_driver = {
>  	.probe		= twl_rtc_probe,


You can then get rid of of_match_ptr()


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
