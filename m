From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP: fix DMA vs memory ordering
Date: Mon, 23 Apr 2012 20:05:23 +0530
Message-ID: <CAMQu2gxU+uhCLqPte7qtUJ_FPZ464+zzKLtriHoEZ_MxaA+8kw@mail.gmail.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk> <20120420222230.GH21106@atomide.com>
 <20120423141924.GB24299@n2100.arm.linux.org.uk> <20120423142745.GB3739@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20120423142745.GB3739@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 23, 2012 at 7:57 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120423 07:22]:
>> On Fri, Apr 20, 2012 at 03:22:33PM -0700, Tony Lindgren wrote:
>> > * Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:14]:
>> > > Using coherent DMA memory with the OMAP DMA engine results in
>> > > unpredictable behaviour due to memory ordering issues; as things=
 stand,
>> > > there is no guarantee that data written to coherent DMA memory w=
ill be
>> > > visible to the DMA hardware.
>> > >
>> > > This is because the OMAP dma_write() accessor contains no barrie=
rs,
>> > > necessary on ARMv6 and above. =A0The effect of this can be seen =
in comments
>> > > in the OMAP serial driver, which incorrectly talks about cache f=
lushing
>> > > for the coherent DMA stuff.
>> > >
>> > > Rather than adding barriers to the accessors, add it in the DMA =
support
>> > > code just before we enable DMA, and just after we disable DMA. =A0=
This
>> > > avoids having barriers for every DMA register access.
>> > >
>> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> >
>> > Acked-by: Tony Lindgren <tony@atomide.com>
>>
>> Would you like me to push this upstream on my next -rc push (with a
>> stable tag?)
>
> Yes sounds good to me.
>
=46WIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
