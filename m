From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] video: omap2: dss: RET on idle, enable/disable dss clocks 	only when needed.
Date: Tue, 22 Sep 2009 07:54:20 -0700
Message-ID: <877hvrf2sj.fsf@deeprootsystems.com>
References: <1253230586-931-1-git-send-email-mike@android.com>
	<1253262472.28956.10.camel@tubuntu>
	<8bb80c380909181033s2fd5e3a1o16404f1667760b25@mail.gmail.com>
	<1253514408.4690.5.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:58267 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbZIVOyV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 10:54:21 -0400
Received: by qyk3 with SMTP id 3so2863831qyk.4
        for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 07:54:25 -0700 (PDT)
In-Reply-To: <1253514408.4690.5.camel@tubuntu> (Tomi Valkeinen's message of "Mon\, 21 Sep 2009 09\:26\:48 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: ext Mike Chan <mike@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:

> Hi,
>
> On Fri, 2009-09-18 at 19:33 +0200, ext Mike Chan wrote:
>> On Fri, Sep 18, 2009 at 1:27 AM, Tomi Valkeinen
>> <tomi.valkeinen@nokia.com> wrote:
>> > Hi,
>> >
>> > If you disable the clocks to allow RET, you also allow OFF mode. And
>> > resuming from OFF mode hasn't been implemented for DSI, if I recall
>> > right. And when I was testing it, it didn't seem to be trivial with the
>> > DSI PLL.
>> >
>> 
>> You can limiting the pwrdm next state to RET when being called from cpuidle.
>
> No, you _must_ limit it to RET. Otherwise the DSI will break down. So we
> can either keep the dsi code as it is now, or explicitely disable OFF
> mode and then apply your patch. But your patch alone won't work.

Or could add a hack to this patch so that 'enable_off_mode' doesn't
affect DSS_MOD until DSS has off-mode support.

> In the long run I think we anyway need to somehow dynamically manage the
> power state. I haven't measured it but I believe resuming from OFF will
> have a bit of a penalty, as (I think) DSI PLL etc. will have to
> reinitialized. But it would still be good to allow RET whenever
> possible, and OFF only after some period of inactivity.

This is the purpose of latency constraints.  These can be used when
the latency of going OFF will cause a problem.

Kevin
