From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Fix build for beagleboard
Date: Fri, 12 Sep 2008 15:06:25 +0300
Message-ID: <20080912120625.GF759@gandalf.research.nokia.com>
References: <20080911181549.GK21163@atomide.com> <1221215556-5100-1-git-send-email-peter.de-schrijver@nokia.com> <1221215556-5100-2-git-send-email-peter.de-schrijver@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48449 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbYILMGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 08:06:48 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8CC6dir026801
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 15:06:45 +0300
Content-Disposition: inline
In-Reply-To: <1221215556-5100-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

please amend the following into this patch:

On Fri, Sep 12, 2008 at 01:32:36PM +0300, Peter 'p2' De Schrijver wrote:
> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-power.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
> index 195c3c4..04a13aa 100644
> --- a/drivers/i2c/chips/twl4030-power.c
> +++ b/drivers/i2c/chips/twl4030-power.c
> @@ -149,7 +149,7 @@ struct triton_ins t2_wrst_seq[] __initdata = {
>  struct triton_ins sleep_on_seq[] __initdata = {
>  	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
>  			RES_STATE_SLEEP), 4},
> -	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE_R7,
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
>  			RES_STATE_SLEEP), 4},
>  };
>  
> @@ -160,6 +160,9 @@ struct triton_ins sleep_off_seq[] __initdata = {
>  	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
>  			RES_STATE_ACTIVE), 0x2},
>  };
> +
> +struct triton_ins t2_wrst_seq[] __initdata = { };
> +
>  #endif
>  
>  static int __init twl4030_write_script_byte(u8 address, u8 byte)

diff -u b/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
--- b/drivers/i2c/chips/twl4030-power.c
+++ b/drivers/i2c/chips/twl4030-power.c
@@ -215,7 +215,6 @@
 static int __init config_sleep_wake_sequence(void)
 {
 	int err = 0;
-	u8 data;
 
 	/*
 	 * CLKREQ is pulled high on the 2430SDP, therefore, we need to take


-- 
balbi
