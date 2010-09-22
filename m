From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4: clock: Fix missing optional clocks
Date: Wed, 22 Sep 2010 09:37:11 +0200
Message-ID: <4C99B227.6050301@ti.com>
References: <1285103430-5964-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1009220123540.21002@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41225 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab0IVHhO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 03:37:14 -0400
In-Reply-To: <alpine.DEB.2.00.1009220123540.21002@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 9/22/2010 9:25 AM, Paul Walmsley wrote:
> Hi Beno=EEt,
>
> On Tue, 21 Sep 2010, Benoit Cousson wrote:
>
>> Please note that the diff is pretty bad for the clock table. It look=
s like
>> everything has changed. I don't know if there is a way to have a bet=
ter diff
>> with git.
>
> It's due to an extra tab that somehow got added between the second an=
d
> third fields of the clkdev table in your patch.  I've removed that to
> reduce the diff noise in the updated patch (forthcoming in a few minu=
tes).

OK, it missed that, this is probably because of our super smart auto=20
aligned tab to the longest string script :-)

Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
