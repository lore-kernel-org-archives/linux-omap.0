From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: OMAP 3530 LV-SOM support (was: Re: Patch format for submission?)
Date: Fri, 30 Apr 2010 22:12:19 -0400
Message-ID: <j2q1f11a5491004301912xca6177d6y2bfd0b5fb68919df@mail.gmail.com>
References: <1250695463.10817.4.camel@blitz>
	 <200908201802.07169.linz@li-pro.net>
	 <20100429171835.GB5644@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45014 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab0EACMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 22:12:21 -0400
Received: by gyg13 with SMTP id 13so424472gyg.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 19:12:20 -0700 (PDT)
In-Reply-To: <20100429171835.GB5644@gibbs.hungrycats.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>
Cc: Stephan Linz <linz@li-pro.net>, Peter Barada <peterb@logicpd.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Apr 29, 2010 at 1:18 PM, Zygo Blaxell
<vger-linux-omap-esightcorp@mailtoo.hungrycats.org> wrote:
> On Thu, Aug 20, 2009 at 06:02:06PM +0200, Stephan Linz wrote:
>> Am Mittwoch, 19. August 2009 schrieb Peter Barada:
>> > 1) Does anyone have a URL of the format patches should be in that =
are
>> > submitted to the linux-omap list?
>> >
>> > I've got some patches to add base support for the Logic OMAP 35x S=
OM and
>> > Torpedo boards and I'd like to submit them in the right format for
>> > inclusion and push into mainline.
>>
>> Hi Peter,
>>
>> nice to see your announcement here at linux-omap. Today I've finishe=
d my own
>> port for the Logic OMAP 35x SOM based on 2.6.31-rc1. We should share=
 our
>> results befor submitting any patches to the list, or not?
>
> That's the last message I can find from either of you on this topic.
> I'm in the process of rolling yet another patch set for 2.6.32. =A0Wa=
s any
> further work done on this, or anything posted anywhere?
>

Zygo,

No, the LogicPD OMAP 35x support didn't quite make it out to the list,
we are taking another crack at it shortly and would definitely love to
collaborate to get the changes out. We did create a Gitorious repo[1],
but that's sitting at 2.6.31-rc1 and we've internally got a newer
version of the Kernel up to date..

So we should definitely discuss off-list on how to pool our efforts to
get the support into the L-O tree..

Regards
-- Ashwin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
