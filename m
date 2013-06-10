From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
Date: Mon, 10 Jun 2013 10:03:23 +0200
Message-ID: <CAGGh5h0z3OPPL_jECb1NhENo2OaBqebdTC6r_ddhWKDuuB1Ykg@mail.gmail.com>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
	<alpine.DEB.2.02.1306051814520.10103@utopia.booyaka.com>
	<CAGGh5h1gBin0vWFf=SpB4eCQX69a2U+J6u2ccF_Oo_4R62+5fQ@mail.gmail.com>
	<alpine.DEB.2.02.1306061517430.5152@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:43189 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab3FJIDZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 04:03:25 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so4536776wes.20
        for <linux-omap@vger.kernel.org>; Mon, 10 Jun 2013 01:03:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1306061517430.5152@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@linaro.org>, Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Kevin Hilman <khilman@linaro.org>

2013/6/6 Paul Walmsley <paul@pwsan.com>:
> On Thu, 6 Jun 2013, jean-philippe francois wrote:
>
>> Does the first version [1] of the patch, that only touch the MSB of
>> the divider also trigger the
>> bug ?
>>
>> [1]  https://patchwork.kernel.org/patch/2609681/
>
> That one passes the PM test here.  Will take this one for v3.10-rc fi=
xes
> instead, since it fixes a known DSS problem and the original code was=
n't
> correct.
>
> Jean, could you work with Mike to come up with a better approach for
> v3.11 or v3.12?
>
Hi,

I am ok to work on it, however could you explain to me what is the
expected output of your PM tests, and how to reproduce them ?
The board I used to test the clock frequency was correct suffered from
heavy handed oscilloscope probing and is currently out of order :(

Jean-Philippe Fran=C3=A7ois.

>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
