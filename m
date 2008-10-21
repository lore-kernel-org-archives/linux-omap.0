From: David Brownell <david-b@pacbell.net>
Subject: Re: PATCH 2/2 OMAP: HSMMC: Disable the mmc clocks when not needed
Date: Tue, 21 Oct 2008 10:42:19 -0700
Message-ID: <200810211042.19942.david-b@pacbell.net>
References: <20081021124306.GA11845@angel.research.nokia.com> <20081021124624.GA11859@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:20130 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752239AbYJURmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Oct 2008 13:42:22 -0400
In-Reply-To: <20081021124624.GA11859@angel.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

On Tuesday 21 October 2008, Jarkko Lavinen wrote:
>=20
> +=A0=A0=A0=A0=A0=A0=A0setup_timer(&host->clk_timer, omap_hsmmc_clk_ti=
mer,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0(unsigned long)=
 host);
> +

How about init_timer_deferrable()? =20

There should be a setup_timer_deferrable(), but unless you
want to add that yourself (and merge via LKML) you'll have
to set clk_timer->function and clk_timer->data "by hand".

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
