From: "andrew chalmers" <achalmers@ellex.com>
Subject: RE: OMAP5912 & kernel 2.4 MMC driver support.
Date: Tue, 27 Jun 2006 17:20:01 +0930
Message-ID: <F886F08A2006F7478D83B2249BDD97578E3D63@ellex-adc1.ellexmedical.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrew chalmers <achalmers@ellex.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Just figured out my interrupt problem.
The enable_irq()/disable_irq()'s are not balanced properly.

Now I have lots of timeout errors to sort out.

Regards,
Andrew Chalmers.

> -----Original Message-----
> From: andrew chalmers=20
> Sent: Tuesday, 27 June 2006 5:08 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: OMAP5912 & kernel 2.4 MMC driver support.
>=20
>=20
> I'm looking for some help getting the MMC support working on=20
> our OMAP5912 system. We have a custom board based on the=20
> OSK5912, and we're using the Montavista preview kit (kernel=20
> 2.4.20-mvl3).
>=20
> I have enable the OMAP MMC support in the kernel and modified=20
> the existing omap_mmc.c 1510 support to work for the 5912=20
> (ala 1610) using the MMC1. However I'm not having much luck=20
> with the MMC interrupts (i.e. I'm not getting any). The reset=20
> command completes but I don't get the MMC1 interrupt even=20
> though I have enabled it in the MMC.
>=20
> # insmod mmc_base
> mmc_init
> mmc_media_init
> # insmod /mnt/andrew/omap_mmc.o
> mmc_register_slot_driver max=3D1 ocr=3D0x00ffc000
> omap_mmc_slot_init
> omap_mmc_slot_up
> mmc_insert: 0
> omap_mmc_init retval 0
> mmc_tasklet_action: dev=3Dc40c4ef0 flags=3D04
> mmc_cim_default_state
> mmc_check_eject dev state=3D4
> mmc_check_insert dev state=3D4
> mmc_cim_init_stack
> omap_mmc_set_clock: Set rate: 400000
> omap_mmc_exec_command: Send cmd: 80
>  Arg: 0
> omap_mmc_exec_command STAT=3D   0,CON=3D 878,IE=3D4181
> omap_mmc_exec_command STAT=3D   0,CON=3D 878,IE=3D4181
> # omap_mmc_fix_sd_detect card_state=3D0
> mmc_insert: 0
> omap_mmc_fix_sd_detect STAT=3D   1,CON=3D 878,IE=3D4181
> mmc_tasklet_action: dev=3Dc40c4ef0 flags=3D05
>=20
> I've also noticed that if I build the MMC driver into the=20
> kernel (not as a module) it doesn't seem to load and initialise.
>=20
> I've googled for help and discovered a few others have had=20
> the exact same problems I'm having with both the OSK5912 and=20
> the innovator. But other the 2.6 patches and an alternate MMC=20
> driver patch for linux-2.4.21-rmk1-omap1 (which I'm not yet=20
> prepared to try merging into the Montavista tree), I cannot=20
> find any advise on how fix the problem.
>=20
> Clearly others have managed to get the MMC support working=20
> under 2.4. I'm not sure if its an issue with the MMC1 vs.=20
> MMC2 or if there is something wrong with the IRQ setup in the=20
> 2.4.20-mvl3 I have.
>=20
> Can anyone offer any advise/suggestions?
>=20
> Regards,
> Andrew Chalmers
>=20
