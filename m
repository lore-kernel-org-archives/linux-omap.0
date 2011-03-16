From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 16 Mar 2011 20:09:02 +0530
Message-ID: <AANLkTinWyiGziE3TxF5Hh=0FSihi2FoUDvUVzONmsDRM@mail.gmail.com>
References: <20110314192538.GH7258@atomide.com> <20110316140710.GA10385@m-desktop>
 <20110316142017.GB10385@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39181 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab1CPOjZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 10:39:25 -0400
Received: by eyx24 with SMTP id 24so449150eyx.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 07:39:24 -0700 (PDT)
In-Reply-To: <20110316142017.GB10385@m-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Wed, Mar 16, 2011 at 7:50 PM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
> On Wed, Mar 16, 2011 at 07:37:10PM +0530, G, Manjunath Kondaiah wrote=
:
>> On Mon, Mar 14, 2011 at 12:25:38PM -0700, Tony Lindgren wrote:
>> > Hi all,
>> >
>> > I've applied few random fix like patches today into omap-for-linus
>> > but that's it for this merge window.
>> >
>> > So let's do some testing with with Stephen's for-next and
>> > omap-for-linus and start queueing up fixes for the -rc cycle.
>> omap-for-linus boots on:
>> OMAP3430-Zoom2
>> OMAP3630-Zoom3
>> OMAP4430-Blaze
>>
>> With OMAP3 and OMAP4 disabled, it boots successfully on:
>> OMAP2420-H4
>> OMAP2430-SDP
>
> Also boots on OMAP1710-H3

boots fine on OMAP4430SDP as well

Regards,
Kishore

>
> -Manjunath
>
>>
>> -Manjunath
>>
>> >
>> > I've also moved all the patchwork.kernel.org patches into
>> > archived-v2.6.39 bundle and marked them as archived:
>> >
>> > https://patchwork.kernel.org/user/bundle/1381/
>> >
>> > You can still find the patches there if you click on Filters
>> > and changed Archived from No to Both.
>> >
>> > Looks like there's one smartreflex patch that does not seem
>> > to exist in patchwork though.. So that one is still lurking
>> > around on the patchwork list of patches until the issue has
>> > been fixed in patchwork.kernel.org.
>> >
>> > Cheers,
>> >
>> > Tony
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
