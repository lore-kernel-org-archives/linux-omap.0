From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register
 offset using the IP scheme.
Date: Mon, 9 Jul 2012 16:12:15 +0530
Message-ID: <CAMQu2gz0UU_RCFSvxo1s_XwDAmTtL4NadsFTg8qL7PtGwPqKtQ@mail.gmail.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com> <4FFA9B6C.7050003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53095 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752915Ab2GIKmh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 06:42:37 -0400
Received: by qcad10 with SMTP id d10so5684464qca.20
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 03:42:35 -0700 (PDT)
In-Reply-To: <4FFA9B6C.7050003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

On Mon, Jul 9, 2012 at 2:20 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
>
>
> On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> OMAP socs has a legacy and a highlander version of the
>> 32k sync counter IP. The register offsets vary between the
>> highlander and the legacy scheme. So use the 'SCHEME'
>> bits(30-31) of the revision register to distinguish between
>
>
> Just for my understanding, can we get further information on SCHEME
> bit-fields? What kind of information we have it here.
>
> I may need this info to pass on to design team here.
>
Sure. You can refer to the OMAP4 TRM for the bit builds.
SCHEME bit field tell you difference between a highlander
and legacy IP as the patch says.

Regards
santosh
