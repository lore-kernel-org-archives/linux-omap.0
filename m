From: "Choraria, Rohit" <rohitkc@ti.com>
Subject: RE: [PATCH RESEND] OMAP: DMA: Cleanup of DMA Request Lines
Date: Thu, 22 Nov 2007 19:26:39 +0530
Message-ID: <AC2D475575504148943F5EB0938951C4012D52ED@dbde01.ent.ti.com>
References: <31e679430711220357h280571f2q4769c9ac34cf14dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <31e679430711220357h280571f2q4769c9ac34cf14dd@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,=20
> Most of these ifdefs and ifndefs don't look good to me. It doesn't
> look like a problem
> keeping (for example) both:
>=20
> #define OMAP24XX_DMA_VLYNQ_TX          7       /* S_DMA_6 */
> #define OMAP24XX_DMA_EXT_DMAREQ2       7       /* S_DMA_6 */
>=20
> to look better one could make this as:
>=20
> #define OMAP24XX_DMA_VLYNQ_TX          7       /* S_DMA_6 */
> #define OMAP24XX_DMA_EXT_DMAREQ2       OMAP24XX_DMA_VLYNQ_TX =20
>      /* S_DMA_6 */
>=20
> but this is a matter of "taste".
>=20
> In any case, I think most of these pre-processor condicional
> statements can be removed,
> as long as you're not re-defining a macro with different values for
> different archs. The
> patch would look better by just adding OMAP3, i guess.
>=20
> what do you guys think ?
How about naming all the macros as OMAP_ and for each platform define as =
follows

#ifdef CONFIG_ARCH_OMAP24XX
#define OMAP_DMA_VLYNQ_TX	OMAP_24XX_DMA_VLYNQ_TX
#endif

#ifdef CONFIG_ARCH_OMAP34XX
#define OMAP_DMA_VLYNQ_TX	OMAP_34XX_DMA_VLYNQ_TX
#endif

This way the driver code will not have to change when moving from =
platform to platform.

Regards,
Rohit
