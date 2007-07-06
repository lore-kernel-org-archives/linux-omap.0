From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: 2430 FB driver issues
Date: Fri, 6 Jul 2007 17:40:33 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470142EA72@dlee13.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C470142EA63@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C470142EA63@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>, nishanth menon <menon.nishanth@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

>>
>>FWIW, I have the same errors, but have not debugged it further.
>>
>
>I am not seeing any such messages and it boots happily.
>I am using u-boot 1.1.4 Apr 20 2007, PRCM 2, 2430 SDP V4.0.
>
>According to Nishanth's dump, The status shows LCD sync lost, which =
happens
>when there is no data to sync up or when DSS is operating at low =
frequency
>(not able to feed continuous data to LCD). I verified register set with
>TI's DSS drivers, every thing looks reasonable. The PCD is also proper =
(8)
>the DSS FCLK is 41.25 Mhz. I don't see any issues. If I get some time I
>will try with other board.
>

I do see some configurations that will result in Sync-Lost.

The optimal way of operating GFX pipeline is to
 - Configure GFX DMA burst size to 16x32
 - The difference between GFX HIGH-FIFO to GFX LOW-FIFO should be equal =
to DMA burst size (16x4 =3D 64).

So the Ideal configuration would have been,=20
480504A0  =3D 0000008D (GFX Attribute)
480504A4  =3D 00FF00C0 (FIFO threshold)

What's configured is:
480504A0  =3D 0000004D (GFX Attribute)
480504A4  =3D 00C00040 (FIFO threshold)

This might cause LCD sync lost. Some one can try the correct settings =
and see if this is still resulting in Sync lost interrupts. The Clock =
seems to be configured correctly.

Regards,
Khasim
