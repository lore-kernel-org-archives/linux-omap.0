From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 6 Nov 2012 16:13:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211061611460.20573@utopia.booyaka.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com> <20121029200032.GD30152@arwen.pp.htv.fi> <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com> <20121030123254.GD29095@arwen.pp.htv.fi> <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
 <20121030125419.GG29095@arwen.pp.htv.fi> <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com> <CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com> <87fw4u3oh5.fsf@deeprootsystems.com> <CAORVsuUWD3gHh1NcMLeGwZ=hF=UiOG2VyJkADZNcGVr1g1TFgQ@mail.gmail.com>
 <alpine.DEB.2.00.1211010242001.6693@utopia.booyaka.com> <CAORVsuXHxqhcTHv8Y=8gw4N+0+rx+N91bh971zK-TmcsrTu5nQ@mail.gmail.com> <CAORVsuUda69_sE9LpBnuETXSA2jPxw7nQ=MkAq=Or8B7t1fvcA@mail.gmail.com> <alpine.DEB.2.00.1211050313130.23228@utopia.booyaka.com>
 <CAORVsuUGcydD13-VcaNjmAmrsyo9ZVHGTRoSKgLyr4-Bkw7zhg@mail.gmail.com> <87fw4neh0i.fsf@deeprootsystems.com> <CAORVsuUm4zKoSaZQ0D=gf3toKHWznjfNvQ+q4=jsgkRaJXygMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42888 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab2KFQNB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 11:13:01 -0500
In-Reply-To: <CAORVsuUm4zKoSaZQ0D=gf3toKHWznjfNvQ+q4=jsgkRaJXygMg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

On Tue, 6 Nov 2012, Jean Pihet wrote:

> On Tue, Nov 6, 2012 at 1:01 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>
> > FYI... I just ran across what appears to be the same bug on 3430/n900
> > during suspend/resume testing.  With CPUidle enabled, this happens every
> > time.
> >
> > Reverting the I2C QoS patch makes it work again.
> 
> That makes sense with CPU_IDLE enabled and suspend.

...

> For the records here are the patches that have been submitted to
> support the OMAP PM QoS:
> - func power states [1],
> - OMAP PM QoS support [2], which includes the latency figures update
> and which depends on [1],
> - the conversion of I2C to PM QoS [3],
> - the removal of the old no-op OMAP PM API [4], which depends on [3],
> 
> The chicken-and-egg problem is clearly visible since [3] depends on [2].

Well it's definitely time for a revert, then.  #3 should not have been 
sent until #2 was merged.  Will send this in a new thread, please ack it.


- Paul
