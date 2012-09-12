From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] CPUFreq: OMAP: remove unnecessary plat/ includes
Date: Wed, 12 Sep 2012 06:57:41 -0700
Message-ID: <87bohbxs16.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1209120030420.9444@utopia.booyaka.com>
	<CAMQu2gz4mcxqq=EFJzseXcgS_XxzDWGTP1sC5-FbkbxszUiwcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48270 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010Ab2ILN5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 09:57:43 -0400
Received: by obbuo13 with SMTP id uo13so2641428obb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 06:57:43 -0700 (PDT)
In-Reply-To: <CAMQu2gz4mcxqq=EFJzseXcgS_XxzDWGTP1sC5-FbkbxszUiwcw@mail.gmail.com>
	(Santosh Shilimkar's message of "Wed, 12 Sep 2012 12:58:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, rjw@sisk.pl, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Wed, Sep 12, 2012 at 6:02 AM, Paul Walmsley <paul@pwsan.com> wrote:
>>
>> Remove some unnecessary plat/ includes that are interfering with multi-subarch
>> ARM kernels.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>> Acked-by: Kevin Hilman <khilman@ti.com>
>> ---
>>
>> Still awaiting some final testing here.  Rafael, was wondering if you
>> would be willing to ack this so we can merge it via the OMAP tree?
>> Otherwise the patch can be split into an OMAP part and a CPUFreq part that
>> can go in across two merge windows.
>>
> Hmm.
> I did similar change[1] a while back. Kevin didn't like idea though
> that point of time.

I was wrong.

At the time, we were thinking about how to get rid of clkdev nodes
instead of add more.  Now, we need to clean up these drivers and this is
the only way to do it, so I retract my objection.

Kevin
