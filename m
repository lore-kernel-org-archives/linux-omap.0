From: tarek attia <tarek.m.attia@gmail.com>
Subject: Re: SR2: VDD autocomp is not active
Date: Tue, 29 Dec 2009 15:32:10 +0200
Message-ID: <82cfbe860912290532u5be4064gc56cd04f9805dbb5@mail.gmail.com>
References: <82cfbe860912270047j6332384drff2c82ecf8eccd24@mail.gmail.com>
	 <4B3862E3.1090705@ti.com>
	 <82cfbe860912290428v573ec0c5k5506ad3dad6c0c35@mail.gmail.com>
	 <4B39F66F.8080709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53611 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZL2NcN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 08:32:13 -0500
Received: by bwz27 with SMTP id 27so6969292bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 05:32:10 -0800 (PST)
In-Reply-To: <4B39F66F.8080709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Basically I'm working on beagleboard rev B5 .
I'm not using the pm branch of kevin ,,however I'm using source files
from the rowboat project (Android) ,just I=A0enabled the cpufreq and
smartreflex in the kernel configuration while I'm building the linux
kernel of Android .

Any Idea :-) ??

On Tue, Dec 29, 2009 at 2:30 PM, Romit Dasgupta <romit@ti.com> wrote:
>
> >>> Each time I enable the ondemand governor ,it works fine for a whi=
le
> >>> ,but each time the frequency is changed this messages appears :-
> >>>
> >>> SR1: VDD autocomp is not active
> >>>
> >>> then it works again ,but after small amount of time this messages
> >>> appears followed by hang up for the overall system
> >>>
> >>> SR2: VDD autocomp is not active
> >>>
> >>>
> >> try this:
> >> echo 1 > /sys/power/sr_vdd1_autocomp; echo 1 > /sys/power/sr_vdd2_=
autocomp
> What platform are you using? Also what is your git HEAD?
> I can smell 3630... ;-) please confirm.



--
tarek
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
