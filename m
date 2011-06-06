From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
Date: Mon, 06 Jun 2011 16:25:02 -0700
Message-ID: <87y61etuep.fsf@ti.com>
References: <1307214239-16316-1-git-send-email-ccross@android.com>
	<BANLkTingmUNvZO_szivRkmn7LRO4L5A+5Q@mail.gmail.com>
	<87r576wpz6.fsf@ti.com> <20110606230522.GA16590@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110606230522.GA16590@google.com> (Todd Poynor's message of
	"Mon, 6 Jun 2011 16:05:22 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: l-o <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Colin Cross <ccross@android.com>
List-Id: linux-omap@vger.kernel.org

Todd Poynor <toddpoynor@google.com> writes:

> On Mon, Jun 06, 2011 at 03:32:29PM -0700, Kevin Hilman wrote:
>> Colin Cross <ccross@android.com> writes:
>>=20
>> > On Sat, Jun 4, 2011 at 12:03 PM, Colin Cross <ccross@android.com> =
wrote:
>> >> Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
>> >> causing only the last bit set to take effect, resulting in lost
>> >> wakeups when the GPIO controller is in idle.
>> >>
>> >> Replace direct writes to IRQWAKEN with writes to SETWKUENA and
>> >> CLEARWKUEN.
>> >>
>> >> Signed-off-by: Colin Cross <ccross@android.com>
>>=20
>> [...]
>>=20
>> >
>> > Todd pointed out that the OMAP4 TRM says not to use SETWKUENA and
>> > CLEARWKUENA. =20
>>=20
>> In my GPIO cleanups, I was wondering why the set/clear registers wer=
e
>> not used here. Todd, can you give the TRM version & reference for th=
is?
>> I didn't find anything after a quick scan/search.
>
> http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?template=
Id=3D6123&navigationId=3D12037
>
> OMAP4460 Multimedia Device Silicon Revision 1.0 Version E
> February 2011=E2=80=93Revised May 2011
>
> p. 5357 Table 25-68. GPIO_CLEARWKUPENA
>
> "Caution: This register is kept for backward software compatibility. =
Use
> GPIO_IRQWAKEN_0 and GPIO_IRQWAKEN_1 instead."

OK, I see it now.

Thanks,

Kevin
