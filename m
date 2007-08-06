From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: RE: Git tree updated to 2.6.23-rc2
Date: Tue, 7 Aug 2007 08:17:12 +0900
Message-ID: <006001c7d87f$f0d055e0$e1ac580a@swcenter.sec.samsung.co.kr>
References: <20070806125225.GA2312@atomide.com>
	<5d5443650708060626j18300bedxf3dea1cd324ba2cc@mail.gmail.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <5d5443650708060626j18300bedxf3dea1cd324ba2cc@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Trilok Soni' <soni.trilok@gmail.com>, 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,
> >
> > I've just updated our git tree to 2.6.23-rc2. Thanks to Trilok, now
> > the omap framebuffer code is integrated to the mainline kernel :)
> >
> > There are quite a few pending patches, I will be looking at them
> > this week.
> 
> Currently mainline kernel for omap2 is broken if you enable menelaus,
> as pdata structure from menelaus.h is not submitted, and omap mmc also
> fails to build.
> 
> Also H4 doesn't boot, as L4 entry is missing from io.c in mainline kernel.
> 

Also Apollon can't compile and doesn't boot. There is mismatch between arch/arm/mach-omap2/* and
include/asm-arm/arch-omap/*.

I'm waiting for merging the omap tree with mainline tree.

Thank you,
Kyungmin Park
