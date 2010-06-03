From: "Muralidhar, Rajeev D" <rajeev.d.muralidhar@intel.com>
Subject: RE: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 22:46:59 +0530
Message-ID: <4F93CB265C2E2E42A19CD9E994A1FA5D042929DEBF__26294.5669623607$1275586493$gmane$org@bgsmsx501.gar.corp.intel.com>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100601135102.GA8098@srcf.ucam.org>
	<1275426085.21962.967.camel@mulgrave.site>	<201006020024.14220.rjw@sisk.pl>
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
	<1275559512.27810.35287.camel@twins>	<87d3w818ki.fsf@deeprootsystems.com>
	<CA1BBBBC9359F04AA639128AC0D5D1E96931D4BB@orsmsx502.amr.corp.intel.com>
 <87hblkyrwt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47545 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096Ab0FCReX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 13:34:23 -0400
In-Reply-To: <87hblkyrwt.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Gross, Mark" <mark.gross@intel.com>, Neil Brown <neilb@suse.de>, "tytso@mit.edu" <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>
Cc: "Muralidhar, Rajeev D" <rajeev.d.muralidhar@intel.com>

Hi Kevin, Mark, all,

Yes, from our brief discussions at ELC, and all the ensuing discussions=
 that have happened in the last few weeks, it certainly seems like a go=
od time to think about:
- what is a good model to tie up device idleness, latencies, constraint=
s with cpu idle infrastructure - extensions to PM_QOS, part of what is =
being discussed, especially Kevin's earlier mail about QOS parameter pe=
r subsystem/device that may have independent clock/power domain control=
=2E

- what is a good infrastructure to subsequently allow platform-specific=
 low power state - extensions to cpuidle infrastructure to allow platfo=
rm-wide low power state? Exact conditions for such entry/exit into low =
power state (latency, wake, etc.) could be platform specific.

Is it a good idea to discuss about a model that could be applicable to =
other SOCs/platforms as well?

Thanks
Rajeev


-----Original Message-----
=46rom: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-bo=
unces@lists.linux-foundation.org] On Behalf Of Kevin Hilman
Sent: Thursday, June 03, 2010 10:28 PM
To: Gross, Mark
Cc: Neil Brown; tytso@mit.edu; Peter Zijlstra; felipe.balbi@nokia.com; =
LKML; Florian Mickler; James Bottomley; Thomas Gleixner; Linux OMAP Mai=
ling List; Linux PM; Alan Cox
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)

"Gross, Mark" <mark.gross@intel.com> writes:

>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, June 03, 2010 7:43 AM
>>To: Peter Zijlstra
>>Cc: Alan Cox; Gross, Mark; Florian Mickler; James Bottomley; Arve
>>Hj=F8nnev=E5g; Neil Brown; tytso@mit.edu; LKML; Thomas Gleixner; Linu=
x OMAP
>>Mailing List; Linux PM; felipe.balbi@nokia.com
>>Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
>>
>>Peter Zijlstra <peterz@infradead.org> writes:
>>
>>> On Thu, 2010-06-03 at 11:03 +0100, Alan Cox wrote:
>>>> > [mtg: ] This has been a pain point for the PM_QOS implementation=
=2E
>>>> They change the constrain back and forth at the transaction level =
of
>>>> the i2c driver.  The pm_qos code really wasn't made to deal with s=
uch
>>>> hot path use, as each such change triggers a re-computation of wha=
t
>>>> the aggregate qos request is.
>>>>
>>>> That should be trivial in the usual case because 99% of the time y=
ou can
>>>> hot path
>>>>
>>>> 	the QoS entry changing is the latest one
>>>> 	there have been no other changes
>>>> 	If it is valid I can use the cached previous aggregate I cunningl=
y
>>>> 		saved in the top QoS entry when I computed the new one
>>>>
>>>> (ie most of the time from the kernel side you have a QoS stack)
>>>
>>> Why would the kernel change the QoS state of a task? Why not have t=
wo
>>> interacting QoS variables, one for the task, one for the subsystem =
in
>>> question, and the action depends on their relative value?
>>
>>Yes, having a QoS parameter per-subsystem (or even per-device) is ver=
y
>>important for SoCs that have independently controlled powerdomains.
>>If all devices/subsystems in a particular powerdomain have QoS
>>parameters that permit, the power state of that powerdomain can be
>>lowered independently from system-wide power state and power states o=
f
>>other power domains.
>>
> This seems similar to that pm_qos generalization into bus drivers we =
where=20
> waving our hands at during the collab summit in April?  We never did =
get=20
> into meaningful detail at that time.

The hand-waving was around how to generalize it into the driver-model,
or PM QoS.  We're already doing this for OMAP, but in an OMAP-specific
way, but it's become clear that this is something useful to
generalize.

Kevin
