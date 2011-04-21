From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
Date: Thu, 21 Apr 2011 18:57:48 +0530
Message-ID: <BANLkTingvxCL5NsQW0L_4zrSsKbmNiGo0A@mail.gmail.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<4DAEFEDD.1040106@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50011 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752179Ab1DUN1u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 09:27:50 -0400
Received: by mail-bw0-f53.google.com with SMTP id 12so2018926bwg.40
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 06:27:48 -0700 (PDT)
In-Reply-To: <4DAEFEDD.1040106@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Wamsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Apr 20, 2011 at 9:12 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
> On 20-04-2011 13:25, Shweta Gulati wrote:
>
>> From: Gulati, Shweta<shweta.gulati@ti.com>
>
>> Core Clk Tree shows incorrect Clk rates at OPP50, as
>> in commit e07f469d284ca3d1f5dcf5438c22982be98bc071
>
> =A0 Please also specify that commit's summary -- for human readers.
Will do.
>> calling of 'recalc' in API clk_set_rate is unintentionally
>> removed, because of which clock's tree rates get goofed
>> up when DVFS happens. This Patch adds recalc API back.
>
>> Tested on OMAP3630 SDP Board.
>
>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>> Cc: Rajendra Nayak<rnayak@ti.com>
>> Cc: Paul Wamsley<paul@pwsan.com>
>
> WBR, Sergei
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
