From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: MMC3 Overo
Date: Thu, 6 Aug 2009 08:35:57 -0700
Message-ID: <5e088bd90908060835g3019c3d1gf402c6a229daa851@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	 <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
	 <4A79C83E.9040603@deeprootsystems.com>
	 <5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com>
	 <4A79D104.60607@deeprootsystems.com>
	 <bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com>
	 <bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com>
	 <871vnp8170.fsf@deeprootsystems.com> <4A7AEC54.107@nt.tu-darmstadt.de>
	 <873a856ki4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:24225 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbZHFPf6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 11:35:58 -0400
Received: by qw-out-2122.google.com with SMTP id 8so377441qwh.37
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2009 08:35:59 -0700 (PDT)
In-Reply-To: <873a856ki4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vladimir Pantelic <pan@nt.tu-darmstadt.de>, linux-omap@vger.kernel.org

On Thu, Aug 6, 2009 at 8:16 AM, Kevin Hilman<khilman@deeprootsystems.co=
m> wrote:

>> even for 1 package, how will you know whether OMAP3_MMC3_CLK is conn=
ected
>> to ball AB1 or AF10 as both is possible...
>
> doh! good point. =A0I was thinking of functions that are only availbl=
e
> on a single ball.

This is the point I was (unsuccessfully) trying to make in my original
response :-)  It was the main source of my frustration, since Overo
seemed to pick "the other" choice of ball far too often.  It made
using kernel pinmuxing a nightmare.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
