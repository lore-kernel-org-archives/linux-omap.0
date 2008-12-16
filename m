From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Tue, 16 Dec 2008 11:35:07 +0530
Message-ID: <5d5443650812152205k4d6c7back8bae8aa61487eb6c@mail.gmail.com>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
	 <20081215134010.GA10709@mail.solidboot.com>
	 <1229352752.5895.325.camel@jani-desktop>
	 <20081215152920.GA11007@mail.solidboot.com>
	 <1229356723.5895.348.camel@jani-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:53922 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYLPGFI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 01:05:08 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3048744wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 22:05:07 -0800 (PST)
In-Reply-To: <1229356723.5895.348.camel@jani-desktop>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: =?ISO-8859-1?Q?ext_Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org

Hi Jani,

On Mon, Dec 15, 2008 at 9:28 PM, Jani Nikula
<ext-jani.1.nikula@nokia.com> wrote:
> On Mon, 2008-12-15 at 17:29 +0200, ext Juha Yrj=F6l=E4 wrote:
>> On Mon, Dec 15, 2008 at 04:52:32PM +0200, Jani Nikula wrote:
>>
>> > The switches themselves don't change (nor does this patch support
>> > changing them), but different kinds of external devices may be con=
nected
>> > to the GPIO swiches. It would be useful to be able to change the
>> > notification callbacks and debounce timeouts according to the devi=
ce.
>>
>> Could you give an example use-case?
>
> For example a jack that supports headsets with a button. The button
> could function by simply grounding one of the lines (connected to a
> GPIO, of course) or by generating some sort of an interrupt pulse. Th=
e
> jack might support other kinds of accessories as well. And the requir=
ed
> actions and settling times might differ vastly.
>
>> If the gpio-switch framework starts
>> getting extended and used more, it might be sensible to convert it t=
o
>> the general GPIO API, as Trilok suggested.
>
> I agree with this, but I'm afraid I don't have the time to extend the
> scope of my work that much right now.
>

OK, I found other guys (android ??) using such home brew frameworks.
Time to write a switch framework.

android-msm git tree: drivers/switch

Link:
http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dtree;f=3Ddrivers/=
switch;h=3Db064ed6374257163439f861f105a651126f11f08;hb=3DHEAD

As you have explained above headset and headset switch/button
detection usecase, similar one is in case of android using their
switch framework:

Link:
http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Darch/arm=
/mach-msm/board-trout-h2w.c;h=3Dc6dfd726adb6decf5b5e1a9d18606b2154b8f22=
9;hb=3Drefs/heads/android-msm-htc-2.6.25

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
