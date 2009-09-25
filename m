From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] video: omap2: dss: RET on idle, enable/disable dss
 clocks 	only when needed.
Date: Fri, 25 Sep 2009 12:19:46 +0300
Message-ID: <1253870386.21734.20.camel@tubuntu>
References: <1253230586-931-1-git-send-email-mike@android.com>
	 <1253262472.28956.10.camel@tubuntu>
	 <8bb80c380909181033s2fd5e3a1o16404f1667760b25@mail.gmail.com>
	 <1253514408.4690.5.camel@tubuntu> <877hvrf2sj.fsf@deeprootsystems.com>
	 <1253690451.14841.40.camel@tubuntu>  <87my4lbr86.fsf@deeprootsystems.com>
	 <1253788763.17009.282.camel@tubuntu> <4ABB95A6.7000503@deeprootsystems.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43107 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbZIYJUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 05:20:05 -0400
In-Reply-To: <4ABB95A6.7000503@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: ext Mike Chan <mike@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2009-09-24 at 17:52 +0200, ext Kevin Hilman wrote:
> Tomi Valkeinen wrote:

> > If it is not like that, and the driver initialization is included, how
> > does the PM layer know how long it takes for the DSS driver to
> > reconfigure the DSS hardware from OFF mode?
> 
> Currently it doesn't, but if you were measure it, we can use those 
> numbers in the decision making process.

Ok, now I see. However, I'm not sure if that will work. The problem is
that the wakeup latency depends on many things. When using DPI/RFBI the
wakeup is very fast. With SDI it's probably a bit slower and with DSI
even slower.

And at least with DSI PLL, the wakeup time depends on the frequencies
used (according to TRM), and in some cases it can be optimized, in some
cases not. So I don't think there's one single value that fits all.

Also, I still think it would be better if the driver was also able to
prevent OFF mode explicitely. Defining the max-wakeup-lat with a magic
number sounds a bit prone to breaking up.

But perhaps, as you said, when drivers work properly they don't have to
care about OFF mode as such, but only about the wakeup latency, and thus
the max-wakeup-lat is enough. I'm just not quite sure about that, as OFF
mode may have side effects as the module is totally powered off, while
with RET the side effects should be minimal.

I don't have any concrete example about the side effects, but one
particular thing I'm thinking about is DSI PLL. If DSS is in RET, I
believe DSI PLL works normally. But if the DSS is reset via OFF mode, I
believe DSI PLL is also reset. But I'm not sure if DSI PLL is ever
needed while DSS would be off, so this may be theoretical =).

 Tomi


