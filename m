From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 6 Nov 2012 15:36:45 +0530
Message-ID: <CAM=Q2cs2LO3LOQxSMJTXZLZNsmMiLAOxMcWwSf0Wxt-Fnz6QZA@mail.gmail.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
	<CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
	<20121025101212.GD21217@arwen.pp.htv.fi>
	<20121026201539.GD29548@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
	<20121029200032.GD30152@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
	<20121030123254.GD29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
	<20121030125419.GG29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
	<CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
	<87fw4u3oh5.fsf@deeprootsystems.com>
	<CAORVsuUWD3gHh1NcMLeGwZ=hF=UiOG2VyJkADZNcGVr1g1TFgQ@mail.gmail.com>
	<alpine.DEB.2.00.1211010242001.6693@utopia.booyaka.com>
	<CAORVsuXHxqhcTHv8Y=8gw4N+0+rx+N91bh971zK-TmcsrTu5nQ@mail.gmail.com>
	<CAORVsuUda69_sE9LpBnuETXSA2jPxw7nQ=MkAq=Or8B7t1fvcA@mail.gmail.com>
	<alpine.DEB.2.00.1211050313130.23228@utopia.booyaka.com>
	<CAORVsuUGcydD13-VcaNjmAmrsyo9ZVHGTRoSKgLyr4-Bkw7zhg@mail.gmail.com>
	<87fw4neh0i.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:37754 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2KFKGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 05:06:47 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so187043lag.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 02:06:45 -0800 (PST)
In-Reply-To: <87fw4neh0i.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Nov 6, 2012 at 5:31 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
> [...]
>
>> I ran some intensive stress tests on the I2C and ... unfortunately I
>> could not trigger the problem. It looks like the issue is caused by
>> some transient situation where the CORE and/or I2C is in a low power
>> state.
>
> FYI... I just ran across what appears to be the same bug on 3430/n900
> during suspend/resume testing.  With CPUidle enabled, this happens every
> time.
>
> Reverting the I2C QoS patch makes it work again.

I think we should defer the release of the constraints

Does this help
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg79841.html
