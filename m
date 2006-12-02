From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Sat, 02 Dec 2006 07:11:57 +0100
Message-ID: <4571192D.8040807@gmail.com>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>	
	<456F1B1E.1050305@gmail.com>
	<1164909003.17665.1.camel@imap.mvista.com>	
	<45705464.3070105@gmail.com>
	<1165029705.2964.9.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1165029705.2964.9.camel@imap.mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Daniel Walker <dwalker@mvista.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Daniel Walker wrote:
> On Fri, 2006-12-01 at 17:12 +0100, Dirk Behme wrote:
>>The Versatile and OMAP clocksource patches are in RMKs patch 
>>system. The OMAP one is updated here on the list.
> 
> Updated from someone other than Kevin I assume , or myself. I saw one
> clocksource driver in response to your original email that looked
> nothing like the one Kevin and I worked on, is that what your referring
> to?

Regarding clocksource for OMAP, I refer to [1]. This is 
based on the patch from Kevin and you. Updated by me (acked 
by Kevin [2]) and then more improvements by David.

>>But as I understand Kevin, the rest has been submitted to 
>>Thomas Gleixner and was planned to be included in the 
>>-hrt-dyntick patcheset and then in -mm. And there I couldn't 
>>find them. Would be a shame if they get lost. Especially the 
>>OMAP clockevent one.
> 
> When Thomas did his -mm update all the clocksources got dropped

I'm not talking about (OMAP) clocksource here. I'm talking 
about the rest [3], especially OMAP clockevent patch.

> It's not up to Thomas to merge OMAP, etc .. , clocksources. It's up to
> us (Kevin, and myself) to submit to arch maintainers at this point. If
> someone on this list has an update to our code we can resubmit to RMK,
> or they can directly.

While we are talking on this list, I think we have to split 
the patches in your patchset:

- OMAP clocksource is currently discussed on this list. I 
think it will be merged here when it is clear how it should 
look like.

- OMAP clockevent is potentially something for this list as 
well. But currently, it isn't discussed here and I can't 
find it discussed or included anywhere else. So it looks to 
me that it is lost (until anybody cares again). This is the 
core of my question: Is it currently nowhere maintained?

- The other patches, e.g. for ixp4xx and versatile, I think 
nobody will care on this list and update them here. So until 
they are not handled somewhere else (are they?), they will 
be lost as well.

> Nothing should go via Thomas.

You originally sent most of the patches to Thomas, don't you? ;)

Dirk

[1] 
http://linux.omap.com/pipermail/linux-omap-open-source/2006-December/008558.html

[2] 
http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008380.html

[3] Patches we talk about (content of 
patches-2.6.19-rc2.tar.bz2)

arm-hrt-kconfig.patch
arm-ixp4xx-clockevent.patch
arm-leds-timer.patch
arm-no-hz.patch
arm-versatile-clockevents.patch
arm-versatile-clocksource.patch -> RMK patch system
arm_omap_clockevents.patch
arm_omap_clocksource.patch  -> RMK patch system/ OMAP list
hrt-add-regs-include.patch
