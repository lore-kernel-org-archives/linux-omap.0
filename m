From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] OMAP3: CLOCK: Remove few unnecessary clocks
Date: Tue, 24 Feb 2009 09:21:00 -0800
Message-ID: <87vdqzu4xv.fsf@deeprootsystems.com>
References: <1235130767-18488-1-git-send-email-jouni.hogander@nokia.com>
	<alpine.DEB.2.00.0902240137320.32378@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:14598 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374AbZBXRVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 12:21:09 -0500
Received: by rv-out-0506.google.com with SMTP id g9so2575548rvb.5
        for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 09:21:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0902240137320.32378@utopia.booyaka.com> (Paul Walmsley's message of "Tue\, 24 Feb 2009 01\:37\:51 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org, Carlos.Chinea@nokia.com

Paul Walmsley <paul@pwsan.com> writes:

> On Fri, 20 Feb 2009, Jouni Hogander wrote:
>
>> dpllx_m2x2_ck parent is dpllx_m2_ck. So remove few useless clocks and
>> and use right parent for dpllx_m2x2_ck.
>> 
>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>

Pulling into PM branch while waiting for upstream clock sync up.

Kevin

