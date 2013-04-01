From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC][PATCH 0/5] Introduce .get_voltage callback into voltdm
Date: Mon, 1 Apr 2013 14:56:30 -0700
Message-ID: <CAPtuhTgNQShFvfe+AyN-uFJuFL85V1ceT-udWqFMeUUbmjhqmw@mail.gmail.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1303310234110.6436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:48345 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758662Ab3DAV4v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 17:56:51 -0400
Received: by mail-we0-f181.google.com with SMTP id d7so2062142wer.12
        for <linux-omap@vger.kernel.org>; Mon, 01 Apr 2013 14:56:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303310234110.6436@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Mar 30, 2013 at 7:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Mike, Kevin,
>
> On Wed, 3 Oct 2012, Mike Turquette wrote:
>
>> From: Mike Turquette <mturquette@linaro.org>
>>
>> This series creates a new callback for struct voltagedomain,
>> .get_voltage.  This fetches the voltage from hardware, if possible, and
>> returns it to the caller.  We use this call to populate
>> voltdm->nominal_volt at boot time.
>
> Just checking on the status of this series.  Is this superseded by
> Andrii's driver?  Does it need to be reposted for merging?  etc.
>

Hi Paul,

Thanks for resurrecting this thread.  This series is needed if the ABB
transition is triggered by the OMAP VC/VP code.  Andrii's approach
triggers an ABB transition based on the clock rate-change notifiers
but that is still in discussion.

So the short answer is "I don't know yet".

Regards,
Mike

>
> - Paul
