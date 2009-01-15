From: Greg KH <greg@kroah.com>
Subject: Re: lowmemory android driver not needed?
Date: Thu, 15 Jan 2009 15:44:04 -0800
Message-ID: <20090115234404.GA20142@kroah.com>
References: <20090114021801.GA14759@bulgaria.corp.google.com> <d6200be20901131830r7103ff8eoe0314f9faf89d89b@mail.gmail.com> <20090114035237.GB16442@kroah.com> <20090114104307.GA20451@elf.ucw.cz> <20090114104834.18387fca@lxorguk.ukuu.org.uk> <d6200be20901141426r1d48ea33gc9a380451e4aaf93@mail.gmail.com> <20090114231739.GB24111@kroah.com> <d6200be20901141532y6f236104kd521041d640c152e@mail.gmail.com> <20090115001224.GC11328@kroah.com> <5d5443650901150532r20a4c25q834afadde2f98a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33560 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756192AbZAOXpP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2009 18:45:15 -0500
Content-Disposition: inline
In-Reply-To: <5d5443650901150532r20a4c25q834afadde2f98a3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, arve@google.com, San Mehat <san@android.com>, Robert Love <rlove@google.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, ext Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>, viktor.rosendahl@nokia.com

On Thu, Jan 15, 2009 at 07:02:48PM +0530, Trilok Soni wrote:
> Hi Greg,
>=20
> On Thu, Jan 15, 2009 at 5:42 AM, Greg KH <greg@kroah.com> wrote:
> > On Wed, Jan 14, 2009 at 03:32:38PM -0800, Arve Hj=F8nnev=E5g wrote:
> >> On Wed, Jan 14, 2009 at 3:17 PM, Greg KH <greg@kroah.com> wrote:
> >> >> We actually use 6 different thresholds for killing processes. I=
 don't
> >> >> know what all the classes are, processes with a higher oom_adj =
value
> >> >> can be killed with less impact to the user than processes with =
a lower
> >> >> oom_adj value. The first few classes only affect latency when
> >> >> switching apps, but later classes stop non critical background
> >> >> services and finally the foreground app. Another reason to not =
kill
> >> >> every process at the same threshold is that memory may not be f=
ree
> >> >> immediately when the process is killed.
> >> >
> >> > But the lowmemorykiller android module doesn't have anything to =
do with
> >> > this, right?
> >> >
> >>
> >> It does. We write the thresholds to
> >> /sys/module/lowmemorykiller/parameters/adj and
> >> /sys/module/lowmemorykiller/parameters/minfree then set the oom_ad=
j
> >> value per process. If the standard oom killer can be adjusted in a
> >> similar way, then we will not need the lowmemorykiller module.
> >
> > Great, care to document this somewhere so people like me don't get
> > confused?
>=20
> And there is one more lowmem driver developed by Nokia for Nokia 8xx
> tablets it seems. CCed Tony Lindgren,  Juha and Viktor.
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git=
;a=3Dblob;f=3Dsecurity/lowmem.c;h=3Dae78a530af39703e335ad769f1e6f097f63=
ec6dd;hb=3DHEAD

As we can't stack LSMs, using the lsm interface for a simple memory
driver seems pretty wasteful :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
