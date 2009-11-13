From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: CPUFREQ for beagle
Date: Sat, 14 Nov 2009 00:53:26 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA6892A3@dbde02.ent.ti.com>
References: <82cfbe860911130908w7aa0de75n7f82ce1656d014d2@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702FA689286@dbde02.ent.ti.com>
 <82cfbe860911131011x2d58389em3e9a7ef019209911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46083 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801AbZKMTX0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 14:23:26 -0500
In-Reply-To: <82cfbe860911131011x2d58389em3e9a7ef019209911@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tarek attia <tarek.m.attia@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: tarek attia [mailto:tarek.m.attia@gmail.com]
>Sent: Friday, November 13, 2009 12:12 PM
>To: Pandita, Vikram
>Subject: Re: CPUFREQ for beagle
>
>thnx for reply :)
>
>I tried it before but it downloaded kernel 2.6.32 which didn't work
>with the root file system of Angstrom wich relies on kernel 2.6.29
>!!!!!

$git clone git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-=
omap-pm.git
$git checkout -b pm-29 origin/pm-2.6.29

This will get you to 2.6.29 pm code for sure.


>
>Any idea ???
>
>any help will be appreciated
>
>Best Regards
>tarek
>On Fri, Nov 13, 2009 at 8:03 PM, Pandita, Vikram <vikram.pandita@ti.co=
m> wrote:
>>
>>
>>>-----Original Message-----
>>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger=
=2Ekernel.org] On Behalf Of tarek
>>>attia
>>>Sent: Friday, November 13, 2009 11:09 AM
>>>To: linux-omap
>>>Subject: CPUFREQ for beagle
>>>
>>>I want the CPUFREQdriver for the beagleboard which can work with
>>>linux2.6.29 properly
>>
>> You should be able to find that in Kevin's git tree:
>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.=
git pm-2.6.29
>>
>>>
>>>
>>>
>>>
>>>plz any one Help
>>>
>>>
>>>thnx in Advance
>>>tarek
>>>--
>>>To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
