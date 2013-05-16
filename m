From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM : omap : remove __init for _enable_preprogram
Date: Thu, 16 May 2013 11:15:36 -0700
Message-ID: <20130516181536.GI5600@atomide.com>
References: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
 <8738tpxwmj.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49894 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab3EPSPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 14:15:41 -0400
Content-Disposition: inline
In-Reply-To: <8738tpxwmj.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: jp.francois@cynove.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, paul@pwsan.com

* Kevin Hilman <khilman@linaro.org> [130514 11:13]:
> jp.francois@cynove.com writes:
>=20
> > _enable_preprogram is marked as __init, but is called from _enable =
which is not.
> > This results in oops once init is freed.
> > Fix this by removing the __init marker.
> >
> > Signed-off-by: Jean-Philippe Fran=C3=A7ois <jp.francois@cynove.com>
>=20
> Acked-by: Kevin Hilman <khilman@linaro.org>
>=20
> Tony, this should probably be queued for v3.10-rc, and tagged for sta=
ble.

Yes just applied the earlier version of this and added your
ack with cc: stable.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
