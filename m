From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: Ensure OPP100 when DSS is operational
Date: Thu, 19 Apr 2012 12:56:20 -0700
Message-ID: <CAJOA=zNpjE37z8DhjcRgx9zqMXXn++juqwPDuPopBM546KHwEg@mail.gmail.com>
References: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
 <1331205217-19927-2-git-send-email-tomi.valkeinen@ti.com> <1331646353.2856.354.camel@deskari>
 <87zkbkmjo1.fsf@ti.com> <1331707131.1618.7.camel@lappy> <87vckxm0px.fsf@ti.com>
 <CAJOA=zN4ghhg2wpJeqFN97myMihGxvOSN05NkxoMFKG2BgYORA@mail.gmail.com> <1334811972.1521.30.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41191 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932141Ab2DSUEl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 16:04:41 -0400
Received: by eaaq12 with SMTP id q12so2313680eaa.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 13:04:39 -0700 (PDT)
In-Reply-To: <1334811972.1521.30.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, archit@ti.com

On Wed, Apr 18, 2012 at 10:06 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Wed, 2012-04-18 at 10:26 -0700, Turquette, Mike wrote:
>> On Wed, Apr 18, 2012 at 10:03 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
>> > Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>> >> On Tue, 2012-03-13 at 11:37 -0700, Kevin Hilman wrote:
>> >>> It sounds to me like it acutally is a throughput constraint on C=
ORE. =A0If
>> >>> so, wouldn't it be clearer to set a throughput constraint that i=
s
>> >>> calculated based on the pixel clock and resulting bitrate that w=
ould
>> >>> have the same effect?
>> >>
>> >> I don't see that these limits would have anything to do with CORE=
=2E I'm
>> >> guessing that the DSS HW just can't function properly with high c=
locks
>> >> and low voltage.
>> >
>> > OK, this gets back to something we've talked about a few times tha=
t is
>> > needed in the clock framework. =A0Basically, we need a way for clo=
cks to
>> > prevent changes so these kinds of dependencies can be tracked. =A0=
We've
>> > talked about new APIs like clk_allow_changes(), clk_block_changes(=
) or
>> > something like that.
>> >
>> > Basically, something that allows clocks to know that their will no=
t be
>> > changed under them.
>>
>> Are the DSS clocks changing frequency behind your back? =A0Or are th=
e
>> clock rates staying the same while the voltage is dropped?
>
> The latter. The clocks do not change behind my back. It's the DSS dri=
ver
> making the clock rate changes.

Right.  The DVFS RFC that I'm working on right now should at least
take care of the voltage scaling down when it shouldn't.

>> For the former issue Kevin is right that we need better clock
>> semantics. =A0For the latter issue hopefully the future dvfs
>> architecture will do the right thing (at least it does on paper).
>
> Note that many of the DSS clocks are generated inside DSS HW, and
> managed by the DSS driver, and thus the clock framework doesn't know
> anything about them. Will the future dvfs offer some way for the driv=
ers
> to limit the OPP?

It must!

In fact the common clk framework today (merged in 3.4-rc1) allows you
to model your DSS clocks in a common way that jives with the rest of
the SoC/PMIC/whatever.

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
