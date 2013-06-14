From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
Date: Fri, 14 Jun 2013 07:01:09 -0700
Message-ID: <8738skaj16.fsf@linaro.org>
References: <1371118124-15910-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.02.1306140243380.5514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:64909 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab3FNOBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jun 2013 10:01:12 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so601365pbc.18
        for <linux-omap@vger.kernel.org>; Fri, 14 Jun 2013 07:01:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1306140243380.5514@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 14 Jun 2013 02:46:33 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> cc Kevin, Vaibhav
>
> On Thu, 13 Jun 2013, Rajendra Nayak wrote:
>
>> The powerdomain framework today expects to always have a voltagedomain
>> associated with a given powerdomain. We already have AM33xx which
>> has no Voltage Controller/Voltage Processor as part of PRCM.
>> There are more SoCs' to follow starting with AM437x and DRA7xx
>> which do not have VC/VP.
>> 
>> Instead of adding dummy voltage domain data files, make the powerdomain
>> framework aware of the fact that some SoCs' might not really have
>> scalable voltage domains.
>
> Fine with me in principle if AM335x doesn't support voltage scaling.  
> Vaibhav, if this is okay for you, please ack it.  
>
> Then, in terms of merging, probably Kevin would be the right person for 
> this since he's done much of the voltagedomain work.

Yeah, I'll take this series after the minor issues I commented on are
fixed, and Vaivhav ack's the AM33xx parts.

Kevin
