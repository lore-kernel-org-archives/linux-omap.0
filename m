From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 5/11] Adding OMAP3430 support to mach-omap2
Date: Tue, 29 May 2007 12:33:27 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF1167@dlee13.ent.ti.com>
References: <20070529164859.GA26322@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070529164859.GA26322@atomide.com>
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

>>  clock_34xx.c | 1255
>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
><snip>
>
>Well clock_34xx.c can be merged to existing clock.c. With Pau's PRCM
>patches, only few registers are different now.
>

Can we keep this for now? We can start a different thread for Clock and =
PRCM for 3430. It will take a while before it gets stabilized. Mean =
while can we get 3430 booting in tree.

>>  void __init omap2_check_revision(void)
>> @@ -119,7 +119,11 @@ void __init omap2_check_revision(void)
>>  	system_rev |=3D rev << 8;
>>
>>  	/* Add the cpu class info (24xx) */
>> +#ifndef CONFIG_ARCH_OMAP3
>>  	system_rev |=3D 0x24;
>> +#else
>> +	system_rev |=3D 0x34;
>> +#endif
>>
>>  	pr_info("OMAP%04x", system_rev >> 16);
>>  	if ((system_rev >> 8) & 0x0f)
>
>This is yet another artificial barrier to compile in many revisions,
>let's try to avoid that. You should be able to set system_rev based
>on the hardware register values.

The current 3430 version doesn't populate these kind of registers, we =
have to wait for a while for second version. Till then we have to use =
this kind of mechanism. The 2430 ones support these registers, but it =
will be a different patch to deal with. For, 3430 I will prefer keeping =
same thing for a while.

Regards,
Khasim
