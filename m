From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: Beagleboard -XM and 32GB microSD card oddities
Date: Thu, 30 Jun 2011 16:49:14 +0100
Message-ID: <4E0C9AFA.60603@blueyonder.co.uk>
References: <4E0C4703.9000207@blueyonder.co.uk> <1309445038.308.10.camel@gregoire-laptop>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:43915 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751716Ab1F3PtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 11:49:16 -0400
In-Reply-To: <1309445038.308.10.camel@gregoire-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregoire@alwaysinnovating.com
Cc: Beagle Board <beagleboard@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

It's marked Sandisk microSD HC 32GB. The only view and description of=20
how it's put together is at=20
http://www.androidcentral.com/finger-32gb-sandisk-microsd-card where on=
e=20
reply reckons it's Class 2.
http://www.jigsaw24.com/product-details/x946axa/sandisk-32gb-micro-sd-c=
ard=20
for a much clear photo.
I only have a Beagleboard -XM, no access to a Pandaboard.
Regards
Sid.

On 30/06/11 15:43, Gregoire Gentil wrote:
> Is your card labeled SDHC or SDXC? Can you give the specs of your car=
d?
> Have you tried on Pandaboard?
>
> Gr=C3=A9goire
>
> On Thu, 2011-06-30 at 10:50 +0100, Sid Boyce wrote:
>> I'm not really looking for a solution, just supplying some informati=
on
>> in case anyone is contemplating a>16GB card.
>>
>> Using Ubuntu 11.04 ARM or x86_64, I cannot create an ext4 partition =
that
>> will mount. Doing fsck.ext4 appears to fix the filesystem, but rerun=
ning
>> fsck.ext4 a second time gives the same errors.
>>
>> Only BTRFS works.
>>
>> A BTRFS partition can be created without a problem. I then use rsync=
 to
>> copy across all the data from the 16GB (ext4) partition and it mount=
s
>> without errors. After the rsync I create the excluded directories pr=
oc,
>> sys, tmp, media.
>>
>> I get a kernel oops (2.6.39-x1) on boot up of the 32GB card.
>> I'm still trying to figure why I'm getting the oops that I don't hav=
e on
>> the original 16GB card.
>> Regards
>> Sid.
>
>


--=20
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
