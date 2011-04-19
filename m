From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Tue, 19 Apr 2011 18:11:00 +0900
Message-ID: <BANLkTi=dpqMFjW_B5-YsmoCJf62b8djj5g@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<201104181358.53521.arnd@arndb.de>
	<BANLkTimc20N0nh9O0FaSXizW+bYOMx9Ddw@mail.gmail.com>
	<201104181613.43572.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201104181613.43572.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 18, 2011 at 11:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 18 April 2011, Kyungmin Park wrote:
>> On Mon, Apr 18, 2011 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote=
:
>> >
>> > One missing piece is still a way for a platform to provide both
>> > the iommu and the dma-mapping API in a unified driver. Right now,
>> > you have to export both interface for a generic solution.
>>
>> Actually MSM and we (Michal, Marek) tried to merge the generic IOMMU
>> implementation into mm, but MM did't accept it.
>
> I'm confused. What do you mean with MM?
linux/mm, Memory Management.

Thank you,
Kyungmin Park
>
>> So now it's implemented at each SoCs. I think it's good chance to ma=
ke
>> a generic IOMMU feature for ARM consolidation.
>>
>> Before this idea, can you review our implementation at above URL?
>
> I've commented on the main implementation for the IOMMU now.
>
> =A0 =A0 =A0 =A0Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
