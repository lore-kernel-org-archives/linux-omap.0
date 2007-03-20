From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Fix warnings in devices.c for 2430sdp config
Date: Tue, 20 Mar 2007 11:41:09 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47833739@dlee13.ent.ti.com>
References: <20070320160540.GB8596@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070320160540.GB8596@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com, Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony,

Keypad and MMC are different from that on 2420 SDP as such. Keypad is
based on TWL4030 Keypad controller and MMC is HSMMC controller. It might
take some time to send a patch.=20

I am actually working on the Keypad one, will post a patch soon.

Regards,
Khasim

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of tony@atomide.com
>Sent: Tuesday, March 20, 2007 11:06 AM
>To: Dirk Behme
>Cc: linux-omap-open-source@linux.omap.com
>Subject: Re: [PATCH] ARM: OMAP: Fix warnings in devices.c for 2430sdp
>config
>
>* Dirk Behme <dirk.behme@googlemail.com> [070319 13:41]:
>>
>> Fix warnings
>>
>> arch/arm/plat-omap/devices.c:159: warning: 'omap_init_kp'
>> defined but not used
>> arch/arm/plat-omap/devices.c:282: warning: 'omap_init_mmc'
>> defined but not used
>> arch/arm/plat-omap/devices.c:436: warning: 'omap_init_wdt'
>> defined but not used
>> arch/arm/plat-omap/devices.c:469: warning: 'omap_init_rng'
>> defined but not used
>
>AFAIK some these devices are on 2430, so maybe somebody could
>patch them to work instead? The DSP is different from 2420 though.
>
>Tony
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
