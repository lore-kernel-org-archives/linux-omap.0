From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 1/5] OMAP4: hwmod: Add names for DMIC memory address
 space
Date: Tue, 24 Jan 2012 12:01:42 +0200
Message-ID: <4F1E8186.2060307@ti.com>
References: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com> <1322487943-14280-2-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1112152327410.12660@utopia.booyaka.com> <4EEB5913.3090901@ti.com> <alpine.DEB.2.00.1112191451140.12660@utopia.booyaka.com> <4F1D4A03.3050700@ti.com> <alpine.DEB.2.00.1201240134421.29673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:42816 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755994Ab2AXKBs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:48 -0500
Received: by lagp5 with SMTP id p5so2810464lag.24
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 02:01:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201240134421.29673@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 01/24/2012 10:36 AM, Paul Walmsley wrote:
>> This patch seams to be missing from 3.3-rc1. The rest of the series =
is
>> there, but because of the missing patch audio does not probe on
>> 4430SDP/Blaze.
>> Can you queue this as a fix for Linus?
>=20
> Doh, not sure what happened here.  A brief triage question.  Did audi=
o=20
> probe correctly on 4430SDP/Blaze on 3.2?

Yes, it did.
I have added the DMIC support for 3.3. Without this patch the DMIC
driver is not probing (can't get the resources) which prevents the audi=
o
to work (the DMIC dai is missing, so the card does not come up).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
