From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP: MUSB: MUSB fix to work as Module for 24xx/Davinci
Date: Fri, 30 Nov 2007 16:43:04 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08003F30DBA@dbde01.ent.ti.com>
References: <5DF83221BE20114E9C331F665ACBC08003E7FAE3@dbde01.ent.ti.com>
	<200711291022.23735.david-b@pacbell.net>
	<5DF83221BE20114E9C331F665ACBC08003F30BB4@dbde01.ent.ti.com>
	<20071130053121.C0FFA10BA22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<5DF83221BE20114E9C331F665ACBC08003F30BEF@dbde01.ent.ti.com>
	<20071130105202.2C5F922248B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20071130105202.2C5F922248B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>> >Then the correct patch would be to set that register to zero,
>> >instead of what your patch does...
>>
>> 24XX uses the flat model as opposed to indexed and
>> so the call musb_ep_select(mbase, 0); in following code has no affect
>> for 24XX/Davinci platforms.
>
>So you're agreeing with my comment then.
Not completely

[Snip] Your Comment: =20
>> ... again arguing that the correct fix would be to set the index
>> register to zero, even when a non-indexed addressing mode is used.

CONFIGDATA is no different from any other indexed mode registers and for =
FLAT model we can access the same way as any other indexed register =
which is as follows:=20
reg =3D musb_readb(mbase, MUSB_EP_OFFSET(0, MUSB_CONFIGDATA));
