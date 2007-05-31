From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 5/11] Adding OMAP3430 support to mach-omap2
Date: Wed, 30 May 2007 22:29:17 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701062EC9@dlee13.ent.ti.com>
References: <465E1E55.2060001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <465E1E55.2060001@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>, Khem Raj <kraj@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Khem,

Khem Raj stated on 5/30/2007 12:02 PM:
>> OMAP3430 being a omap3 family shouldn't this be be added in
>> arch/arm/mach-omap3?
>>
>The files can either be reused from plat-omap or mach-omap2. 3430
>closely follows 2420->2430 family line and adds more features and a new
>ARM core (slightly unlike the jump in features from 1710->2420). IMHO,
>does not make sense to call it mach-omap3..

Few more thoughts:

Internally in TI we did start of by creating a new directory for OMAP3 =
mach-omap3. But dropped later, the issues with creating a new directory =
are:

1. Getting this new directory created on main line needs some proper =
justification. As Nishanth mentioned the jump is not like 1710 to 2420.
2. We have plat-omap to handle common parts.
3. OMAP3 has a different ARM core but peripherals as such are same with =
few additional blocks like 3 I2Cs 4 SPIs, 5 McBPs etc. Lot of new =
features are added to existing blocks like DSI for DSS, Sidetone =
capability for McBSP etc. GFX component has been upgraded to a newer =
version. But these don't need a separate mach-omap3 directory.
4. The major difference is for Camera ISP and PRCM. These two blocks are =
completely new and we might have to add few new files (apart from actual =
drivers) to get them functional.

I believe I have clarified your query. Please feel free to comment on =
approach, we can follow an optimal one.

Regards,
Khasim
