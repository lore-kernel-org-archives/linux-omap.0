From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 1/4] regulator: helper routine to extract regulator_init_data
Date: Fri, 4 Nov 2011 15:50:05 -0700
Message-ID: <CAOesGMh028s9mxHYwMq0h_a2km_GL_6O1ce=NN2HVBZ9q_1qAQ@mail.gmail.com>
References: <1319721864-30067-1-git-send-email-rnayak@ti.com>
	<20111104202905.GA3918@quad.lixom.net>
	<20111104211447.GC2541@opensource.wolfsonmicro.com>
	<20111104212216.GA5756@quad.lixom.net>
	<20111104212910.GB8266@opensource.wolfsonmicro.com>
	<CAOesGMgA7UayF9SJUP0YLnj86GmKBrajsBxv4_kRNNqCsvKTYg@mail.gmail.com>
	<20111104214650.GC8266@opensource.wolfsonmicro.com>
	<CAOesGMjkcExKXhNN1nFGey=wBie0PQGp2XS_r-5Rr3X0p4eNhg@mail.gmail.com>
	<20111104223518.GC16978@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37748 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab1KDWuG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 18:50:06 -0400
In-Reply-To: <20111104223518.GC16978@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rajendra Nayak <rnayak@ti.com>, grant.likely@secretlab.ca, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, Nov 4, 2011 at 3:35 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Nov 04, 2011 at 03:16:12PM -0700, Olof Johansson wrote:
>> On Fri, Nov 4, 2011 at 2:46 PM, Mark Brown
>
>> >> Describing that in the device tree using regulator-specifiers
>> >> shouldn't be too bad? The LDO will reference the DCDC as the pare=
nt
>> >> supply (or input or whatever language you prefer). They don't hav=
e to
>> >> be in the same topology, they will instead be under whatever
>> >> controller/bus they are on for control -- i2c, etc.
>
>> > That's not great as it means you've got a separate binding for sup=
plies
>> > that happen to be connected to another regulator from that used fo=
r
>> > other supplies on the device which is particularly confusing in th=
e
>> > fairly common case where a regulator chip has multiple supplies. =A0=
Using
>> > the same method for binding all supplies seems much neater.
>
>> I'm not following the above 100%, but I think you are saying that yo=
u
>> would prefer to describe the regulator / power hierarchy in the
>> functional topology instead of how the various regulators and suppli=
es
>> are organized on i2c busses and other controllers? =A0And the obviou=
s
>> one that would be less than trivial to find a home for would be the
>> top-level or freestanding fixed regulators that don't sit on a
>> controlling bus.
>
> No, that's not the issue at all. =A0The issue is that we want a singl=
e way
> of describing the supplies a device has regardless of their function
> (which is what the existing stuff does).
>
> Consider the case of a simple regulator with register control. =A0It =
is
> going to have a supply used for the regulator itself and almost
> certainly also a separate digital buffer supply used to reference the
> digital I/O. =A0It seems bad to specify the first supply in a differe=
nt
> manner to the second, and there are more complex examples where a sup=
ply
> can be both a regulator input and also a more general purpose supply.

Ah, we're misunderstanding each other again (as just discussed on irc
as well), and we're in agreement here as far as I can tell.

Named properties using regulator-specifiers to reference upstream
supplies should work well enough for any use today, and if it needs to
be reconsidered in the future we can revisit it then.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
