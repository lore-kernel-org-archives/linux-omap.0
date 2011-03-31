From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 0/5] OMAP: l3: fixes and cleanup
Date: Thu, 31 Mar 2011 17:05:17 -0500
Message-ID: <AANLkTimYohT0Dcod=s4TSkcN-Rfo-czVQf_uDQSoReqY@mail.gmail.com>
References: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
	<4D92D186.1070302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51317 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759332Ab1CaWFU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 18:05:20 -0400
Received: by mail-wy0-f172.google.com with SMTP id 29so2405695wyb.3
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 15:05:18 -0700 (PDT)
In-Reply-To: <4D92D186.1070302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

On Wed, Mar 30, 2011 at 1:45 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> =A0 OMAP3: l3: fix for "irq 10: nobody cared" message
>> =A0 OMAP3: l3: fix omap3_l3_probe error path
>> =A0 OMAP3: l3: minor cleanup for error message, parenthesis and extr=
a
>> =A0 =A0 lines
>> =A0 OMAP4: l3: fix omap4_l3_probe error path
>> =A0 OMAP4: l3: minor cleanup for parenthesis and extra spaces
>>
> Thanks for the cleanup. I have reviewed the series and it looks
> good to me.
> I would suggest to fold similar changes like,
> - PATCH 2/5 and PATCH 4/5 into one patch
> - PATCH 3/5 and PATCH 5/5 into one patch
>
> With this update you can add my ack for this series

Ok, will do, thanks for the comments.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
