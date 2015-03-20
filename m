From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v7 5/6] ARM: dts: add wl12xx/wl18xx bindings
Date: Fri, 20 Mar 2015 17:50:38 +0200
Message-ID: <87bnjnfz1t.fsf@kamboji.qca.qualcomm.com>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com>
	<1426696710-6891-6-git-send-email-eliad@wizery.com>
	<550AD7C1.2030405@gmail.com>
	<CAB3XZEfpD7YkwdU7OJJaNFy=MnYVY3-fOVxkA48Vu01LzU0GFg@mail.gmail.com>
	<20150319212505.GN31346@atomide.com>
	<87h9tgi4sg.fsf@kamboji.qca.qualcomm.com>
	<20150320153357.GT31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50317 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbCTPuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 11:50:51 -0400
In-Reply-To: <20150320153357.GT31346@atomide.com> (Tony Lindgren's message of
	"Fri, 20 Mar 2015 08:33:57 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Eliad Peller <eliad@wizery.com>, Pontus Fuchs <pontus.fuchs@gmail.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Tony Lindgren <tony@atomide.com> writes:

> * Kalle Valo <kvalo@codeaurora.org> [150319 23:04]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> >> > Tested OK (boot, scan, join, ping) on Pandaboard ES.
>> >> >
>> >> thanks for testing it!
>> >
>> > Great. As suggested by Kalle, I'll apply all these into
>> > omap-for-v4.1/wl12xx branch and send a pull request for
>> > the arm-soc probably on Friday if no issues are found.
>> 
>> Great, thank you. Just in case you want this:
>> 
>> Acked-by: Kalle Valo <kvalo@codeaurora.org>
>
> Thanks, I can push out a new branch omap-for-v4.1/wl12xx-v2
> with your acks assuming you or somebody else have not
> merged the existing omap-for-v4.1/wl12xx branch yet into the
> wireless tree?
>
> In that case I can scrap omap-for-v4.1/wl12xx and then will
> reply with a commit that we can consider immutable that can
> be merged into various trees as needed in case of merge
> conflicts.
>
> But I'll wait for your confirmation first :)

After John "retired" we actually have two set of trees now: mac80211
maintained by Johannes and wireless-drivers maintained by me. I haven't
pulled anything from your tree and I'm 100% sure Johannes hasn't either.
So green light from me.

-- 
Kalle Valo
