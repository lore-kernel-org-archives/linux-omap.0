From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v3 00/13] gpio/omap: Some more driver cleanup and fixes
Date: Tue, 13 Mar 2012 10:05:41 +0530
Message-ID: <CAC83ZvJUpoEhfmMRSNWrObEd8x5JR0hHc40ucU1pqT8zn9PbGw@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<878vj5y7iv.fsf@ti.com>
	<CAC83Zv+8AjCHBOJbtvSQS-URvCE5Xm9oPk9_X7h4Kz7FZ_7Otw@mail.gmail.com>
	<CAC83ZvJKS34Py6vVtk_Si9q3A-9CVN6v4ixNM+HJ37AATcGNPA@mail.gmail.com>
	<CAC83ZvJDfDBcRU1isYaxRe-fWN8F2+QW6W5EeWWuTRcFBGpYNg@mail.gmail.com>
	<87vcm9v4h1.fsf@ti.com>
	<20120313035728.B56993E0FAA@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:52635 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751930Ab2CMEfm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 00:35:42 -0400
Received: by yenl5 with SMTP id l5so254485yen.1
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 21:35:41 -0700 (PDT)
In-Reply-To: <20120313035728.B56993E0FAA@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Tue, Mar 13, 2012 at 9:27 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Mon, 12 Mar 2012 15:28:42 -0700, Kevin Hilman <khilman@ti.com> wro=
te:
>> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>>
>> [...]
>>
>> >>> Oops... I am sorry.
>> >>> I was in the process of updating the branch with latest comments=
 after
>> >>> base-lining on Grant's:
>> >>> git://git.secretlab.ca/git/linux-2.6.git
>> >>> Branch: gpio/next
>> >>> Because this has all the gpio changes including Benoit's latest =
gpio
>> >>> devicetree changes.
>> >>> Should I go ahead?
>> >> Anyways, for the time being I am updating on top of your changes =
as before.
>> >> You should be able to see the branch shortly.
>> > Please note that the branch has your following patch:
>> > gpio/omap: fix wakeups on level-triggered GPIOs
>>
>> Please be sure to Cc the GPIO maintainer (added now.)
Sure.

>>
>> Grant can we consider your gpio/next a stable baseline for further
>> GPIO fixes?
>>
>> If so, Tarun, please base your branch there. =A0Otherwise, continue =
to use
>> my for_3.4/gpio/runtime-pm-cleanup, but please test it by merging wi=
th
>> the gpio/next branch.
>
> I'm not going to rebase gpio/next before the merge window; you can ba=
se on it with
> confidence.
I will base and start doing the tests.
In the mean time I will wait for Kevin's comments on the series.
Thanks.
--
Tarun

>
> g.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
