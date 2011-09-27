From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v11] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Tue, 27 Sep 2011 18:48:35 +0530
Message-ID: <CAP05o4J75jGLTH8prOGD79Mte4DOg9ukgwe3V-KHFnB1Q-fi4w@mail.gmail.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com>
	<1316691479-1849-2-git-send-email-keshava_mgowda@ti.com>
	<1316691479-1849-3-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109221115320.10719@utopia.booyaka.com>
	<CAP05o4+Zc2z6sBOX_rQeoDQ9PneypcLRCyBbaaB2m+ZjeXZnaw@mail.gmail.com>
	<alpine.DEB.2.00.1109240020510.22872@utopia.booyaka.com>
	<CAP05o4Lwk2uUz5ou84GQsrsBdjW-FEYP-55pBzH+a74hP4g1Dw@mail.gmail.com>
	<cbad72cea703d117067f7c628f7db806@mail.gmail.com>
	<1317127327.3820.31.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317127327.3820.31.camel@sokoban>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, "Balbi, Felipe" <balbi@ti.com>, parthab@india.ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Gadiyar, Anand" <gadiyar@ti.com>, sameo@linux.intel.com, tony@atomide.com, "Hilman, Kevin" <khilman@ti.com>, johnstul@us.ibm.com, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 27, 2011 at 6:12 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Tue, 2011-09-27 at 08:04 +0200, Basak, Partha wrote:
>> >
> Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040=
-6. Kotipaikka: Helsinki
>
> -----Original Message-----
>
>> >From: Munegowda, Keshava [mailto:keshava_mgowda@ti.com]
>> >Sent: Monday, September 26, 2011 7:49 PM
>> >To: Paul Walmsley; Tero Kristo; b-cousson@ti.com; balbi@ti.com;
>> >parthab@india.ti.com
>> >Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; linux-
>> >kernel@vger.kernel.org; gadiyar@ti.com; sameo@linux.intel.com;
>> >tony@atomide.com; khilman@ti.com; johnstul@us.ibm.com;
>> >vishwanath.bs@ti.com
>> >Subject: Re: [PATCH 2/5 v11] arm: omap: usb: ehci and ohci hwmod
>> >structures for omap3
>> >
>> >On Sat, Sep 24, 2011 at 12:00 PM, Paul Walmsley <paul@pwsan.com> wr=
ote:
>> >> On Fri, 23 Sep 2011, Munegowda, Keshava wrote:
>> >>
>> >>> On Thu, Sep 22, 2011 at 11:31 PM, Paul Walmsley <paul@pwsan.com>
>> >wrote:
>> >>>
>> >>> But the question arises here , why do we need these ehci and ohc=
i as
>> >two
>> >>> different hwmods containing only irq and base address? It is req=
uired
>> >>> for future - to implement remote wakeup feature for ehci and ohc=
i
>> >ports
>> >>> depending on irq-chain handler patches by Tero. Separate hwmods =
for
>> >ehci
>> >>> and ohci are needed to enable prcm chain-handler to uniquely ide=
ntify
>> >>> the wakeup source as ehci or ohci and call only the correspondin=
g
>> >>> interrupt handler. We will be using omap_hwmod_mux_init for ehci=
 and
>> >>> ohci hwmods to enable I/O wakeup capability for respective IO-pa=
ds.
>> >>> Depending on the particular wakeup source(ehci/ohci), the
>> >corresponding
>> >>> ehci or ohci irq handler will be called.
>> >>>
>> >>> If ehci and ohci are combined with usbhs hwmod as a single hwmod=
 ,
