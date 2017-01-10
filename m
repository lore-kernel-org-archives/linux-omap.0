From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v5] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Mon, 9 Jan 2017 19:23:44 -0800
Message-ID: <CAJ_EiSR3aZQztVKhQsnmVQUAgdDo0mtBZZ1=9LrHGOimGr-qaA@mail.gmail.com>
References: <20170105015918.21621-1-matt@ranostay.consulting>
 <1372efd2-5319-e6c4-629e-6ed5f2e2fe29@ti.com>
 <20170109192123.GN2630@atomide.com>
 <CAJ_EiSRiSSUxDoza0a5gHuP8mvOteZ=9Mi=G91r++QUbgaXpXA@mail.gmail.com>
 <20170109215624.GQ2630@atomide.com>
 <CAJ_EiSRCBQWZfMOE-jpXVsSok3nSPwNN-+LzhBa1pcgu36UEfw@mail.gmail.com>
 <20170109235628.GR2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170109235628.GR2630@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 9, 2017 at 3:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Matt Ranostay <matt@ranostay.consulting> [170109 14:11]:
>> On Mon, Jan 9, 2017 at 1:56 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Matt Ranostay <matt@ranostay.consulting> [170109 13:46]:
>> >> On Mon, Jan 9, 2017 at 11:21 AM, Tony Lindgren <tony@atomide.com> wrote:
>> >> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [170109 05:13]:
>> >> >> On 01/05/2017 03:59 AM, Matt Ranostay wrote:
>> >> >> > We can get audio errors if hitting deeper idle states on omaps:
>> >> >> >
>> >> >> > [alsa.c:230] error: Fatal problem with alsa output, error -5.
>> >> >> > [audio.c:614] error: Error in writing audio (Input/output error?)!
>> >> >> >
>> >> >> > This seems to happen with off mode idle enabled as power for the
>> >> >> > whole SoC may get cut off between filling the McBSP fifo using DMA.
>> >> >> > While active DMA blocks deeper idle states in hardware, McBSP
>> >> >> > activity does not seem to do so.
>> >> >> >
>> >> >> > Basing the QoS latency calculation on the FIFO size, threshold,
>> >> >> > sample rate, and channels.
>> >> >>
>> >> >> Looks good to me, thank you!
>> >> >>
>> >> >> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> >> >
>> >> > Noticed the following about 10 seconds into playing an mp3 file with
>> >> > mpg123 though:
>> >> >
>> >>
>> >> Didn't notice that happening for me. But haven't rebased for the last
>> >> couple days.
>> >> Does this happen 100% of the time?
>> >
>> > Yeah seems to based on three attempts. This with 4.10.0-rc2-next-20170109.
>> >
>>
>> Ok I'll test this myself this evening and report back.
>
> Oh and this is with omap2plus_defconfig with the following also enabled:
>
> CONFIG_DEBUG_LOCKDEP=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
>

Yeah I can reproduce the issue you are mentioning. Anyone have a
suggestion how on to resolve? Guessing the QoS function calls need to
be in an atomic context and the omap_mcbsp_* functions can sleep

> Tony
