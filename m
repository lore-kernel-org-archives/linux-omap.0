From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/8] OMAP: omap_device: deactivate latency typo
Date: Wed, 18 Nov 2009 06:39:02 -0800
Message-ID: <87ocmzew3d.fsf@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.0911180353210.25515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57386 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273AbZKROi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 09:38:58 -0500
Received: by pwi3 with SMTP id 3so721196pwi.21
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 06:39:04 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911180353210.25515@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 18 Nov 2009 03\:54\:10 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hello Kevin,
>
> On Tue, 17 Nov 2009, Kevin Hilman wrote:
>
>> The deactivate hook should use 'deactivate_lat' instead of
>> 'activate_lat' when doing checking on expected latency values.
>
> Why ?
>

Hmm, looking closer, I think misunderstood the use of 'activate_lat' in the
deactivate hook.

I'll drop this one.

Kevin
