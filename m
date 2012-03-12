From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
Date: Mon, 12 Mar 2012 11:53:15 +0200
Message-ID: <4F5DC78B.2060203@ti.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com> <4F5A258F.8050704@ti.com> <20120309180027.GF12083@atomide.com> <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com> <alpine.DEB.2.00.1203091103450.7039@utopia.booyaka.com> <alpine.DEB.2.00.1203092355280.27395@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57453 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781Ab2CLJxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 05:53:22 -0400
Received: by lahj13 with SMTP id j13so3409924lah.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 02:53:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203092355280.27395@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hello Paul,

On 03/10/2012 09:08 AM, Paul Walmsley wrote:
>=20
> Hello P=E9ter
>=20
> could you please try this patch instead of the clkdev change?
>=20
> It is based on my 'hwmod_enable_remaining_hwmods_devel_3.4' branch, b=
ut=20
> the basic idea should work on v3.3-rc6 as well.
>=20
> If it works for you, please let us know and we can queue this up alon=
g=20
> with the hwmod data changes.  Probably we should replace the changelo=
g=20
> also with the one from your patch, it might be a little more useful? =
=20
> Suggestions welcome.

Unfortunately I can not test the McBSP on OMAP4 at the moment. The patc=
h
looks good, and as far as I can see it will be perfect for OMAP4.
Thank you.
In case you need:

> From: Paul Walmsley <paul@pwsan.com>
> Date: Fri, 9 Mar 2012 23:28:28 -0700
> Subject: [PATCH] ARM: OMAP4: hwmod data: add McBSP parent clock alias=
es
>=20
> Add optional parent clocks for the OMAP4 McBSP modules so the driver
> can switch between parent clocks.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
