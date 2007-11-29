From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Switching to vger mailing list, was: [PATCH] ARM: OMAP: MACH-OMAP1:
 Fix compilation issues for OMAP1
Date: Thu, 29 Nov 2007 16:59:51 +0100
Message-ID: <474EE1F7.2070301@googlemail.com>
References: <1196092220-6633-1-git-send-email-felipe.lima@indt.org.br>
	<474B23A4.7090902@googlemail.com>
	<20071126200939.GH21886@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071126200939.GH21886@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Dirk Behme <dirk.behme@googlemail.com> [071126 11:51]:
>>Felipe Balbi wrote:
>>>After commit 6e0d7b9283a5b91bf2c2adc7801e426fd563bc13 building
>>>is broken for omap1 archs due to double definition of sched_clock().
>>>sched_clock() has moved to plat-omap/common.c so it's ok removing it
>>>from mach-omap1/time.c
>>
>>While trying to find this patch in list archive, I found that you sent it 
>>only to our new list at vger.kernel.org [1]. Nice, now I'm sure that mails 
>>from that list reach me as well ;) But we have no archive there yet. So for 
>>some time I think CC to Linux-omap-open-source@linux.omap.com would be good 
>>as well.
> 
> BTW, I got a mail from Hank Leininger at MARC today saying that he is
> adding the list. He will also import the old archives there!

Its there:

http://marc.info/?l=linux-omap

:)

Tony, do you like to ask vger admin to put anything like

-- cut --
This is the "new" mailing list for Linux on ARM based TI OMAP SoCs. 
For (old & new) archive see

http://marc.info/?l=linux-omap

This list is medium traffic, ~10 mails per day, sometimes patches and 
patch series. Send OMAP related infos, bugs or patches to this list, 
at least in CC if they affect other subsystems. See

http://source.mvista.com/git/?p=linux-omap-2.6.git;a=summary

for OMAP git kernel discussed on this list.
-- cut --

to http://vger.kernel.org/vger-lists.html#linux-omap?

Maybe we can switch over to vger list a 1st Dec then.

Regards

Dirk
