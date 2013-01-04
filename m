From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4: clock data: ABE DPLL need to be locked
 on all revisions
Date: Fri, 4 Jan 2013 10:59:46 +0100
Message-ID: <50E6A812.40903@ti.com>
References: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com> <1357220811-29904-2-git-send-email-peter.ujfalusi@ti.com> <50E5D4EA.5030001@ti.com> <alpine.DEB.2.00.1301032325530.24404@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47661 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab3ADJ7v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 04:59:51 -0500
In-Reply-To: <alpine.DEB.2.00.1301032325530.24404@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On 01/04/2013 12:26 AM, Paul Walmsley wrote:
> On Thu, 3 Jan 2013, Jon Hunter wrote:
>=20
>> I am not sure that this change to the comment is completely accurate=
=2E On
>> OMAP4430 I did not see any issues with the DPLL failing to turn on i=
f
>> the DPLL was not locked. I only saw this particular problem on the 4=
460.
>> Therefore, it may be better to leave the comment as-is and add an
>> additional sentence to state that the DPLL should be locked for all
>> OMAP4 devices for audio to work correctly.
>=20
> Makes sense to me; what do you think, P=E9ter?

OK, I'll resend the series with the proposed comment.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
