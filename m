From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] Pre 3430 patch for io.c map table cleanup
Date: Thu, 21 Jun 2007 08:12:47 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47012A5209@dlee13.ent.ti.com>
References: <20070621120333.GJ20283@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070621120333.GJ20283@atomide.com>
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

Hi Tony,

>> +#if defined(CONFIG_ARCH_OMAP2420)
>> +	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
>> +	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
>> +#elif defined(CONFIG_ARCH_OMAP2430)
>> +	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
>> +	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
>> +#endif
>>  	/* Normally devicemaps_init() would flush caches and tlb after
>>  	 * mdesc->map_io(), but we must also do it here because of the CPU
>>  	 * revision check below.
>
>You don't need the #defines here. This adds yet another artificial
>barrier to compiling in both.
>
>Use cpu_is_omap34xx() et al to init them.

We had discussion on this topic and I had communicated why defines are =
required.

Let me know your views on the same.

Regards,
Khasim

Mail attached below:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Syed =
Mohammed, Khasim
Sent: Wednesday, May 30, 2007 5:33 PM
To: Tony Lindgren
Cc: Linux OMAP
Subject: RE: [RFC] io.c for OMAP3430

Hi Tony,

>	if (cpu_is_omap24xx()) {
>		iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
>		if (cpu_is_omap242x()) {
>			iotable_init(omap242x_io_desc,
>ARRAY_SIZE(omap242x_io_desc));
>		} else if (cpu_is_omap243x()) {
>			iotable_init(omap243x_io_desc,
>ARRAY_SIZE(omap243x_io_desc));
>		}
>	} else if (cpu_is_omap34xx()) {
>		iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
>	}

We cannot put this kind of check in common_io function. I was trying to =
validate 2420 / 2430 platforms and I found that "cpu_is_" function calls =
returning "0" (when "1" was expected).=20

Basically the omap2_check_revision function which sets the system_rev =
for handling the cpu_is macro, gets called after common_io. So putting =
"cpu_is_" checks in common_io will not work.

I tried making omap2_check_revision as arch_init and sub_sysinit call =
but it didn't help, the first call for common_io happens from board =
file's map_io() and we can't avoid the same.

The other possibility is to explicitly call omap2_check_revision from =
board file's _map_io() functions. But this will have to be updated in =
many board files.

Any suggestions are appreciated.=20

For now I can post a separate patch with #ifdef's instead of if ( =
cpu_is_ ) later we can work on the correct approach.

Others please review and comment on the approach.

Regards,
Khasim
_______________________________________________
