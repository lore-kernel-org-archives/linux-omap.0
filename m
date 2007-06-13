From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 5/12] OMAP3430 support in mach-omap2 folder
Date: Tue, 12 Jun 2007 22:47:43 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E594C@dlee13.ent.ti.com>
References: <20070612182341.GA29514@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070612182341.GA29514@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

>> > We have now common debug card interface. Check
>> > arch/arm/plat-omap/debug-devices.c and do similar calls like
>> > board-h4.c {debug_card_init}.
>>
>> For now, I would like to continue with this. I will incorporate this
>comment as a separate clean up patch.
>
>Can you please fix what Trilok suggested? Remember, we want to use
>the same patch for sending it upstream eventually.
>
I think it's not a correct approach to use debug_card_init for 2430 SDP. =
I have following view point.

1. There is no debug card on 3430 or 2430 SDP as it was on H4.

2. There will be #if's for 2430 and 3430 because many statements doesn't =
hold correct for 2430 / 3430

        smc91x_resources[0].start =3D addr + 0x300;
        smc91x_resources[0].end   =3D addr + 0x30f;

The offset address for 3430 is 0x0 and 0x0f so, one if here.

        led_resources[0].start =3D addr;
        led_resources[0].end   =3D addr + SZ_4K - 1;

These things are not required. If tomorrow we add more for 2430 / 3430 =
then this function has to be split anyway.

3. The function is exported as an extern from board.h. Which is mainly =
meant for Nokia N series, this should be corrected. Why should we =
include board.h for other boards that might not use these structures.

4. The Configuration doesn't show in Menuconfig as there is no statement =
next to bool.
	config OMAP_DEBUG_DEVICES
        bool
        help
          For debug cards on TI reference boards.

The macro CONFIG_OMAP_DEBUG_DEVICES doesn't get enabled for 2430 / 3430.

5. Having a complete debug_devices and corresponding file for 2430 / =
3430 doesn't make sense, there are no LEDs or such debug devices on =
these boards. Unfortuanely SMSC is same, so its bit confusing I believe. =
But this Ethernet controller can be handled in a much simpler way, why =
to unnecessarily complex it?

Please don't take me in a defensive mood. I am trying to convince that =
this method doesn't hold good for 2430 / 3430. And what ever we were =
doing in posted patch is a more optimal approach. But if still you feel =
that this is what has to be done, then fine, I can add more ifs and =
elses and get the code working for 2430 / 3430.

Let me know your views at the earliest.

Thanks & Regards,
Khasim
