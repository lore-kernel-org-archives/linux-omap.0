From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Check in set_pwrdm_state that target state is supported by pwrdm v2
Date: Tue, 18 Nov 2008 15:55:46 -0800
Message-ID: <871vx8h9ml.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.0811142026040.16502@utopia.booyaka.com>
	<1226909881-12415-1-git-send-email-jouni.hogander@nokia.com>
	<alpine.DEB.2.00.0811181126460.21683@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:57046 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbYKRXzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 18:55:52 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1353648ywe.1
        for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 15:55:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0811181126460.21683@utopia.booyaka.com> (Paul Walmsley's message of "Tue\, 18 Nov 2008 11\:27\:00 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Mon, 17 Nov 2008, Jouni Hogander wrote:
>
>> Check that wanted sleep state is supported by powerdomain. If it is
>> not supported, then use next lowest supported state.
>> 
>> Check also on suspend that state of pwrdm was lower or equal.
>> 
>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>



