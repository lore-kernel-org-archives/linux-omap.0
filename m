From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Tue, 19 Apr 2011 21:35:56 +0900
Message-ID: <BANLkTim_30SbVhPLFOaq-KYwz5N6NGCe6A@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<201104181613.43572.arnd@arndb.de>
	<BANLkTi=dpqMFjW_B5-YsmoCJf62b8djj5g@mail.gmail.com>
	<201104191401.34818.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201104191401.34818.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 19, 2011 at 9:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 April 2011, Kyungmin Park wrote:
>> On Mon, Apr 18, 2011 at 11:13 PM, Arnd Bergmann <arnd@arndb.de> wrot=
e:
>> > On Monday 18 April 2011, Kyungmin Park wrote:
>> >> On Mon, Apr 18, 2011 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wr=
ote:
>> >> >
>> >> > One missing piece is still a way for a platform to provide both
>> >> > the iommu and the dma-mapping API in a unified driver. Right no=
w,
>> >> > you have to export both interface for a generic solution.
>> >>
>> >> Actually MSM and we (Michal, Marek) tried to merge the generic IO=
MMU
>> >> implementation into mm, but MM did't accept it.
>> >
>> > I'm confused. What do you mean with MM?
>> linux/mm, Memory Management.
>
> I'm still confused. What were you suggesting to merge in there?
> Do you have a link to a mailing list discussion?

=46irst, Zach Pfeffer <zpfeffer@codeaurora.org> sent the patch
https://patchwork.kernel.org/patch/108736/

Second, Michal tried it.
http://lkml.org/lkml/2010/9/6/41

http://lwn.net/Articles/403643/
https://patchwork.kernel.org/patch/157451/

Thank you,
Kyungmin Park

>
> =A0 =A0 =A0 =A0Arnd
>
