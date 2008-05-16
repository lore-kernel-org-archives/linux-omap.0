From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] CF: Change omap_cf.c to use  omap_readw/writew instead of __REG for multi-omap
Date: Fri, 16 May 2008 14:26:17 -0700
Message-ID: <200805161426.18409.david-b@pacbell.net>
References: <1210972076-23911-1-git-send-email-tony@atomide.com> <1210972076-23911-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:44653 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754143AbYEPV0U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2008 17:26:20 -0400
In-Reply-To: <1210972076-23911-2-git-send-email-tony@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Friday 16 May 2008, Tony Lindgren wrote:
> @@ -38,19 +38,19 @@
> =A0#define=A0=A0=A0=A0=A0=A0=A0=A0CF_BASE=A00xfffe2800
> =A0
> =A0/* status; read after IRQ */
> -#define CF_STATUS_REG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__REG16(CF_BASE +=
 0x00)
> +#define CF_STATUS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0(CF_BASE + 0x00)
> =A0#=A0=A0=A0=A0=A0=A0define=A0=A0CF_STATUS_BAD_READ=A0=A0=A0=A0=A0=A0=
(1 << 2)
> =A0#=A0=A0=A0=A0=A0=A0define=A0=A0CF_STATUS_BAD_WRITE=A0=A0=A0=A0=A0(=
1 << 1)
> =A0#=A0=A0=A0=A0=A0=A0define=A0=A0CF_STATUS_CARD_DETECT=A0=A0=A0(1 <<=
 0)
> =A0
> =A0/* which chipselect (CS0..CS3) is used for CF (active low) */
> -#define CF_CFG_REG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__REG16(CF_=
BASE + 0x02)
> +#define CF_CFG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0(CF_BASE + 0x02)
> =A0
>	...

Trying to understand the plan here.  This first patches
are to remove __REG*() access, we hillater patches will=20
be needed to convert things to omap_readl(BASE + OFFSET)
style accessors?  (BASE being SOC-specific, and passed
down from system init code.)

Not that CF is a good example of that.  I don't think
it exists on current chips.  ;)

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
