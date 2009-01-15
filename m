From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: lowmemory android driver not needed?
Date: Thu, 15 Jan 2009 19:02:48 +0530
Message-ID: <5d5443650901150532r20a4c25q834afadde2f98a3@mail.gmail.com>
References: <20090114010223.GA21380@kroah.com>
	 <20090114021801.GA14759@bulgaria.corp.google.com>
	 <d6200be20901131830r7103ff8eoe0314f9faf89d89b@mail.gmail.com>
	 <20090114035237.GB16442@kroah.com> <20090114104307.GA20451@elf.ucw.cz>
	 <20090114104834.18387fca@lxorguk.ukuu.org.uk>
	 <d6200be20901141426r1d48ea33gc9a380451e4aaf93@mail.gmail.com>
	 <20090114231739.GB24111@kroah.com>
	 <d6200be20901141532y6f236104kd521041d640c152e@mail.gmail.com>
	 <20090115001224.GC11328@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:27220 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757582AbZAONkF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 08:40:05 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1275639wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 15 Jan 2009 05:40:05 -0800 (PST)
In-Reply-To: <20090115001224.GC11328@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, arve@google.com, San Mehat <san@android.com>, Robert Love <rlove@google.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?ext_Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>, viktor.rosendahl@nokia.com

Hi Greg,

On Thu, Jan 15, 2009 at 5:42 AM, Greg KH <greg@kroah.com> wrote:
> On Wed, Jan 14, 2009 at 03:32:38PM -0800, Arve Hj=F8nnev=E5g wrote:
>> On Wed, Jan 14, 2009 at 3:17 PM, Greg KH <greg@kroah.com> wrote:
>> >> We actually use 6 different thresholds for killing processes. I d=
on't
>> >> know what all the classes are, processes with a higher oom_adj va=
lue
>> >> can be killed with less impact to the user than processes with a =
lower
>> >> oom_adj value. The first few classes only affect latency when
>> >> switching apps, but later classes stop non critical background
>> >> services and finally the foreground app. Another reason to not ki=
ll
>> >> every process at the same threshold is that memory may not be fre=
e
>> >> immediately when the process is killed.
>> >
>> > But the lowmemorykiller android module doesn't have anything to do=
 with
>> > this, right?
>> >
>>
>> It does. We write the thresholds to
>> /sys/module/lowmemorykiller/parameters/adj and
>> /sys/module/lowmemorykiller/parameters/minfree then set the oom_adj
>> value per process. If the standard oom killer can be adjusted in a
>> similar way, then we will not need the lowmemorykiller module.
>
> Great, care to document this somewhere so people like me don't get
> confused?

And there is one more lowmem driver developed by Nokia for Nokia 8xx
tablets it seems. CCed Tony Lindgren,  Juha and Viktor.

http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git;a=
=3Dblob;f=3Dsecurity/lowmem.c;h=3Dae78a530af39703e335ad769f1e6f097f63ec=
6dd;hb=3DHEAD

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
