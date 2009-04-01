From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: lowmemory android driver not needed?
Date: Thu, 2 Apr 2009 00:08:36 +0530
Message-ID: <5d5443650904011138p78686bf7oc040762cd3536387@mail.gmail.com>
References: <2f11576a0901160316u20030f4u51c9e4c059398b70@mail.gmail.com>
	 <20090116152338.GB9357@kroah.com>
	 <20090122114955.32F3.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:39634 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760865AbZDASik convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 14:38:40 -0400
In-Reply-To: <20090122114955.32F3.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Greg KH <greg@kroah.com>, Paul Mundt <lethal@linux-sh.org>, Arve Hj?nnev?g <arve@android.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, arve@google.com, San Mehat <san@android.com>, Robert Love <rlove@google.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, ext Juha Yrj?l? <juha.yrjola@solidboot.com>, viktor.rosendahl@nokia.com

Hi

On Wed, Jan 21, 2009 at 8:20 AM, KOSAKI Motohiro
<kosaki.motohiro@jp.fujitsu.com> wrote:

>>
>> Care to work on your mem_notify patch again and bring it up to date?
>> That would be a good place to start working from, right?
>
> Unfortunately No ;)
>
> I should rewrite memory notification patchset from scratch.
> the new version will construct on memcg infrastrcture.
>
> Why?
>
> last year, I received many feedback from lkml folks and my article re=
ader.
> (I monthly write kernel patch introduction article to japanese web
> =A0magazine and receive some feedback periodically)
>
> I learned many people want flexibility notification.
> (per workload, per user, et al)
> eg. nokia lowmem driver have exception process defined by uid.
>
> at top of last year, I thought memcg don't provide good infrastructur=
e.
> the first version memcg is just pretty funny joke. if its config turn=
 on,
> memory workload performance decrease ~30% although the user don't use
> memcg at runtime. then nobody use it.
> but recently, KAMEZAWA hiroyuki (and Li zefan, Daisuke Nishimura et a=
l)
> dramatically improvement memcg performance.
> now, memcg overhead become less than 1%.
>
> Then, I think any memory accounting activity should use this infrastr=
ucture.
> That's my homework.

Any updates on top of  mem_notify v6 patches?  Is there any WIP for
mem_notify with memcg infrastructure as you have pointed out above?


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
