From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: Ensure OPP100 when DSS is operational
Date: Wed, 18 Apr 2012 10:26:02 -0700
Message-ID: <CAJOA=zN4ghhg2wpJeqFN97myMihGxvOSN05NkxoMFKG2BgYORA@mail.gmail.com>
References: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
 <1331205217-19927-2-git-send-email-tomi.valkeinen@ti.com> <1331646353.2856.354.camel@deskari>
 <87zkbkmjo1.fsf@ti.com> <1331707131.1618.7.camel@lappy> <87vckxm0px.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:44041 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753088Ab2DRR00 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 13:26:26 -0400
Received: by eeit10 with SMTP id t10so2216184eei.4
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 10:26:23 -0700 (PDT)
In-Reply-To: <87vckxm0px.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, archit@ti.com

On Wed, Apr 18, 2012 at 10:03 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>> On Tue, 2012-03-13 at 11:37 -0700, Kevin Hilman wrote:
>>> It sounds to me like it acutally is a throughput constraint on CORE=
=2E =A0If
>>> so, wouldn't it be clearer to set a throughput constraint that is
>>> calculated based on the pixel clock and resulting bitrate that woul=
d
>>> have the same effect?
>>
>> I don't see that these limits would have anything to do with CORE. I=
'm
>> guessing that the DSS HW just can't function properly with high cloc=
ks
>> and low voltage.
>
> OK, this gets back to something we've talked about a few times that i=
s
> needed in the clock framework. =A0Basically, we need a way for clocks=
 to
> prevent changes so these kinds of dependencies can be tracked. =A0We'=
ve
> talked about new APIs like clk_allow_changes(), clk_block_changes() o=
r
> something like that.
>
> Basically, something that allows clocks to know that their will not b=
e
> changed under them.

Are the DSS clocks changing frequency behind your back?  Or are the
clock rates staying the same while the voltage is dropped?

=46or the former issue Kevin is right that we need better clock
semantics.  For the latter issue hopefully the future dvfs
architecture will do the right thing (at least it does on paper).

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