>> >then
>> >>> for every wakeup (either ehci or ohci port wakeup) only the firs=
t
>> >>> interrupt handler will be called (please look at the function
>> >>> omap_hwmod_mux_handle_irq of
>> >>>
>> >>> /arch/arm/mach-omap2/mux.c file ; in tero's latest patch:
>> >>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg53139.=
html)
>> >>> , so in this
>> >>> case, if ehci interrupt is the first interrupt , then even for o=
hci
>> >wakeup
>> >>> , only ehci interrupt will get called; which will break the
>> >functionality.
>> >>
>> >> Any reason why this couldn't be handled either by:
>> >>
>> >> 1. adding an IRQ number field to struct omap_hwmod_mux_info, and
>> >changing
>> >> _omap_hwmod_mux_handle_irq() to raise that IRQ number?
>> >
>> >
>> >yes, it is possible by changing the existing irq-chain handler by t=
ero
>> >Kristo
>> >
>> >I am looping tero too.
>> >
>> >So here are new requirements for the irq-chain handler
>> >
>> >1. The hwmod should have have option to have multiple mux structure=
s
>> >
>> >This is something like:
>> >
>> >The existing mux structure definition in omap_hwmod [file:
>> >/arch/arm/plat-omap/include/plat/omap_hwmod.h ] structure
>> >
>> > =A0 =A0 struct omap_hwmod_mux_info =A0 =A0 =A0*mux;
>> >
>> >it should changed to
>> >
>> > =A0 =A0 struct omap_hwmod_mux_info =A0 =A0 =A0**pmux;
>> > =A0 =A0 =A0 =A0 U32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mux_cnt;
>> >
>> >
>> >pmux - pointers to mux ; array of mux structures.
>> >mux_cnt - number of mux per hwmod.
>> >
>> >
>> >2. The mux =A0omap_hwmod_mux_info =A0structure should have new memb=
er
>> >called irq, like as follows:
>> >
>> >struct omap_hwmod_mux_info {
>> > =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 nr_pads;
>> > =A0 =A0 ...
>> > =A0 =A0 =A0 =A0....
>> > =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 irq;
>> >
>> >};
>> >
>> >Upon wakeup of the I/O pad of the mux , the irq-chain handler shoul=
d
>> >invoke the irq handler of the irq numbered <map_hwmod_mux_info.irq>
>> >
>> >3. =A0There should be "SOME WAY" to supply the irqs =A0from hwmod
>> >structure (omap_hwmod) to mux structure (omap_hwmod_mux_info)
>> >
>> >
>> >if you , tero and other opensource people are aligned on the propos=
ed
>> >changes on the irq-handler ;
>> >then it is possible to have two hwmods ( usbhs and tll) for usbhost
>> >driver.
>> >please let me know you comments on the above approach.
>> >
>>
>> Hello Tero,
>>
>> I would like to draw your attention to the following thread:
>>
>> We need to support the following:
>> 1. Ability to associate multiple mux info to a hwmod.
>> 2. Able to associate a particular irq handler to a mux info.
>> 3. PRCM Chain handler should loop through all mux-info arrays
>> =A0 =A0for a particular hwmod to identify the possible wakeup source=
(s)
>> =A0 =A0and call the appropriate irq handler for that mux-info.
>> =A0 =A0(It is possible that both mux-info are woken up in which case=
 both
>> handlers should be called).
>>
>> To give you a little more perspective, EHCI & OHCI are co-controller=
s
>> under UHH/TLL.
>> They do not get presented separately to the OCP bus, hence do not qu=
alify
>> as separate hwmods
>> (Paul had objected to the design approach representing EHCI & OHCI a=
s
>> different hwmods).
>>
>> However, we need a mechanism to efficiently identify/distinguish
>> remote-wakeup, connect/disconnect
>> On to an EHCI port vs an OHCI port & call only the correct interrupt
>> handler(EHCI or OHCI).
>>
>> =A0To incorporate this, chain handler implementation would need some
>> enhancements.
>> =A0We can look into the details in the next merge window cycle in
>> conjunction with aggressive clock management support for EHCI/OHCI.
>> =A0But fundamentally, if you are aligned to the approach, we can go =
ahead
>> collapsing the EHCI & OHCI hwmods into one.
>
> Hi,
>
> So, you would need a mechanism to do something like this:
>
> pad a or b wakeup detected -> irq0
> pad c or d wakeup detected -> irq1?

yes, if get something like this , its perfect.


>
> Is it okay to do this:
>
> pad a...d wakeup -> irq0 and irq1?

No, we dont need multiple irq handlers for single wakeup source.

>
> I am okay doing something like this, we just need to agree how this
> would be represented from the hwmod point of view. Currently the chai=
n
> handler set does not change hwmod structures at all to provide what i=
t
> does.

paul and benoit are the people to design the mechanisam for this.

paul/Benoit
            please give you thoughts on this.

regards
keshava


>
> -Tero
>
>> >
>> >>
>> >> or
>> >>
>> >> 2. using shared interrupts?
>> >>
>> >>
>> >> - Paul
>> >>
>
>
>
