From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/4] omap: mailbox: convert rwlocks to spinlock
Date: Fri, 14 May 2010 11:30:57 +0300 (EEST)
Message-ID: <20100514.113057.242129373.Hiroshi.DOYU@nokia.com>
References: <1273483013-5942-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<x2p94a0d4531005100312ocd30641ds7648e9a497e3dfd9@mail.gmail.com>
	<20100510.134014.226801230.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48786 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383Ab0ENIbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 04:31:08 -0400
In-Reply-To: <20100510.134014.226801230.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ohad@wizery.com, h-kanigeri2@ti.com

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/4] omap: mailbox: convert rwlocks to spinlock
Date: Mon, 10 May 2010 13:40:14 +0300 (EEST)

> Hi Felipe,
> 
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [PATCH 1/4] omap: mailbox: convert rwlocks to spinlock
> Date: Mon, 10 May 2010 12:12:52 +0200
> 
>> On Mon, May 10, 2010 at 12:16 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>>> From: Ohad Ben-Cohen <ohad@wizery.com>
>>>
>>> rwlocks are slower and have potential starvation issues
>>> therefore spinlocks are generally preferred.
>>>
>>> see also: http://lwn.net/Articles/364583/
>>>
>>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>>> Signed-off-by: Kanigeri Hari <h-kanigeri2@ti.com>
>>> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> 
>> There's no cover letter, so I'll comment here.
>> 
>> What about these patches?
>> http://article.gmane.org/gmane.linux.ports.arm.omap/31208
> 
> OK, I'll incorporate them and send patches again.

The above has been sent to LAKML by Tony a while ago. I just rebased
Ohad's ones on the top of Fernando's.

The following changes since commit b57f95a38233a2e73b679bea4a5453a1cc2a1cc9:

  Linux 2.6.34-rc7 (2010-05-09 18:36:28 -0700)

are available in the git repository at:
  git://gitorious.org/~doyu/lk/mainline.git v2.6.34-rc7.mailbox

Fernando Guzman Lugo (4):
      Mailbox: free mailbox interrupt before freeing blk queue
      Mailbox: flush pending deferred works before freeing blk queue
      Mailbox: Check valid registered callback before calling
      Mailbox: disable mailbox interrupt when request queue

Hiroshi DOYU (1):
      Mailbox: new mutext lock for h/w mailbox configuration

Ohad Ben-Cohen (4):
      omap: mailbox: convert rwlocks to spinlock
      omap: mailbox cleanup: split MODULE_AUTHOR line
      omap: mailbox: remove (un)likely macros from cold paths
      omap: mailbox: convert block api to kfifo

 arch/arm/mach-omap2/mailbox.c             |    3 +-
 arch/arm/plat-omap/Kconfig                |    9 ++
 arch/arm/plat-omap/include/plat/mailbox.h |    4 +-
 arch/arm/plat-omap/mailbox.c              |  169 ++++++++++++++---------------
 4 files changed, 97 insertions(+), 88 deletions(-)
