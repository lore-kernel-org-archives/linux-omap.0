From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: lowmemory android driver not needed?
Date: Wed, 21 Jan 2009 12:29:52 +0900
Message-ID: <20090121122952.18e4bb8c.kamezawa.hiroyu@jp.fujitsu.com>
References: <2f11576a0901160316u20030f4u51c9e4c059398b70@mail.gmail.com>
	<20090116152338.GB9357@kroah.com>
	<20090122114955.32F3.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:51075 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbZAUDbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2009 22:31:03 -0500
In-Reply-To: <20090122114955.32F3.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Greg KH <greg@kroah.com>, Paul Mundt <lethal@linux-sh.org>, Trilok Soni <soni.trilok@gmail.com>, Arve Hj?nnev?g <arve@android.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, arve@google.com, San Mehat <san@android.com>, Robert Love <rlove@google.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, ext Juha Yrj?l? <juha.yrjola@solidboot.com>, viktor.rosendahl@nokia.com

On Wed, 21 Jan 2009 11:50:48 +0900 (JST)
KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com> wrote:

> last year, I received many feedback from lkml folks and my article reader.
> (I monthly write kernel patch introduction article to japanese web
>  magazine and receive some feedback periodically)
> 
> I learned many people want flexibility notification.
> (per workload, per user, et al)
> eg. nokia lowmem driver have exception process defined by uid.
> 
> at top of last year, I thought memcg don't provide good infrastructure.
> the first version memcg is just pretty funny joke. if its config turn on,
> memory workload performance decrease ~30% although the user don't use 
> memcg at runtime. then nobody use it.
> but recently, KAMEZAWA hiroyuki (and Li zefan, Daisuke Nishimura et al)
> dramatically improvement memcg performance. 
> now, memcg overhead become less than 1%. 
                             ^^^^^^^^^^^^
just depends on workload...

> 
> Then, I think any memory accounting activity should use this infrastructure.
> That's my homework.
> 

But, memcg requires much memory to track usage of pages, a page_cgroup structure, 
40bytes per page on 64bit, 20bytes per page on 32bit.
Probably, for embeded people, this additinal memory usage is not acceptable.

Below is just a noise:
==
As my personal project, I'd like to write on-demand-fake-numa for generic archs.
Now, section size is 128MB on x86-64. I'd like to allow following ops.

  # create_new_node (echo node_number > /sys/device/system/node/add_fake_node)
  # offline memory (echo offline > /sys/device/system/memory/memoryXXX/state)
  # attach offlined memory to new node
                   (echo node_number > /sys/device/system/memory/memoryXXX/attach)
  # online memmory (echo online > /sys/device/system/memory/memoryXXX/state)

Then, memoryXXX (128MB of chunk of memory) is controlled under a new fake node
"node_number".

For embeded systems, you may be able to modify SECTION_SIZE smaller (8-16MB?) and
cpuset will give them enough resource isolation.
(But not so flexible as memory cgroup.)

you can use node+cpuset information to track memory usage by apps.

Note: OOM-Killer kills process within cpuset.

Thanks,
-Kame






