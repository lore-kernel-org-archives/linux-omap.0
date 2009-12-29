From: tarek attia <tarek.m.attia@gmail.com>
Subject: Re: SR2: VDD autocomp is not active
Date: Tue, 29 Dec 2009 14:28:16 +0200
Message-ID: <82cfbe860912290428v573ec0c5k5506ad3dad6c0c35@mail.gmail.com>
References: <82cfbe860912270047j6332384drff2c82ecf8eccd24@mail.gmail.com>
	 <4B3862E3.1090705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:51725 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbZL2M2S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 07:28:18 -0500
Received: by bwz27 with SMTP id 27so6943446bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 04:28:17 -0800 (PST)
In-Reply-To: <4B3862E3.1090705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Thank you for your reply ,

But another thing appears and also the system hangs up after
activation the ondemand governor

OPP4 doesn't support SmartReflex
SR1: VDD autocomp not activated

P.S:- I did as you told me by echo 1>sys/power/,,,etc


Regards,

On Mon, Dec 28, 2009 at 9:48 AM, Romit Dasgupta <romit@ti.com> wrote:
>
> tarek attia wrote:
> > Hi all,
> >
> > Each time I enable the ondemand governor ,it works fine for a while
> > ,but each time the frequency is changed this messages appears :-
> >
> > SR1: VDD autocomp is not active
> >
> > then it works again ,but after small amount of time this messages
> > appears followed by hang up for the overall system
> >
> > SR2: VDD autocomp is not active
> >
> >
>
> try this:
> echo 1 > /sys/power/sr_vdd1_autocomp; echo 1 > /sys/power/sr_vdd2_autocomp
>



--
tarek
