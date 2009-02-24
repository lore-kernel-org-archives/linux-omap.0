From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2][OMAPZOOM] DSPBRIDGE: Change address resources to void
	__iomem *
Date: Wed, 25 Feb 2009 00:14:45 +0200
Message-ID: <94a0d4530902241414v74f6ef1do378a51c55a40fbfd@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602877515DC@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:38823 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZBXWOt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 17:14:49 -0500
Received: by fg-out-1718.google.com with SMTP id 16so165860fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 14:14:45 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E602877515DC@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Feb 24, 2009 at 11:50 PM, Guzman Lugo, Fernando <x0095840@ti.co=
m> wrote:
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

s/u32/void __iomem/ right?

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
> @@ -26,6 +26,7 @@
> =C2=A0*/
>
> =C2=A0#include <GlobalTypes.h>
> +#include <linux/io.h>
> =C2=A0#include "MLBRegAcM.h"
> =C2=A0#include <hw_defs.h>
> =C2=A0#include <hw_mbox.h>
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
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[1] =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemPhys[1] =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemBase[1] =3D (u32)NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pResources->dwMemPhys[1] =3D (u32)NULL;

Why wasn't dwMemBase updated too?

<snip/>

A step in the right direction. Thanks.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
