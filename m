From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 6/9] OMAP2/3: Add support for flash on SDP boards
Date: Wed, 12 Aug 2009 17:11:07 +0530
Message-ID: <ce9ab5790908120441i47fe0c5aj284a1f9e423be945@mail.gmail.com>
References: <20090811094348.32577.81307.stgit@localhost> <20090811095315.32577.89520.stgit@localhost>
	<ce9ab5790908110733g6cedd036w792ea7bc30b8e227@mail.gmail.com>
	<20090812113057.GE7278@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:57852 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbZHLLl0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 07:41:26 -0400
Received: by qyk34 with SMTP id 34so3761047qyk.33
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 04:41:27 -0700 (PDT)
In-Reply-To: <20090812113057.GE7278@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Wed, Aug 12, 2009 at 5:00 PM, Tony Lindgren<tony@atomide.com> wrote:
> * vimal singh <vimal.newwork@gmail.com> [090811 17:34]:
>> On Tue, Aug 11, 2009 at 3:23 PM, Tony Lindgren<tony@atomide.com> wro=
te:
>> > Add support for flash on SDP boards. Currently only onenand
>> > is supported.
>> >
>> > Only tested on 3430SDP, somebody please test on 2430SDP and
>> > check the chip select for 2430SDP.
>> >
>> > Also note that in the earlier 2430SDP code the kernel partition
>> > was set to only 1MB instead of 2MB on 3430SDP. If people want
>> > the old partition sizes back on 2430SDP, please provide a patch.
>> >
>
> <snip>
>
>> > +static struct omap_onenand_platform_data board_onenand_data =3D {
>> > + =A0 =A0 =A0 .cs =A0 =A0 =A0 =A0 =A0 =A0 =3D 2, =A0 =A0/* REVISIT=
: Is this the same for 2430 SDP? */
>>
>> SDP3430 V2 Board CS organization is different from SDP3430 V1. Now 4
>> dip switches are used to specify CS configuration for flashes.
>
> Hmm, OK thanks. That could be done with a cmdline option, or
> by adding the GPMC probing in some generic form on top of this patch.
>
> Do you still want this patch to get integrated, or me to drop it
> until somebody patches support for toggling the chip select?

You may drop this patch as of now. I'll submit a patch for this
probably next week.

-vimal

>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
