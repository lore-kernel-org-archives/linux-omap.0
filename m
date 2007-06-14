From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 7 / 12] Proc V7 updating for OMAP3
Date: Thu, 14 Jun 2007 14:48:54 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E64E4@dlee13.ent.ti.com>
References: <20070614114755.GG28804@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070614114755.GG28804@atomide.com>
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



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Thursday, June 14, 2007 6:48 AM
>To: Syed Mohammed, Khasim
>Cc: Linux OMAP
>Subject: Re: [PATCH 7 / 12] Proc V7 updating for OMAP3
>  cr1_set:
>>  	.word	0x00c0387d
>> +#endif
>>
>>  __v7_setup_stack:
>>  	.space	4 * 11				@ 11 registers
>
<snip>

>This one should also be posted to linux-arm-kernel list for comments.
>
>Tony

OK, will do the same after these merges on OMAP GIT.

Regards,
Khasim
