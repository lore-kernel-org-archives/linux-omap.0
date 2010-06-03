From: "Gross, Mark" <mark.gross@intel.com>
Subject: RE: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 07:26:55 -0700
Message-ID: <CA1BBBBC9359F04AA639128AC0D5D1E96931D46D@orsmsx502.amr.corp.intel.com>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	 <20100601135102.GA8098@srcf.ucam.org>
	 <1275426085.21962.967.camel@mulgrave.site> <201006020024.14220.rjw@sisk.pl>
	 <1275431816.21962.1108.camel@mulgrave.site>
	 <AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
	 <1275451342.21962.1777.camel@mulgrave.site>
	 <AANLkTilRcFZyYa-0HlaM-6IEZSyar3S9S_cCWSFax2Zo@mail.gmail.com>
	 <1275491111.2799.110.camel@mulgrave.site>
	 <20100602214748.7742e3ae@schatten.dmk.lab>
	 <1275511271.2799.516.camel@mulgrave.site>
	 <20100603010607.5baf82a6@schatten.dmk.lab>
	 <CA1BBBBC9359F04AA639128AC0D5D1E9692ABC92@orsmsx502.amr.corp.intel.com>
	 <20100603110312.48a508dc@lxorguk.ukuu.org.uk>
 <1275571471.5914.2.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51370 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754261Ab0FCO06 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 10:26:58 -0400
In-Reply-To: <1275571471.5914.2.camel@mulgrave.site>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Florian Mickler <florian@mickler.org>, =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Neil Brown <neilb@suse.de>, "tytso@mit.edu" <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>



>-----Original Message-----
>From: James Bottomley [mailto:James.Bottomley@suse.de]
>Sent: Thursday, June 03, 2010 6:25 AM
>To: Alan Cox
>Cc: Gross, Mark; Florian Mickler; Arve Hj=F8nnev=E5g; Neil Brown;
>tytso@mit.edu; Peter Zijlstra; LKML; Thomas Gleixner; Linux OMAP Maili=
ng
>List; Linux PM; felipe.balbi@nokia.com
>Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
>
>On Thu, 2010-06-03 at 11:03 +0100, Alan Cox wrote:
>> > [mtg: ] This has been a pain point for the PM_QOS implementation. =
 They
>change the constrain back and forth at the transaction level of the i2=
c
>driver.  The pm_qos code really wasn't made to deal with such hot path=
 use,
>as each such change triggers a re-computation of what the aggregate qo=
s
>request is.
>>
>> That should be trivial in the usual case because 99% of the time you=
 can
>> hot path
>>
>> 	the QoS entry changing is the latest one
>> 	there have been no other changes
>> 	If it is valid I can use the cached previous aggregate I cunningly
>> 		saved in the top QoS entry when I computed the new one
>>
>> (ie most of the time from the kernel side you have a QoS stack)
>
>It's not just the list based computation: that's trivial to fix, as yo=
u
>say ... the other problem is the notifier chain, because that's blocki=
ng
>and could be long.  Could we invoke the notifier through a workqueue?
>It doesn't seem to have veto power, so it's pure notification, does it
>matter if the notice is delayed (as long as it's in order)?
[mtg: ] true.  The notifications "could be" done on as a scheduled work=
 item
in most cases.  I think there is only one user of the notification so f=
ar=20
any way.  Most pm_qos users do a pole of the current value for whatever=
 parameter they are interested in.

--mgross

>
>> > We've had a number of attempts at fixing this, but I think the pro=
per
>fix is to bolt a "disable C-states > x" interface into cpu_idle that
>bypases pm_qos altogether.  Or, perhaps add a new pm_qos API that does=
 the
>equivalent operation, overriding whatever constraint is active.
>>
>> We need some of this anyway for deep power saving because there is
>> hardware which can't wake from soem states, which in turn means if t=
hat
>> device is active we need to be above the state in question.
>
>James
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
