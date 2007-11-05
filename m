From: "Choraria, Rohit" <rohitkc@ti.com>
Subject: RE: [PATCH 1/5] mach:omap: some correction in Clock 34XX
Date: Mon, 5 Nov 2007 14:32:50 +0530
Message-ID: <AC2D475575504148943F5EB0938951C4010B0C42@dbde01.ent.ti.com>
References: <Pine.LNX.4.64.0711050021380.32372@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0711050021380.32372@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@booyaka.com>, "Ghongadematt, Girish" <girishsg@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,
  =20
> Your changes to clock34xx.h look good.  But the change to clock34xx.c=20
> isn't quite right.  The dpll_params.enable_mask field is=20
> intended to be a=20
> mask for the register's enable bits - i.e., something one would=20
> logical-AND with the shifted contents of CM_CLKEN_PLL* -=20
> rather than the=20
> value to logical-OR into those bits to indicate a locked=20
> DPLL.  The two=20
> values happen to coincide, so the change is functionally=20
> harmless; but=20
> semantically, not what was intended for the enable_mask=20
> field.  Would you=20
> care to resubmit the patch with the clock34xx.c change dropped?
>=20

When we were debugging the clock code, we found that the change in =
clock.c was required to reflect the correct rate of dpll4_x2_ck.

 	v =3D cm_read_reg(dd->control_reg) & dd->enable_mask;
 -	if (v !=3D DPLL_LOCKED)
 +	if (v !=3D dd->enable_mask)
 		clk->rate =3D clk->parent->rate;
 	else
 		clk->rate =3D clk->parent->rate * 2;

Previously, DPLL_LOCKED was defined as 0x7 - this worked for DPLL3 but =
for DPLL4, the value is supposed to be 0x7000.=20

If there was an enable_bit in dpll_data structure, we could have shifted =
DPLL_LOCKED by enable_bit and compared with the register value.
Since the current implementation will return wrong rate for DPLL4, we =
made this modification.=20
Can you suggest some other way of implementing this.

Regards,
Rohit
