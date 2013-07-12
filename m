From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
Date: Fri, 12 Jul 2013 10:59:41 +0200
Message-ID: <51DFC57D.2020905@ti.com>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com> <20130711145916.GA6138@kahuna> <51DED333.9080609@ti.com> <20130711163503.GA6611@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757399Ab3GLJAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 05:00:08 -0400
In-Reply-To: <20130711163503.GA6611@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/11/2013 06:35 PM, Nishanth Menon wrote:
> right - now that we removed the set_voltage/get_voltage custom code,
> there are no longer any way the code introduced in the commit can be
> exercised.

If we boot with DT (which is the case with OMAP4/5) this part was not e=
ven
executed, so the custom callbacks were not added from here for OMAP4. I=
 might
be wrong here...

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
