From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Fwd: MMC3 Overo
Date: Wed, 5 Aug 2009 10:51:51 -0700
Message-ID: <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	 <6ed0b2680908050132n33abc45bgd4e91690c43ba277@mail.gmail.com>
	 <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>
	 <bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>
	 <873a866xdo.fsf@deeprootsystems.com>
	 <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:36316 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbZHERvy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 13:51:54 -0400
Received: by qw-out-2122.google.com with SMTP id 8so110404qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 10:51:55 -0700 (PDT)
In-Reply-To: <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Sarman <johnsarman@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Aug 5, 2009 at 9:35 AM, John Sarman<johnsarman@gmail.com> wrote=
:
> On Wed, Aug 5, 2009 at 12:25 PM, Kevin Hilman<khilman@deeprootsystems=
=2Ecom> wrote:
>> Might I suggest a kernel patch for this rather than fixing u-boot so=
 that
>> all the midnight oil you've burnt does not have to be duplicated by =
others.
> Well I dont know how to answer that. =A0Because the Mux architecture =
is
> slightly on the scary side. =A0I personally have had success with it,
> but everytime you need to add a new pin functionality you have to
> update mux.h. =A0I finally decided to just focus on having the MUX
> correct at boot up via u-boot.
>
> I could just add the code to update the mux without using the mux arc=
hitecture.
>
> I would appreciate some opinions on this.

I get discouraged every time I look at using kernel pinmuxing.  It
seems to assume that some mux settings are "standard" when in my
experience that is often not so.  So I face having to write code to
undo what it does (and face glitches on the gpio lines), or the bigger
task of restructuring the code to do the right thing.

And up to now in each case I shrug and say "no time to do that now,
I'll just leave kernel pinmuxing turned off and do it in u-boot"

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
