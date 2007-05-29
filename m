From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 11/11] OMAP 3430 support in include/arm/arch-omap
Date: Tue, 29 May 2007 13:08:30 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF11B8@dlee13.ent.ti.com>
References: <5d5443650705282357w1e67ff00gdb6ac3158fb7d1bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <5d5443650705282357w1e67ff00gdb6ac3158fb7d1bd@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

>> +++ val_3430_GIT/include/asm-arm/arch-omap/serial.h     2007-05-25
>22:59:27.000000000 -0500
>> @@ -20,6 +20,11 @@
>>  #define OMAP_UART1_BASE                0x4806a000
>>  #define OMAP_UART2_BASE                0x4806c000
>>  #define OMAP_UART3_BASE                0x4806e000
>> +#elif defined(CONFIG_ARCH_OMAP3)
>> +/* OMAP3 serial ports */
>> +#define OMAP_UART1_BASE                0x4806a000
>> +#define OMAP_UART2_BASE                0x4806c000
>> +#define OMAP_UART3_BASE                0x49020000
>>  #endif
>
>Why not just #ifdefing UART3, as it is the only differs in base =
address.?
>

Tried, Looks more confusing, shown below for example:

#if defined(CONFIG_ARCH_OMAP1)
/* OMAP1 serial ports */
#define OMAP_UART1_BASE         0xfffb0000
#define OMAP_UART2_BASE         0xfffb0800
#define OMAP_UART3_BASE         0xfffb9800

#elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
/* OMAP2 and OMAP3 serial ports */
#define OMAP_UART1_BASE         0x4806a000
#define OMAP_UART2_BASE         0x4806c000

#if defined(CONFIG_ARCH_OMAP2)
#define OMAP_UART3_BASE         0x4806e000
#elif defined(CONFIG_ARCH_OMAP3)
#define OMAP_UART3_BASE         0x49020000
#endif

#endif

The previous one is better and easier to understand, so keeping the same =
:)

Regards,
Khasim
