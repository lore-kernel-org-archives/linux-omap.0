From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: 3.3-rc1 console lag (was: Re: [PATCH v8 00/20] OMAP2+: UART:
 Runtime adaptation + cleanup)
Date: Thu, 26 Jan 2012 18:14:59 -0600
Message-ID: <CAB-zwWiGUtDT2RszF-NLHT-pFVcPiHpdSnDdLVGRkU5YdFoztQ@mail.gmail.com>
References: <CAB-zwWg4RS4J1YCcbfMWjLSCcV=oHqk9vaUKKKr0WjnTEuOmxQ@mail.gmail.com>
 <alpine.DEB.2.00.1201252000410.11174@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1201252000410.11174@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Govindraj Raja <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Wed, Jan 25, 2012 at 9:00 PM, Paul Walmsley <paul@pwsan.com> wrote:
...
>> > Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.
>> > And for pm_qos usage ensure CONFIG_CPU_IDLE is selected other wise
>> > console might be sluggish.
>>
>> There is console lag for omap2plus_defconfig given that
>> CONFIG_CPU_IDLE is not enabled. Is the intention to force CPU_IDLE
>> into the defconfig or find an alternative for the new pm_qos when cpu
>> idle is disabled.
>>
>> Seen on beagle-xm and 3.3-rc1.
>
> Try this
>
> http://marc.info/?l=linux-arm-kernel&m=132754676814391&w=2

I tried the series and the console returned to normal, I can confirm
that the following patch helps:

tty: serial: OMAP: use a 1-byte RX FIFO threshold in PIO mode

Thanks,

Omar
