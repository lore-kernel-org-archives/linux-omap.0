From: Ameya Palande <2ameya@gmail.com>
Subject: Re: [UPDATE][PATCH 2/2][OMAPZOOM] DSPBRIDGE: Change address resources
	to void __iomem *Hi
Date: Mon, 2 Mar 2009 15:00:22 +0200
Message-ID: <269694c00903020500g3eaa4466x281d07a1bb7e2b7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:25069 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZCBNA0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 08:00:26 -0500
Received: by nf-out-0910.google.com with SMTP id d21so492055nfb.21
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 05:00:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 25, 2009 at 2:17 AM, Guzman Lugo, Fernando <x0095840@ti.com=
> wrote:
> From 708b2a4a434408e2d5325aa360ffb2cd57bc6bd1 Mon Sep 17 00:00:00 200=
1
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Mon, 23 Feb 2009 18:12:27 -0600
> Subject: [PATCH] DSPBRIDGE: Change address resources to void __iomem =
*
>
> This patch changes address resources to void __iomem *
> Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
> ---
> =C2=A0arch/arm/plat-omap/include/dspbridge/cfgdefs.h | =C2=A0 16 ++++=
----
> =C2=A0drivers/dsp/bridge/hw/hw_dspssC64P.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0drivers/dsp/bridge/hw/hw_dspssC64P.h =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0drivers/dsp/bridge/hw/hw_mbox.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 30 +++++++------
> =C2=A0drivers/dsp/bridge/hw/hw_mbox.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 18 ++++----
> =C2=A0drivers/dsp/bridge/hw/hw_mmu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 43 ++++++++++----------
> =C2=A0drivers/dsp/bridge/hw/hw_mmu.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 30 +++++++-------
> =C2=A0drivers/dsp/bridge/hw/hw_prcm.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 26 ++++++------
> =C2=A0drivers/dsp/bridge/hw/hw_prcm.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 17 ++++----
> =C2=A0drivers/dsp/bridge/rmgr/drv.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 52 ++++++++++++------------
> =C2=A0drivers/dsp/bridge/rmgr/node.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0drivers/dsp/bridge/wmd/_tiomap.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0drivers/dsp/bridge/wmd/tiomap3430.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 47 ++++++++++-----------
> =C2=A013 files changed, 145 insertions(+), 142 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/ar=
m/plat-omap/include/dspbridge/cfgdefs.h
> index ca96b3c..e7633b5
> --- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
> +++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
> @@ -96,14 +96,14 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dwChnlOffs=
et;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dwChnlBufS=
ize;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dwNumChnls=
;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwPrmBase;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwCmBase;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwPerBase;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwWdTimerDspBa=
se;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwMboxBase;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwDmmuBase;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwDipiBase;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 dwSysCtrlBase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *dwPr=
mBase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *dwCm=
Base;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *dwPe=
rBase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *dwWd=
TimerDspBase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *dwMb=
oxBase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *dwDm=
muBase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *dwDipiBase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *dwSy=
sCtrlBase;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} ;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct CFG_DSPMEMDESC {
> diff --git a/drivers/dsp/bridge/hw/hw_dspssC64P.c b/drivers/dsp/bridg=
e/hw/hw_dspssC64P.c
> index 0d0d45c..6aac57d
> --- a/drivers/dsp/bridge/hw/hw_dspssC64P.c
> +++ b/drivers/dsp/bridge/hw/hw_dspssC64P.c
> @@ -34,7 +34,7 @@
> =C2=A0#include <IPIAccInt.h>
>
> =C2=A0/* HW FUNCTIONS */
> -HW_STATUS HW_DSPSS_BootModeSet(const u32 baseAddress,
> +HW_STATUS HW_DSPSS_BootModeSet(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0enum HW_DSPSYSC_BootMode_t bootMode,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const u32 bootAddress)
> =C2=A0{
> diff --git a/drivers/dsp/bridge/hw/hw_dspssC64P.h b/drivers/dsp/bridg=
e/hw/hw_dspssC64P.h
> index 493effd..50f9af4
> --- a/drivers/dsp/bridge/hw/hw_dspssC64P.h
> +++ b/drivers/dsp/bridge/hw/hw_dspssC64P.h
> @@ -41,7 +41,7 @@
>
> =C2=A0#define HW_DSP_IDLEBOOT_ADDR =C2=A0 0x007E0000
>
> - =C2=A0 =C2=A0 =C2=A0 extern HW_STATUS HW_DSPSS_BootModeSet(const u3=
2 baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 extern HW_STATUS HW_DSPSS_BootModeSet(const vo=
id __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
num HW_DSPSYSC_BootMode_t bootMode,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
onst u32 bootAddress);
>
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/=
hw_mbox.c
> index bc61d64..93fa51e
> --- a/drivers/dsp/bridge/hw/hw_mbox.c
> +++ b/drivers/dsp/bridge/hw/hw_mbox.c
> @@ -36,7 +37,7 @@
> =C2=A0struct MAILBOX_CONTEXT mboxsetting =3D {0x4, 0x1, 0x1};
>
> =C2=A0/* Saves the mailbox context */
> -HW_STATUS HW_MBOX_saveSettings(u32 baseAddress)
> +HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddress)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
>
> @@ -50,7 +51,7 @@ HW_STATUS HW_MBOX_saveSettings(u32 baseAddress)
> =C2=A0}
>
> =C2=A0/* Restores the mailbox context */
> -HW_STATUS HW_MBOX_restoreSettings(u32 baseAddress)
> +HW_STATUS HW_MBOX_restoreSettings(void __iomem *baseAddress)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Restor IRQ enable status */
> @@ -65,8 +66,8 @@ HW_STATUS HW_MBOX_restoreSettings(u32 baseAddress)
>
> =C2=A0/* Reads a u32 from the sub module message box Specified. if th=
ere are no
> =C2=A0* messages in the mailbox then and error is returned. */
> -HW_STATUS HW_MBOX_MsgRead(const u32 baseAddress, const HW_MBOX_Id_t =
mailBoxId,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *const pReadValue)
> +HW_STATUS HW_MBOX_MsgRead(const void __iomem *baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 const HW_MBOX_Id_t mailBoxId, u32 *const pRead=
Value)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
>
> @@ -86,8 +87,8 @@ HW_STATUS HW_MBOX_MsgRead(const u32 baseAddress, co=
nst HW_MBOX_Id_t mailBoxId,
> =C2=A0}
>
> =C2=A0/* Writes a u32 from the sub module message box Specified. */
> -HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddress, const HW_MBOX_Id_t=
 mailBoxId,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const u32 writeValue)
> +HW_STATUS HW_MBOX_MsgWrite(const void __iomem *baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 const HW_MBOX_Id_t mailBoxId, const u32 writeV=
alue)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
>
> @@ -105,8 +106,8 @@ HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddress,=
 const HW_MBOX_Id_t mailBoxId,
> =C2=A0}
>
> =C2=A0/* Reads the full status register for mailbox. */
> -HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t m=
ailBoxId,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 u32 *const pIsFull)
> +HW_STATUS HW_MBOX_IsFull(const void __iomem *baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 const HW_MBOX_Id_t mailBoxId, u32 *const pIsFu=
ll)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 fullStatus;
> @@ -130,8 +131,8 @@ HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, c=
onst HW_MBOX_Id_t mailBoxId,
> =C2=A0}
>
> =C2=A0/* Gets number of messages in a specified mailbox. */
> -HW_STATUS HW_MBOX_NumMsgGet(const u32 baseAddress, const HW_MBOX_Id_=
t mailBoxId,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *const pNumMsg)
> +HW_STATUS HW_MBOX_NumMsgGet(const void __iomem *baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 const HW_MBOX_Id_t mailBoxId, u32 *const pNumM=
sg)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
>
> @@ -152,7 +153,7 @@ HW_STATUS HW_MBOX_NumMsgGet(const u32 baseAddress=
, const HW_MBOX_Id_t mailBoxId,
> =C2=A0}
>
> =C2=A0/* Enables the specified IRQ. */
> -HW_STATUS HW_MBOX_EventEnable(const u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
aseAddress,
> +HW_STATUS HW_MBOX_EventEnable(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const HW_MBOX_Id_t mailBoxId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const HW_MBOX_UserId_t userId=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const u32 events)
> @@ -192,7 +193,7 @@ HW_STATUS HW_MBOX_EventEnable(const u32 =C2=A0 =C2=
=A0 baseAddress,
> =C2=A0}
>
> =C2=A0/* Disables the specified IRQ. */
> -HW_STATUS HW_MBOX_EventDisable(const u32 baseAddress,
> +HW_STATUS HW_MBOX_EventDisable(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const HW_MBOX_Id_t mailBoxId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const HW_MBOX_UserId_t userId=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const u32 events)
> @@ -226,8 +227,9 @@ HW_STATUS HW_MBOX_EventDisable(const u32 baseAddr=
ess,
> =C2=A0}
>
> =C2=A0/* Sets the status of the specified IRQ. */
> -HW_STATUS HW_MBOX_EventAck(const u32 baseAddress, const HW_MBOX_Id_t=
 mailBoxId,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const HW_MBOX_UserId_t userId, const u32 event)
> +HW_STATUS HW_MBOX_EventAck(const void __iomem *baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 const HW_MBOX_Id_t mailBoxId, const HW_MBOX_Us=
erId_t userId,
> + =C2=A0 =C2=A0 =C2=A0 const u32 event)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 irqStatusReg;
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/=
hw_mbox.h
> index 225fb40..5d3d18f
> --- a/drivers/dsp/bridge/hw/hw_mbox.h
> +++ b/drivers/dsp/bridge/hw/hw_mbox.h
> @@ -92,7 +92,7 @@ struct MAILBOX_CONTEXT {
> =C2=A0* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 box Specifie=
d. if there are no messages in the mailbox
> =C2=A0* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then and err=
or is returned.
> =C2=A0*/
> -extern HW_STATUS HW_MBOX_MsgRead(const u32 baseAddress,
> +extern HW_STATUS HW_MBOX_MsgRead(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const HW_MBOX_Id_t mailBoxId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *const pReadValue);
>
> @@ -124,7 +124,7 @@ extern HW_STATUS HW_MBOX_MsgRead(const u32 baseAd=
dress,
> =C2=A0* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 box Specifie=
d.
> =C2=A0*/
> =C2=A0extern HW_STATUS HW_MBOX_MsgWrite(
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const u32 =C2=A0baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const HW_MBOX_Id_t =C2=A0 mailBoxId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const u32 =C2=A0writeValue
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);
> @@ -159,7 +159,7 @@ extern HW_STATUS HW_MBOX_MsgWrite(
> =C2=A0* PURPOSE: =C2=A0 =C2=A0 =C2=A0: this function reads the full s=
tatus register for mailbox.
> =C2=A0*/
> =C2=A0extern HW_STATUS HW_MBOX_IsFull(
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const u32 =C2=A0baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const HW_MBOX_Id_t =C2=A0 mailBoxId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0u32 *const =C2=A0 =C2=A0 =C2=A0 =C2=A0pIsFull
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);
> @@ -193,7 +193,7 @@ extern HW_STATUS HW_MBOX_IsFull(
> =C2=A0* PURPOSE: =C2=A0 =C2=A0 =C2=A0: this function gets number of m=
essages in a specified mailbox.
> =C2=A0*/
> =C2=A0extern HW_STATUS HW_MBOX_NumMsgGet(
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const u32 =C2=A0baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const void =C2=A0 =C2=A0 =C2=A0 =C2=A0 __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const HW_MBOX_Id_t =C2=A0 mailBoxId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0u32 *const =C2=A0 =C2=A0 =C2=A0 =C2=A0pNumMsg
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);
> @@ -229,7 +229,7 @@ extern HW_STATUS HW_MBOX_NumMsgGet(
> =C2=A0* PURPOSE: =C2=A0 =C2=A0 =C2=A0: this function enables the spec=
ified IRQ.
> =C2=A0*/
> =C2=A0extern HW_STATUS HW_MBOX_EventEnable(
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const u32 =C2=A0 =C2=A0 =C2=A0baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const HW_MBOX_Id_t =C2=A0 =C2=A0 =C2=A0 mailBoxId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const HW_MBOX_UserId_t =C2=A0 userId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const u32 =C2=A0 =C2=A0 =C2=A0events
> @@ -266,7 +266,7 @@ extern HW_STATUS HW_MBOX_EventEnable(
> =C2=A0* PURPOSE: =C2=A0 =C2=A0 =C2=A0: this function disables the spe=
cified IRQ.
> =C2=A0*/
> =C2=A0extern HW_STATUS HW_MBOX_EventDisable(
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const u32 =C2=A0 =C2=A0 =C2=A0baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const HW_MBOX_Id_t =C2=A0 =C2=A0 =C2=A0 mailBoxId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const HW_MBOX_UserId_t =C2=A0 userId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const u32 =C2=A0 =C2=A0 =C2=A0events
> @@ -305,7 +305,7 @@ extern HW_STATUS HW_MBOX_EventDisable(
> =C2=A0* PURPOSE: =C2=A0 =C2=A0 =C2=A0: this function sets the status =
of the specified IRQ.
> =C2=A0*/
> =C2=A0extern HW_STATUS HW_MBOX_EventAck(
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const u32 =C2=A0 =C2=A0 =C2=A0 baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const void =C2=A0 =C2=A0 =C2=A0 =C2=A0__iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const HW_MBOX_Id_t =C2=A0 =C2=A0 =C2=A0 =C2=A0mailBoxId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const HW_MBOX_UserId_t =C2=A0 =C2=A0userId,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const u32 =C2=A0 =C2=A0 =C2=A0 event
> @@ -331,7 +331,7 @@ extern HW_STATUS HW_MBOX_EventAck(
> =C2=A0*
> =C2=A0* PURPOSE: =C2=A0 =C2=A0 =C2=A0: this function saves the contex=
t of mailbox
> =C2=A0*/
> -extern HW_STATUS HW_MBOX_saveSettings(u32 =C2=A0 =C2=A0baseAddres);
> +extern HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddres);
>
> =C2=A0/*
> =C2=A0* FUNCTION =C2=A0 =C2=A0 =C2=A0: HW_MBOX_restoreSettings
> @@ -353,6 +353,6 @@ extern HW_STATUS HW_MBOX_saveSettings(u32 =C2=A0 =
=C2=A0baseAddres);
> =C2=A0*
> =C2=A0* PURPOSE: =C2=A0 =C2=A0 =C2=A0: this function restores the con=
text of mailbox
> =C2=A0*/
> -extern HW_STATUS HW_MBOX_restoreSettings(u32 =C2=A0 =C2=A0baseAddres=
);
> +extern HW_STATUS HW_MBOX_restoreSettings(void __iomem *baseAddres);
>
> =C2=A0#endif =C2=A0/* __MBOX_H */
> diff --git a/drivers/dsp/bridge/hw/hw_mmu.c b/drivers/dsp/bridge/hw/h=
w_mmu.c
> index da7e092..3f2b75c
> --- a/drivers/dsp/bridge/hw/hw_mmu.c
> +++ b/drivers/dsp/bridge/hw/hw_mmu.c
> @@ -30,6 +30,7 @@
> =C2=A0*/
>
> =C2=A0#include <GlobalTypes.h>
> +#include <linux/io.h>
> =C2=A0#include "MMURegAcM.h"
> =C2=A0#include <hw_defs.h>
> =C2=A0#include <hw_mmu.h>
> @@ -79,7 +80,7 @@ enum HW_MMUPageSize_t {
> =C2=A0* METHOD: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : Check the=
 Input parameter and Flush a
> =C2=A0* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 single entry in the TLB.
> =C2=A0*/
> -static HW_STATUS MMU_FlushEntry(const u32 baseAddress);
> +static HW_STATUS MMU_FlushEntry(const void __iomem *baseAddress);
>
> =C2=A0/*
> =C2=A0* FUNCTION =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : MMU_SetCAMEntry
> @@ -121,7 +122,7 @@ static HW_STATUS MMU_FlushEntry(const u32 baseAdd=
ress);
> =C2=A0*
> =C2=A0* METHOD: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: Che=
ck the Input parameters and set the CAM entry.
> =C2=A0*/
> -static HW_STATUS MMU_SetCAMEntry(const u32 =C2=A0 =C2=A0baseAddress,
> +static HW_STATUS MMU_SetCAMEntry(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u32 =C2=A0 =C2=A0=
pageSize,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u32 =C2=A0 =C2=A0=
preservedBit,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u32 =C2=A0 =C2=A0=
validBit,
> @@ -166,7 +167,7 @@ static HW_STATUS MMU_SetCAMEntry(const u32 =C2=A0=
 =C2=A0baseAddress,
> =C2=A0*
> =C2=A0* METHOD: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : Check the=
 Input parameters and set the RAM entry.
> =C2=A0*/
> -static HW_STATUS MMU_SetRAMEntry(const u32 =C2=A0 =C2=A0 baseAddress=
,
> +static HW_STATUS MMU_SetRAMEntry(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u32 =C2=A0 =C2=A0=
physicalAddr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_Endianism_t =C2=
=A0 =C2=A0 =C2=A0endianism,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_ElementSize_t=
 =C2=A0 =C2=A0elementSize,
> @@ -174,7 +175,7 @@ static HW_STATUS MMU_SetRAMEntry(const u32 =C2=A0=
baseAddress,
>
> =C2=A0/* HW FUNCTIONS */
>
> -HW_STATUS HW_MMU_Enable(const u32 baseAddress)
> +HW_STATUS HW_MMU_Enable(const void __iomem *baseAddress)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
>
> @@ -183,7 +184,7 @@ HW_STATUS HW_MMU_Enable(const u32 baseAddress)
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_Disable(const u32 baseAddress)
> +HW_STATUS HW_MMU_Disable(const void __iomem *baseAddress)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
>
> @@ -192,7 +193,7 @@ HW_STATUS HW_MMU_Disable(const u32 baseAddress)
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_NumLockedSet(const u32 baseAddress,
> +HW_STATUS HW_MMU_NumLockedSet(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 numLockedEntries)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
> @@ -202,7 +203,7 @@ HW_STATUS HW_MMU_NumLockedSet(const u32 baseAddre=
ss,
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_VictimNumSet(const u32 baseAddress,
> +HW_STATUS HW_MMU_VictimNumSet(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 victimEntryNum)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
> @@ -212,7 +213,7 @@ HW_STATUS HW_MMU_VictimNumSet(const u32 baseAddre=
ss,
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddress)
> +HW_STATUS HW_MMU_TLBFlushAll(const void __iomem *baseAddress)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
>
> @@ -221,7 +222,7 @@ HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddres=
s)
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_EventAck(const u32 baseAddress, u32 irqMask)
> +HW_STATUS HW_MMU_EventAck(const void __iomem *baseAddress, u32 irqMa=
sk)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
>
> @@ -230,7 +231,7 @@ HW_STATUS HW_MMU_EventAck(const u32 baseAddress, =
u32 irqMask)
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_EventDisable(const u32 baseAddress,
> +HW_STATUS HW_MMU_EventDisable(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 irqMask)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
> @@ -243,7 +244,7 @@ HW_STATUS HW_MMU_EventDisable(const u32 baseAddre=
ss,
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_EventEnable(const u32 baseAddress, u32 irqMask)
> +HW_STATUS HW_MMU_EventEnable(const void __iomem *baseAddress, u32 ir=
qMask)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
> =C2=A0 =C2=A0 u32 irqReg;
> @@ -256,7 +257,7 @@ HW_STATUS HW_MMU_EventEnable(const u32 baseAddres=
s, u32 irqMask)
> =C2=A0}
>
>
> -HW_STATUS HW_MMU_EventStatus(const u32 baseAddress, u32 *irqMask)
> +HW_STATUS HW_MMU_EventStatus(const void __iomem *baseAddress, u32 *i=
rqMask)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
>
> @@ -266,7 +267,7 @@ HW_STATUS HW_MMU_EventStatus(const u32 baseAddres=
s, u32 *irqMask)
> =C2=A0}
>
>
> -HW_STATUS HW_MMU_FaultAddrRead(const u32 baseAddress, u32 *addr)
> +HW_STATUS HW_MMU_FaultAddrRead(const void __iomem *baseAddress, u32 =
*addr)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
>
> @@ -280,7 +281,7 @@ HW_STATUS HW_MMU_FaultAddrRead(const u32 baseAddr=
ess, u32 *addr)
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_TTBSet(const u32 baseAddress, u32 TTBPhysAddr)
> +HW_STATUS HW_MMU_TTBSet(const void __iomem *baseAddress, u32 TTBPhys=
Addr)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
> =C2=A0 =C2=A0 u32 loadTTB;
> @@ -296,7 +297,7 @@ HW_STATUS HW_MMU_TTBSet(const u32 baseAddress, u3=
2 TTBPhysAddr)
> =C2=A0 =C2=A0return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_TWLEnable(const u32 baseAddress)
> +HW_STATUS HW_MMU_TWLEnable(const void __iomem *baseAddress)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
>
> @@ -305,7 +306,7 @@ HW_STATUS HW_MMU_TWLEnable(const u32 baseAddress)
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_TWLDisable(const u32 baseAddress)
> +HW_STATUS HW_MMU_TWLDisable(const void __iomem *baseAddress)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
>
> @@ -314,7 +315,7 @@ HW_STATUS HW_MMU_TWLDisable(const u32 baseAddress=
)
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_TLBFlush(const u32 baseAddress, u32 virtualAddr,
> +HW_STATUS HW_MMU_TLBFlush(const void __iomem *baseAddress, u32 virtu=
alAddr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 pageSize)
> =C2=A0{
> =C2=A0 =C2=A0 HW_STATUS status =3D RET_OK;
> @@ -352,7 +353,7 @@ HW_STATUS HW_MMU_TLBFlush(const u32 baseAddress, =
u32 virtualAddr,
> =C2=A0 =C2=A0 return status;
> =C2=A0}
>
> -HW_STATUS HW_MMU_TLBAdd(const u32 =C2=A0 =C2=A0 =C2=A0baseAddress,
> +HW_STATUS HW_MMU_TLBAdd(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0physicalAddr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtualAddr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0pageSize,
> @@ -538,7 +539,7 @@ HW_STATUS HW_MMU_PteClear(const u32 =C2=A0pgTblVa=
,
> =C2=A0}
>
> =C2=A0/* MMU_FlushEntry */
> -static HW_STATUS MMU_FlushEntry(const u32 baseAddress)
> +static HW_STATUS MMU_FlushEntry(const void __iomem *baseAddress)
> =C2=A0{
> =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
> =C2=A0 =C2=A0u32 flushEntryData =3D 0x1;
> @@ -554,7 +555,7 @@ static HW_STATUS MMU_FlushEntry(const u32 baseAdd=
ress)
> =C2=A0}
>
> =C2=A0/* MMU_SetCAMEntry */
> -static HW_STATUS MMU_SetCAMEntry(const u32 =C2=A0 =C2=A0baseAddress,
> +static HW_STATUS MMU_SetCAMEntry(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u32 =C2=A0 =C2=A0=
pageSize,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u32 =C2=A0 =C2=A0=
preservedBit,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u32 =C2=A0 =C2=A0=
validBit,
> @@ -578,7 +579,7 @@ static HW_STATUS MMU_SetCAMEntry(const u32 =C2=A0=
 =C2=A0baseAddress,
> =C2=A0}
>
> =C2=A0/* MMU_SetRAMEntry */
> -static HW_STATUS MMU_SetRAMEntry(const u32 =C2=A0 =C2=A0 =C2=A0 base=
Address,
> +static HW_STATUS MMU_SetRAMEntry(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u32 =C2=A0 =C2=A0=
 =C2=A0 physicalAddr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_Endianism_t =C2=
=A0 =C2=A0 endianism,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_ElementSize_t=
 =C2=A0 elementSize,
> diff --git a/drivers/dsp/bridge/hw/hw_mmu.h b/drivers/dsp/bridge/hw/h=
w_mmu.h
> index 924f32b..dc1aec1
> --- a/drivers/dsp/bridge/hw/hw_mmu.h
> +++ b/drivers/dsp/bridge/hw/hw_mmu.h
> @@ -53,47 +53,47 @@ struct HW_MMUMapAttrs_t {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum HW_MMUMixedSize_t =C2=A0mixedSize;
> =C2=A0} ;
>
> -extern HW_STATUS HW_MMU_Enable(const u32 baseAddress);
> +extern HW_STATUS HW_MMU_Enable(const void __iomem *baseAddress);
>
> -extern HW_STATUS HW_MMU_Disable(const u32 baseAddress);
> +extern HW_STATUS HW_MMU_Disable(const void __iomem *baseAddress);
>
> -extern HW_STATUS HW_MMU_NumLockedSet(const u32 baseAddress,
> +extern HW_STATUS HW_MMU_NumLockedSet(const void __iomem *baseAddress=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u=
32 numLockedEntries);
>
> -extern HW_STATUS HW_MMU_VictimNumSet(const u32 baseAddress,
> +extern HW_STATUS HW_MMU_VictimNumSet(const void __iomem *baseAddress=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u=
32 victimEntryNum);
>
> =C2=A0/* For MMU faults */
> -extern HW_STATUS HW_MMU_EventAck(const u32 baseAddress,
> +extern HW_STATUS HW_MMU_EventAck(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 irqMask);
>
> -extern HW_STATUS HW_MMU_EventDisable(const u32 baseAddress,
> +extern HW_STATUS HW_MMU_EventDisable(const void __iomem *baseAddress=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u=
32 irqMask);
>
> -extern HW_STATUS HW_MMU_EventEnable(const u32 baseAddress,
> +extern HW_STATUS HW_MMU_EventEnable(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 irq=
Mask);
>
> -extern HW_STATUS HW_MMU_EventStatus(const u32 baseAddress,
> +extern HW_STATUS HW_MMU_EventStatus(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *ir=
qMask);
>
> -extern HW_STATUS HW_MMU_FaultAddrRead(const u32 baseAddress,
> +extern HW_STATUS HW_MMU_FaultAddrRead(const void __iomem *baseAddres=
s,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
u32 *addr);
>
> =C2=A0/* Set the TT base address */
> -extern HW_STATUS HW_MMU_TTBSet(const u32 baseAddress,
> +extern HW_STATUS HW_MMU_TTBSet(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 TTBPhysAddr);
>
> -extern HW_STATUS HW_MMU_TWLEnable(const u32 baseAddress);
> +extern HW_STATUS HW_MMU_TWLEnable(const void __iomem *baseAddress);
>
> -extern HW_STATUS HW_MMU_TWLDisable(const u32 baseAddress);
> +extern HW_STATUS HW_MMU_TWLDisable(const void __iomem *baseAddress);
>
> -extern HW_STATUS HW_MMU_TLBFlush(const u32 baseAddress,
> +extern HW_STATUS HW_MMU_TLBFlush(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 virtualAddr=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 pageSize);
>
> -extern HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddress);
> +extern HW_STATUS HW_MMU_TLBFlushAll(const void __iomem *baseAddress)=
;
>
> -extern HW_STATUS HW_MMU_TLBAdd(const u32 =C2=A0 =C2=A0 baseAddress,
> +extern HW_STATUS HW_MMU_TLBAdd(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0=
physicalAddr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0=
virtualAddr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0=
pageSize,
> diff --git a/drivers/dsp/bridge/hw/hw_prcm.c b/drivers/dsp/bridge/hw/=
hw_prcm.c
> index 61ff08f..8f04a70
> --- a/drivers/dsp/bridge/hw/hw_prcm.c
> +++ b/drivers/dsp/bridge/hw/hw_prcm.c
> @@ -29,21 +29,21 @@
> =C2=A0#include <hw_defs.h>
> =C2=A0#include <hw_prcm.h>
>
> -static HW_STATUS HW_RST_WriteVal(const u32 baseAddress,
> +static HW_STATUS HW_RST_WriteVal(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum HW_RstModu=
le_t r,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum HW_SetClea=
r_t val);
>
> -HW_STATUS HW_RST_Reset(const u32 baseAddress, enum HW_RstModule_t r)
> +HW_STATUS HW_RST_Reset(const void __iomem *baseAddress, enum HW_RstM=
odule_t r)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return HW_RST_WriteVal(baseAddress, r, HW_=
SET);
> =C2=A0}
>
> -HW_STATUS HW_RST_UnReset(const u32 baseAddress, enum HW_RstModule_t =
r)
> +HW_STATUS HW_RST_UnReset(const void __iomem *baseAddress, enum HW_Rs=
tModule_t r)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return HW_RST_WriteVal(baseAddress, r, HW_=
CLEAR);
> =C2=A0}
>
> -static HW_STATUS HW_RST_WriteVal(const u32 baseAddress,
> +static HW_STATUS HW_RST_WriteVal(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum HW_RstModu=
le_t r,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum HW_SetClea=
r_t val)
> =C2=A0{
> @@ -66,8 +66,8 @@ static HW_STATUS HW_RST_WriteVal(const u32 baseAddr=
ess,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
>
> -HW_STATUS HW_PWR_IVA2StateGet(const u32 baseAddress, enum HW_PwrModu=
le_t p,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_PwrState_t *value)
> +HW_STATUS HW_PWR_IVA2StateGet(const void __iomem *baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_PwrModule_=
t p, enum HW_PwrState_t *value)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 temp;
> @@ -93,7 +93,7 @@ HW_STATUS HW_PWR_IVA2StateGet(const u32 baseAddress=
, enum HW_PwrModule_t p,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
>
> -HW_STATUS HW_PWRST_IVA2RegGet(const u32 baseAddress, u32 *value)
> +HW_STATUS HW_PWRST_IVA2RegGet(const void __iomem *baseAddress, u32 *=
value)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
>
> @@ -103,7 +103,7 @@ HW_STATUS HW_PWRST_IVA2RegGet(const u32 baseAddre=
ss, u32 *value)
> =C2=A0}
>
>
> -HW_STATUS HW_PWR_IVA2PowerStateSet(const u32 baseAddress,
> +HW_STATUS HW_PWR_IVA2PowerStateSet(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_PwrMod=
ule_t p,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_PwrSta=
te_t value)
> =C2=A0{
> @@ -135,7 +135,7 @@ HW_STATUS HW_PWR_IVA2PowerStateSet(const u32 base=
Address,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
>
> -HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const u32 baseAddress,
> +HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum HW_=
TransitionState_t val)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
> @@ -146,8 +146,8 @@ HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const u32 bas=
eAddress,
>
> =C2=A0}
>
> -HW_STATUS HW_RSTST_RegGet(const u32 baseAddress, enum HW_RstModule_t=
 m,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 u32 *value)
> +HW_STATUS HW_RSTST_RegGet(const void __iomem *baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_RstModule_=
t m, u32 *value)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
>
> @@ -156,8 +156,8 @@ HW_STATUS HW_RSTST_RegGet(const u32 baseAddress, =
enum HW_RstModule_t m,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
>
> -HW_STATUS HW_RSTCTRL_RegGet(const u32 baseAddress, enum HW_RstModule=
_t m,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *value)
> +HW_STATUS HW_RSTCTRL_RegGet(const void __iomem *baseAddress,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_RstModule_=
t m, u32 *value)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_STATUS status =3D RET_OK;
>
> diff --git a/drivers/dsp/bridge/hw/hw_prcm.h b/drivers/dsp/bridge/hw/=
hw_prcm.h
> index 928486c..65c8bd1
> --- a/drivers/dsp/bridge/hw/hw_prcm.h
> +++ b/drivers/dsp/bridge/hw/hw_prcm.h
> @@ -132,16 +132,16 @@ enum HW_TransitionState_t {
> =C2=A0} ;
>
>
> -extern HW_STATUS HW_RST_Reset(const u32 baseAddress,
> +extern HW_STATUS HW_RST_Reset(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_RstModule_t r);
>
> -extern HW_STATUS HW_RST_UnReset(const u32 baseAddress,
> +extern HW_STATUS HW_RST_UnReset(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum HW_RstModule_t r=
);
>
> -extern HW_STATUS HW_RSTCTRL_RegGet(const u32 baseAddress,
> +extern HW_STATUS HW_RSTCTRL_RegGet(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 enum HW_RstModule_t p,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 u32 *value);
> -extern HW_STATUS HW_RSTST_RegGet(const u32 baseAddress,
> +extern HW_STATUS HW_RSTST_RegGet(const void __iomem *baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 enum HW_RstModule_t p, u32 *value);
>
> =C2=A0extern HW_STATUS HW_PWR_PowerStateSet(const u32 baseAddress,
> @@ -152,17 +152,18 @@ extern HW_STATUS HW_CLK_SetInputClock(const u32=
 baseAddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
num HW_GPtimer_t gpt,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
num HW_Clocktype_t c);
>
> -extern HW_STATUS HW_PWR_IVA2StateGet(const u32 baseAddress,
> +extern HW_STATUS HW_PWR_IVA2StateGet(const void __iomem *baseAddress=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
num HW_PwrModule_t p,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
num HW_PwrState_t *value);
>
> -extern HW_STATUS HW_PWRST_IVA2RegGet(const u32 baseAddress, u32 *val=
ue);
> +extern HW_STATUS HW_PWRST_IVA2RegGet(const void __iomem *baseAddress=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 u32 *value);
>
> -extern HW_STATUS HW_PWR_IVA2PowerStateSet(const u32 baseAddress,
> +extern HW_STATUS HW_PWR_IVA2PowerStateSet(const void __iomem *baseAd=
dress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0enum HW_PwrModule_t p,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0enum HW_PwrState_t value);
>
> -extern HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const u32 baseAddress,
> +extern HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const void __iomem *baseA=
ddress,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 enum HW_TransitionState_t val);
>
> =C2=A0#endif =C2=A0/* __HW_PRCM_H */
> diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/=
drv.c
> index 22faf49..07fde81
> --- a/drivers/dsp/bridge/rmgr/drv.c
> +++ b/drivers/dsp/bridge/rmgr/drv.c
> @@ -1649,15 +1649,15 @@ static DSP_STATUS RequestBridgeResources(u32 =
dwContext, s32 bRequest)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"=
%x. Not calling MEM_FreePhysMem\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
tatus);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pResources->dwMemBase[1] =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pResources->dwMemPhys[1] =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwPrmBase)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap((void *)pResources->dwPrmBa=
se);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(pResources->dwPrmBase);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwCmBase)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap((void *)pResources->dwCmBas=
e);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(pResources->dwCmBase);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwMboxBase)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap((void *)pResources->dwMboxB=
ase);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(pResources->dwMboxBase);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwMemBase[0])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap((void *)pResources->d=
wMemBase[0]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwMemBase[2])
> @@ -1667,26 +1667,26 @@ static DSP_STATUS RequestBridgeResources(u32 =
dwContext, s32 bRequest)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwMemBase[4])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap((void *)pResources->d=
wMemBase[4]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwWdTimerDspBase)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap((void *)pResources->dwWdTim=
erDspBase);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(pResources->dwWdTimerDspBas=
e);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwDmmuBase)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap((void *)pResources->dwDmmuB=
ase);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(pResources->dwDmmuBase);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwPerBase)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap((void *)pResources->dwPerBa=
se);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(pResources->dwPerBase);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (pResources->dwSysCtrlBase) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap((void *)pResources->dwSysCt=
rlBase);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(pResources->dwSysCtrlBase);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* don't set pResources->dwSy=
sCtrlBase to null
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * as it is used in BOARD_Sto=
p */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwPrmBase =3D (u32) NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwCmBase =3D (u32) NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMboxBase =3D (u32) NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[0] =3D (u32) NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[2] =3D (u32) NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[3] =3D (u32) NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[4] =3D (u32) NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwWdTimerDspBase =3D (u32) NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwDmmuBase =3D (u32) NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwPrmBase =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwCmBase =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMboxBase =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[0] =3D (u32)NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[2] =3D (u32)NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[3] =3D (u32)NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[4] =3D (u32)NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwWdTimerDspBase =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwDmmuBase =3D NULL;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dwBuffSize =3D sizeof(struct CFG_HOSTRES);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0status =3D REG_SetValue(NULL, (char *)driverExt->szString=
,
> @@ -1705,13 +1705,13 @@ static DSP_STATUS RequestBridgeResources(u32 =
dwContext, s32 bRequest)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pResources->wN=
umMemWindows =3D 2;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* First windo=
w is for DSP internal memory */
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwPrmB=
ase =3D (u32)ioremap(OMAP_IVA2_PRM_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwPrmB=
ase =3D ioremap(OMAP_IVA2_PRM_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_IVA2_PRM_SI=
ZE);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwCmBa=
se =3D (u32)ioremap(OMAP_IVA2_CM_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwCmBa=
se =3D ioremap(OMAP_IVA2_CM_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_IVA2_CM_SIZ=
E);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwMbox=
Base =3D (u32)ioremap(OMAP_MBOX_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwMbox=
Base =3D ioremap(OMAP_MBOX_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_MBOX_SIZE);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwSysC=
trlBase =3D (u32)ioremap(OMAP_SYSC_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwSysC=
trlBase =3D ioremap(OMAP_SYSC_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_SYSC_SIZE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GT_1trace(curT=
race, GT_2CLASS, "dwMemBase[0] 0x%x\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 pResources->dwMemBase[0]);
> @@ -1797,18 +1797,18 @@ static DSP_STATUS RequestBridgeResourcesDSP(u=
32 dwContext, s32 bRequest)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* wNumMemWind=
ows must not be more than CFG_MAXMEMREGISTERS */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pResources->wN=
umMemWindows =3D 4;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pResources->dw=
MemBase[0] =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pResources->dw=
MemBase[2] =3D (u32)ioremap(OMAP_DSP_MEM1_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_DSP_MEM1_SI=
ZE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pResources->dw=
MemBase[3] =3D (u32)ioremap(OMAP_DSP_MEM2_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_DSP_MEM2_SI=
ZE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pResources->dw=
MemBase[4] =3D (u32)ioremap(OMAP_DSP_MEM3_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_DSP_MEM3_SI=
ZE);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwPerB=
ase =3D (u32)ioremap(OMAP_PER_CM_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwPerB=
ase =3D ioremap(OMAP_PER_CM_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_PER_CM_SIZE=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwDmmu=
Base =3D (u32)ioremap(OMAP_DMMU_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwDmmu=
Base =3D ioremap(OMAP_DMMU_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_DMMU_SIZE);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwWdTi=
merDspBase =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pResources->dwWdTi=
merDspBase =3D NULL;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GT_1trace(curT=
race, GT_2CLASS, "dwMemBase[0] 0x%x\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pResources->dwMemBase[0]);
> diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr=
/node.c
> index 1db32e9..2b029c7
> --- a/drivers/dsp/bridge/rmgr/node.c
> +++ b/drivers/dsp/bridge/rmgr/node.c
> @@ -717,7 +717,7 @@ func_cont2:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"0x%x\n", status);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ulGppMemBase =3D hostRes.dwMemBase[1];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ulGppMemBase =3D (u32)hostRes.dwMemBase[1];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0offSet =3D pulValue - dynextBase;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ulStackSegAddr =3D ulGppMemBase + offSet;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ulStackSegVal =3D (u32)*((REG_UWORD32 *)
> diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wm=
d/_tiomap.h
> index 5267eb2..3cd2237
> --- a/drivers/dsp/bridge/wmd/_tiomap.h
> +++ b/drivers/dsp/bridge/wmd/_tiomap.h
> @@ -362,7 +362,7 @@ struct WMD_DEV_CONTEXT {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dwDspExtBaseAddr; =C2=A0 /* See the co=
mment above =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dwAPIRegBase; =C2=A0 =C2=A0 =C2=A0 /* =
API memory mapped registers =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 u32 dwDSPMmuBase; =C2=A0 =C2=A0 =C2=A0 /* DSP =
MMU Mapped registers =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *dwDSPMmuBase; =C2=A0 =C2=A0 /* D=
SP MMU Mapped registers =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dwMailBoxBase; =C2=A0 =C2=A0 =C2=A0/* =
Mail box mapped registers =C2=A0 =C2=A0*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dwAPIClkBase; =C2=A0 =C2=A0 =C2=A0 /* =
CLK Registers =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dwDSPClkM2Base; =C2=A0 =C2=A0 /* DSP C=
lock Module m2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge=
/wmd/tiomap3430.c
> index 730f9b5..ad813e4
> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> @@ -131,9 +131,9 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt,=
 u32 pa, u32 va,
> =C2=A0static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevCon=
text,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0u32 ulMpuAddr, u32 ulVirtAddr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0u32 ulNumBytes, u32 ulMapAttr);
> -static DSP_STATUS run_IdleBoot(u32 prcm_base, u32 cm_base,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 u32 sysctrl_base);
> -void GetHWRegs(u32 prcm_base, u32 cm_base);
> +static DSP_STATUS run_IdleBoot(void __iomem *prcm_base, void __iomem=
 *cm_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 void __iomem *sysctrl_base);
> +static void GetHWRegs(void __iomem *prcm_base, void __iomem *cm_base=
);
>
> =C2=A0/* =C2=A0----------------------------------- Globals */
>
> @@ -505,11 +505,10 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_=
CONTEXT *hDevContext,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_MMU_TWLEnab=
le(resources.dwDmmuBase);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Enable the =
SmartIdle and AutoIdle bit for MMU_SYSCONFIG */
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp =3D (u32) *((=
REG_UWORD32 *)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((u32) (resources.dwDmmuBase) + 0x1=
0));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_rea=
dl((resources.dwDmmuBase) + 0x10);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D (temp=
 & 0xFFFFFFEF) | 0x11;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((REG_UWORD32 *) =
((u32) (resources.dwDmmuBase) + 0x10)) =3D
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (u32) temp;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(temp,=
 (resources.dwDmmuBase) + 0x10);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Let the DSP=
 MMU run */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_MMU_Enable(=
resources.dwDmmuBase);
> @@ -2069,8 +2068,8 @@ func_cont:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
>
> -static DSP_STATUS run_IdleBoot(u32 prm_base, u32 cm_base,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 sysctrl_base)
> +static DSP_STATUS run_IdleBoot(void __iomem *prm_base, void __iomem =
*cm_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *sysctrl_base)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 temp;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DSP_STATUS status =3D DSP_SOK;
> @@ -2096,10 +2095,10 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, =
u32 cm_base,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(10);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Assert IVA2-RST1 and IVA2-RST2 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 *((REG_UWORD32 *)((u32)(prm_base) + 0x50)) =3D=
 (u32)0x07;
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel((u32)0x07, (prm_base) + 0x50);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(30);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set the SYSC for Idle Boot */
> - =C2=A0 =C2=A0 =C2=A0 *((REG_UWORD32 *)((u32)(sysctrl_base) + 0x404)=
) =3D (u32)0x01;
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel((u32)0x01, (sysctrl_base) + 0x404=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_status =3D CLK_Enable(SERVICESCLK_iva2=
_ck);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (DSP_FAILED(clk_status)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_Trace(DBG_=
LEVEL6, "CLK_Enable failed for clk =3D 0x%x \n",
> @@ -2108,36 +2107,36 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, =
u32 cm_base,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(20);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GetHWRegs(prm_base, cm_base);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Release Reset1 and Reset2 */
> - =C2=A0 =C2=A0 =C2=A0 *((REG_UWORD32 *)((u32)(prm_base) + 0x50)) =3D=
 (u32)0x05;
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel((u32)0x05, (prm_base) + 0x50);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(20);
> - =C2=A0 =C2=A0 =C2=A0 *((REG_UWORD32 *)((u32)(prm_base) + 0x50)) =3D=
 (u32)0x04;
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel((u32)0x04, (prm_base) + 0x50);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(30);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
>
>
> -void GetHWRegs(u32 prm_base, u32 cm_base)
> +static void GetHWRegs(void __iomem *prm_base, void __iomem *cm_base)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 temp;
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(cm_base)=
 + 0x00));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((cm_base) + 0x00);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "CM_FCLKEN_I=
VA2 =3D 0x%x \n", temp);
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(cm_base)=
 + 0x10));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((cm_base) + 0x10);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_=
IVA2 =3D 0x%x \n", temp);
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(cm_base)=
 + 0x20));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((cm_base) + 0x20);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "CM_IDLEST_I=
VA2 =3D 0x%x \n", temp);
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(cm_base)=
 + 0x48));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((cm_base) + 0x48);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "CM_CLKSTCTR=
L_IVA2 =3D 0x%x \n", temp);
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(cm_base)=
 + 0x4c));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((cm_base) + 0x4c);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "CM_CLKSTST_=
IVA2 =3D 0x%x \n", temp);
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(prm_base=
) + 0x50));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((prm_base) + 0x50);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "RM_RSTCTRL_=
IVA2 =3D 0x%x \n", temp);
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(prm_base=
) + 0x58));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((prm_base) + 0x58);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "RM_RSTST_IV=
A2 =3D 0x%x \n", temp);
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(prm_base=
) + 0xE0));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((prm_base) + 0xE0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "PM_PWSTCTRL=
_IVA2 =3D 0x%x \n", temp);
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(prm_base=
) + 0xE4));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((prm_base) + 0xE4);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "PM_PWSTST_I=
VA2 =3D 0x%x \n", temp);
> - =C2=A0 =C2=A0 =C2=A0 temp =3D (u32)*((REG_UWORD32 *)((u32)(cm_base)=
 + 0xA10));
> + =C2=A0 =C2=A0 =C2=A0 temp =3D __raw_readl((cm_base) + 0xA10);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_=
CORE =3D 0x%x \n", temp);
> =C2=A0}
>
> --
> 1.5.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

I got following errors while applying this patch again the bridge patch=
es
accumulated at:
http://gitorious.org/projects/tidspbridge2/repos/mainline/logs/tidspbri=
dge

patching file arch/arm/plat-omap/include/dspbridge/cfgdefs.h
Hunk #1 FAILED at 96.
1 out of 1 hunk FAILED -- saving rejects to file
arch/arm/plat-omap/include/dspbridge/cfgdefs.h.rej
patching file drivers/dsp/bridge/hw/hw_dspssC64P.c
Hunk #1 FAILED at 34.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/dsp/bridge/hw/hw_dspssC64P.c.rej
patching file drivers/dsp/bridge/hw/hw_dspssC64P.h
Hunk #1 FAILED at 41.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/dsp/bridge/hw/hw_dspssC64P.h.rej
patching file drivers/dsp/bridge/hw/hw_mbox.c
Hunk #1 succeeded at 37 with fuzz 2.
Hunk #2 succeeded at 51 with fuzz 2.
Hunk #3 FAILED at 66.
Hunk #4 FAILED at 87.
Hunk #5 FAILED at 106.
Hunk #6 FAILED at 131.
Hunk #7 FAILED at 153.
Hunk #8 FAILED at 193.
Hunk #9 FAILED at 227.
7 out of 9 hunks FAILED -- saving rejects to file
drivers/dsp/bridge/hw/hw_mbox.c.rej
patching file drivers/dsp/bridge/hw/hw_mbox.h
Hunk #1 FAILED at 92.
Hunk #2 FAILED at 124.
Hunk #3 FAILED at 159.
Hunk #4 FAILED at 193.
Hunk #5 FAILED at 229.
Hunk #6 FAILED at 266.
Hunk #7 FAILED at 305.
Hunk #8 succeeded at 296 (offset -35 lines).
Hunk #9 succeeded at 318 (offset -35 lines).
7 out of 9 hunks FAILED -- saving rejects to file
drivers/dsp/bridge/hw/hw_mbox.h.rej
patching file drivers/dsp/bridge/hw/hw_mmu.c
Hunk #2 succeeded at 80 with fuzz 2.
Hunk #3 FAILED at 122.
Hunk #4 FAILED at 167.
Hunk #7 FAILED at 193.
Hunk #8 FAILED at 203.
Hunk #11 FAILED at 231.
Hunk #18 FAILED at 315.
Hunk #19 FAILED at 353.
Hunk #21 FAILED at 555.
Hunk #22 FAILED at 579.
9 out of 22 hunks FAILED -- saving rejects to file
drivers/dsp/bridge/hw/hw_mmu.c.rej
patching file drivers/dsp/bridge/hw/hw_mmu.h
Hunk #1 FAILED at 53.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/dsp/bridge/hw/hw_mmu.h.rej
patching file drivers/dsp/bridge/hw/hw_prcm.c
Hunk #1 FAILED at 29.
Hunk #2 FAILED at 66.
Hunk #3 succeeded at 93 with fuzz 2.
Hunk #4 FAILED at 103.
Hunk #5 FAILED at 135.
Hunk #6 FAILED at 146.
Hunk #7 FAILED at 156.
6 out of 7 hunks FAILED -- saving rejects to file
drivers/dsp/bridge/hw/hw_prcm.c.rej
patching file drivers/dsp/bridge/hw/hw_prcm.h
Hunk #1 FAILED at 132.
Hunk #2 FAILED at 152.
2 out of 2 hunks FAILED -- saving rejects to file
drivers/dsp/bridge/hw/hw_prcm.h.rej
patching file drivers/dsp/bridge/rmgr/drv.c
Hunk #1 FAILED at 1649.
Hunk #2 FAILED at 1667.
Hunk #3 FAILED at 1705.
Hunk #4 FAILED at 1797.
4 out of 4 hunks FAILED -- saving rejects to file
drivers/dsp/bridge/rmgr/drv.c.rej
patching file drivers/dsp/bridge/rmgr/node.c
Hunk #1 FAILED at 717.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/dsp/bridge/rmgr/node.c.rej
patching file drivers/dsp/bridge/wmd/_tiomap.h
Hunk #1 FAILED at 362.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/dsp/bridge/wmd/_tiomap.h.rej
patching file drivers/dsp/bridge/wmd/tiomap3430.c
Hunk #1 FAILED at 131.
Hunk #2 FAILED at 505.
Hunk #3 FAILED at 2068.
Hunk #4 FAILED at 2095.
Hunk #5 FAILED at 2107.
5 out of 5 hunks FAILED -- saving rejects to file
drivers/dsp/bridge/wmd/tiomap3430.c.rej
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
