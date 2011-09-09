From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 11/22] OMAP4: powerdomain data: add voltage domains
Date: Fri, 09 Sep 2011 14:48:54 -0700
Message-ID: <871uvptmih.fsf@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-12-git-send-email-khilman@ti.com>
	<CAORVsuVikEPsk=1v_Mcevsu1iyDDQzdHuuKbBJUMRGL5mrLpXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:51232 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751495Ab1IIVs5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 17:48:57 -0400
Received: by mail-gy0-f182.google.com with SMTP id 2so2380528gyf.13
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 14:48:56 -0700 (PDT)
In-Reply-To: <CAORVsuVikEPsk=1v_Mcevsu1iyDDQzdHuuKbBJUMRGL5mrLpXg@mail.gmail.com>
	(Jean Pihet's message of "Wed, 7 Sep 2011 11:04:26 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi,
>
> On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
>> From: Benoit Cousson <b-cousson@ti.com>
>>
>> Add voltage domain name to indicate which voltagedomain each
>> powerdomain is in.
>>
>> The fixed voltage domain like ldo_wakeup for emu and wkup power
>> domain is added too.
>>
>> Update the TI copyright date to 2011.
> This seems to not be part of this patch.

OK, dropping this part of the changelog.  The new stuff (voltagedomain data)
already has a 2011 copyright, and I'll just leave the powerdomain stuff
for now.

> Ok for the rest of it.

Thanks for the review.

Kevin
