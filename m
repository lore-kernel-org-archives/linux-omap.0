From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] video: omap2: dss: RET on idle, enable/disable dss
 clocks 	only when needed.
Date: Mon, 21 Sep 2009 09:26:48 +0300
Message-ID: <1253514408.4690.5.camel@tubuntu>
References: <1253230586-931-1-git-send-email-mike@android.com>
	 <1253262472.28956.10.camel@tubuntu>
	 <8bb80c380909181033s2fd5e3a1o16404f1667760b25@mail.gmail.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23426 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbZIUG06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 02:26:58 -0400
In-Reply-To: <8bb80c380909181033s2fd5e3a1o16404f1667760b25@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Chan <mike@android.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, 2009-09-18 at 19:33 +0200, ext Mike Chan wrote:
> On Fri, Sep 18, 2009 at 1:27 AM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
> > Hi,
> >
> > If you disable the clocks to allow RET, you also allow OFF mode. And
> > resuming from OFF mode hasn't been implemented for DSI, if I recall
> > right. And when I was testing it, it didn't seem to be trivial with the
> > DSI PLL.
> >
> 
> You can limiting the pwrdm next state to RET when being called from cpuidle.

No, you _must_ limit it to RET. Otherwise the DSI will break down. So we
can either keep the dsi code as it is now, or explicitely disable OFF
mode and then apply your patch. But your patch alone won't work.

In the long run I think we anyway need to somehow dynamically manage the
power state. I haven't measured it but I believe resuming from OFF will
have a bit of a penalty, as (I think) DSI PLL etc. will have to
reinitialized. But it would still be good to allow RET whenever
possible, and OFF only after some period of inactivity.

 Tomi


