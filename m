From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 2/12] head.S changes to CPU ID
Date: Thu, 14 Jun 2007 14:38:11 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E64C6@dlee13.ent.ti.com>
References: <20070614114035.GD28804@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070614114035.GD28804@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,
>> -		.word	0x000f0000		@ new CPU Id
>> -		.word	0x000f0000
>> +		.word	0x000fc000		@ new CPU Id
>> +		.word	0x000ff000
>>  		b	__armv7_mmu_cache_on
>>  		b	__armv7_mmu_cache_off
>>  		b	__armv7_mmu_cache_flush
>
>This you should also send to linux-arm-kernel list.
OK, I will post them after getting it on OMAP GIT.

>Should the comment above be changed to ARMv7 from "new CPU Id"?
>
I have to revisit this file as merge from ARM GIT has broken kernel =
based Un-compressing for ARMV7. I will think about proper comment along =
with this.

Regards,
Khasim
