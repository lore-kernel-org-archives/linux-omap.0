From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/7] Add defines and data types for twl4030.
Date: Sat, 11 Oct 2008 21:46:48 +0300
Message-ID: <20081011184648.GB20247@frodo>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-2-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-3-git-send-email-peter.de-schrijver@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33087 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758535AbYJKSq5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Oct 2008 14:46:57 -0400
Content-Disposition: inline
In-Reply-To: <1223657776-16544-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 10, 2008 at 07:56:11PM +0300, Peter 'p2' De Schrijver wrote:
> This patch adds a bunch of data types and defines to handle the twl4030 power sequence scripts.
> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Should Cc Sam Ortiz

> ---
>  include/linux/i2c/twl4030.h |   64 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 64 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
> index cdb4531..7dc4ee1 100644
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -264,6 +264,69 @@ struct twl4030_usb_data {
>  	enum twl4030_usb_mode	usb_mode;
>  };
>  
> +struct twl4030_ins {
> +	u16 pmb_message;
> +	u8 delay;
> +};
> +
> +struct twl4030_script {
> +	struct twl4030_ins *script;
> +	unsigned size;
> +	u8 flags;
> +};

add a blank like here

> +#define TRITON_WRST_SCRIPT	(1<<0)
> +#define TRITON_WAKEUP12_SCRIPT	(1<<1)
> +#define TRITON_WAKEUP3_SCRIPT	(1<<2)
> +#define TRITON_SLEEP_SCRIPT	(1<<3)
> +
> +struct twl4030_power_data {
> +	struct twl4030_script **scripts;
> +	unsigned size;
> +};
> +
> +/* Power bus message definitions */
> +
> +#define DEV_GRP_NULL		0x0
> +#define DEV_GRP_P1		0x1
> +#define DEV_GRP_P2		0x2
> +#define DEV_GRP_P3		0x4
> +
> +#define RES_GRP_RES		0x0
> +#define RES_GRP_PP		0x1
> +#define RES_GRP_RC		0x2
> +#define RES_GRP_PP_RC		0x3
> +#define RES_GRP_PR		0x4
> +#define RES_GRP_PP_PR		0x5
> +#define RES_GRP_RC_PR		0x6
> +#define RES_GRP_ALL		0x7
> +
> +#define RES_TYPE2_R0		0x0
> +
> +#define RES_TYPE_ALL		0x7
> +
> +#define RES_STATE_WRST		0xF
> +#define RES_STATE_ACTIVE	0xE
> +#define RES_STATE_SLEEP		0x8
> +#define RES_STATE_OFF		0x0
> +
> +/*
> +*	Power Bus Message Format
> +*
> +*	Broadcast Message (16 Bits)
> +*	DEV_GRP[15:13] MT[12]  RES_GRP[11:9]  RES_TYPE2[8:7] RES_TYPE[6:4]
> +*	RES_STATE[3:0]
> +*
> +*	Singular Message (16 Bits)
> +*	DEV_GRP[15:13] MT[12]  RES_ID[11:4]  RES_STATE[3:0]
> +*
> +*/

I'd fix this comment style. The * should be aligned with the first one.

> +
> +#define MSG_BROADCAST(devgrp, grp, type, type2, state) \
> +	(devgrp << 13 | 1 << 12 | grp << 9 | type2 << 7 | type << 4 | state)
> +
> +#define MSG_SINGULAR(devgrp, id, state) \
> +	(devgrp << 13 | 0 << 12 | id << 4 | state)
> +
>  struct twl4030_platform_data {
>  	unsigned				irq_base, irq_end;
>  	struct twl4030_bci_platform_data	*bci;
> @@ -271,6 +334,7 @@ struct twl4030_platform_data {
>  	struct twl4030_madc_platform_data	*madc;
>  	struct twl4030_keypad_data		*keypad;
>  	struct twl4030_usb_data			*usb;
> +	struct twl4030_power_data		*power;
>  
>  	/* REVISIT more to come ... _nothing_ should be hard-wired */
>  };

-- 
balbi
