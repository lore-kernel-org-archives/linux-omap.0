From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: OMAP development on a student budget
Date: Fri, 24 Mar 2006 03:43:34 +0200
Message-ID: <44234EC6.2080407@cc.jyu.fi>
References: <CAB8FEAD-4A3A-486E-97B2-B2547FD2C9D6@flashmob.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <CAB8FEAD-4A3A-486E-97B2-B2547FD2C9D6@flashmob.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Cina Hazegh <chazegh@flashmob.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>
> I should point out, that my final goal is to provide the board layout
> and schematic in an open source fashion for other students and
> developers to learn from. Any help/information/guidance you can
> provide would be appreciated.

Hi sorry not for asking to your questions...
But a little bit related but not overlapping to your plans. Hector Oron
is working (and has already made at least one version) on Livecd that is
meant for studying the embedded development. Here is info from the
session he held in this years fosdem from the subjetc.


        13u30-14u30 SETR LiveCD : A live tool for embedded development,
        by Hector Oron

In a educational enviroment, i decided a while ago to build a Debian
LiveCD distribution, so students could play/demo a little with free
software tools for embedded systems. As a result of my work, it was born
SETR LiveCD, it is built into a CD-R and it has :

    * Cross-compiler toolchain for m68k and arm.
    * ARMulator and XCopilot: ARM & m68k emulators. With uClinux demo
      included.
    * GDB, ddd debuggers.

This was my first built, afterwards, i've been working, not so hard, on
the distro, trying to add scratchbox, uClinux sources, and probably
latest development on Emdebian project, but this is not ready to
release, yet. So, this educational distro, is trying to become a utility
for professional embedded people, and it is an open project where
everybody is welcome to add, or ask for the tools that they use or need.
Due to a hardware failure, i have lost my site, where all development
was taking place,and i'm hopping to have some time available to put it
up again. Site url: http://setr.shows.it/

Mika
