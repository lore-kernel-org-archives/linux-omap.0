From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP AM33XX: clock data: Enable clkout2 output
 on SoC pad
Date: Mon, 27 May 2013 14:27:15 +0200
Message-ID: <51A35123.6040600@ti.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com> <79CD15C6BA57404B839C016229A409A83EC8C081@DBDE04.ent.ti.com> <alpine.DEB.2.00.1305200246080.2656@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58985 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143Ab3E0M1o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 08:27:44 -0400
In-Reply-To: <alpine.DEB.2.00.1305200246080.2656@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Salut Paul,

On 05/20/2013 04:47 AM, Paul Walmsley wrote:
> On Fri, 17 May 2013, Hiremath, Vaibhav wrote:
>=20
>> Tony, Paul and Benoit,
>>
>> Any update on this series?
>=20
> Most of the changes are DT-related, so it should probably go in via=20
> Beno=EEt.  I'll ack the clock side, but have a comment on patch 2, to=
 be=20
> sent shortly.

I've tried to apply that patch, but unfortunately, it does depend on
that one:

https://patchwork.kernel.org/patch/2212081/

If you did not already pulled the first one I can take both with your
acked-by.
Otherwise, I can take only the DTS ones.

Is that OK?

Thanks,
Benoit


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
