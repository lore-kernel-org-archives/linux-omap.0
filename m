From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Why does it increase the dsor value in MMC?
Date: Sun, 1 Jul 2007 22:04:31 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47013BFAF2@dlee13.ent.ti.com>
References: <002701c7bc4e$b1c70670$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <002701c7bc4e$b1c70670$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kmpark@infradead.org, Tuukka.Tikkanen@elektrobit.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

>Then how about to append the following code?
>
>/* If the dsor is zero, we increase the dsor value to enable the clock =
*/
>if (dsor =3D=3D 0)
>	dsor++;
>
>It not only assigns the correct dsor values, but also enables the other
>platform.
>

In TI's code we do the following, we don't add the extra dsor increment. =
This works for 2420 / 2430 and 3430 processors for all different types =
of MMC/SD cards.
       if (ios->clock) {
                /* Enable MMC_SD_CLK */
                dsor =3D OMAP_MMC_MASTER_CLOCK / ios->clock;
                if (dsor < 1)
                        dsor =3D 1;

                if (OMAP_MMC_MASTER_CLOCK / dsor > ios->clock)
                        dsor++;

                if (dsor > 250)
                        dsor =3D 250;
        }

As Tuukka suggested we might have to check the history and see if this =
line was mistakenly added. I was not able to browse history through =
muru.com / source.mvista.com looks like some server problem.

Regards,
Khasim
