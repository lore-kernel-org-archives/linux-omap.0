From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Fri, 01 Dec 2006 19:21:44 -0800
Message-ID: <1165029705.2964.9.camel@imap.mvista.com>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>
	<456F1B1E.1050305@gmail.com> <1164909003.17665.1.camel@imap.mvista.com>
	<45705464.3070105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45705464.3070105@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 2006-12-01 at 17:12 +0100, Dirk Behme wrote:

> Yes and no ;)
> 
> The Versatile and OMAP clocksource patches are in RMKs patch 
> system. The OMAP one is updated here on the list.

Updated from someone other than Kevin I assume , or myself. I saw one
clocksource driver in response to your original email that looked
nothing like the one Kevin and I worked on, is that what your referring
to?

> But as I understand Kevin, the rest has been submitted to 
> Thomas Gleixner and was planned to be included in the 
> -hrt-dyntick patcheset and then in -mm. And there I couldn't 
> find them. Would be a shame if they get lost. Especially the 
> OMAP clockevent one.

When Thomas did his -mm update all the clocksources got dropped .. Later
we resubmitted to him, but that was after hrt was included into -mm ..
It's not up to Thomas to merge OMAP, etc .. , clocksources. It's up to
us (Kevin, and myself) to submit to arch maintainers at this point. If
someone on this list has an update to our code we can resubmit to RMK,
or they can directly. Nothing should go via Thomas.

Daniel
