From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK position
Date: Wed, 09 Dec 2009 15:36:17 -0800
Message-ID: <87pr6nsosu.fsf@deeprootsystems.com>
References: <1259234087-10030-1-git-send-email-thara@ti.com>
	<alpine.DEB.2.00.0912030538260.13408@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:39655 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758637AbZLIXgP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 18:36:15 -0500
Received: by ywh36 with SMTP id 36so7157997ywh.15
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 15:36:21 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912030538260.13408@utopia.booyaka.com> (Paul Walmsley's message of "Thu\, 3 Dec 2009 05\:38\:38 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Thu, 26 Nov 2009, Thara Gopinath wrote:
>
>> MPU power domain bank 0 bits are displayed in position of bank 1
>> in PWRSTS and PREPWRSTS registers. So read them from correct
>> position
>> 
>> Signed-off-by: Thara Gopinath <thara@ti.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

> Thanks Thara, will queue this up.

Kevin
