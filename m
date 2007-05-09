From: Geoffrey Tam <geoffrey@evertz.com>
Subject: Cannot stall an endpoint 0 control transfer from a data stage cal
	lback function
Date: Wed, 9 May 2007 14:07:01 -0400
Message-ID: <0474A5584072DA1197F50007E90E6B1141D45B@PORTIA>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_000_01C79264.D7BC5F60"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'linux-omap-open-source@linux.omap.com'" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C79264.D7BC5F60
Content-Type: text/plain;
	charset="iso-8859-1"

Also sent to 'linux-usb-devel@lists.sourceforge.net'.

patch was created as per Documentation/SubmittingPatches.
     
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@mvista.com]
> Sent: Wednesday, May 09, 2007 12:35 PM
> To: Geoffrey Tam
> Cc: 'linux-usb-devel@lists.sourceforge.net'
> Subject: RE: [linux-usb-devel] Cannot stall an endpoint 0 control
> transfer from a data stage callback function
> 
> 
> On Wed, 2007-05-09 at 11:14 -0400, Geoffrey Tam wrote:
> > Here is the patch created as per instructions in
> > Documentation/SubmittingPatches.
> > 
> > Does anyone know if there is a MontaVista USB developer 
> mailing list?
> 
> The latest code for this MUSB driver is maintained as part of the OMAP
> git tree.  The major rework of the Mentor code was done primarily by
> David Brownell, and more recently with several patches from 
> the OMAP git
> developers.
> 
> I suggest you send your patch to the OMAP mailing list[1].  Once it is
> approved/merged into the OMAP tree, it will make it into the DaVinci
> tree.  Note however, that the DaVinci tree is not actively maintained.
> Right now we are focusing efforts on getting the DaVinci codebase into
> mainline instead of maintaining a separate tree.
> 
> Kevin
> 
> [1] http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> > > Hi,
> > > 
> > > On Wed, May 09, 2007 at 12:52:46AM -0700, ext Greg KH wrote:
> > > > On Thu, May 03, 2007 at 04:02:59PM -0400, Geoffrey Tam wrote:
> > > > > I am new to the Linux open source community. I am not 
> > > sure if I am posting
> > > > > this to the correct mailing list. Please tell me where 
> > > this should be posted
> > > > > if it is in the wrong spot. I have subscribed to this 
> > > mailing list.
> > > > > 
> > > > > I am using Linux 2.6.20. It was retrieved from the 
> > > MontaVista git tree
> > > > > (source.mvista.com/git/linux-davinci-2.6.gitCVS:) in 
> > > February 2007. I am
> > > > > using the TI Davinci processor.
> > > > > 
> > > > > My USB gadget supports 2 endpoint 0 control transfers: 
> > > "get variable" and
> > > > > "set variable".
> > > > > 
> > > > > The "get" function must stall endpoint 0 if the variable 
> > > id retrieved from
> > > > > the endpoint 0 setup stage packet is invalid. The current 
> > > implementation of
> > > > > the USB gadget supports this.
> > > > > 
> > > > > The "set" function receives the variable id in the 
> > > endpoint 0 setup stage
> > > > > packet. The value to set the variable to is received in 
> > > the data stage
> > > > > packet. If this value is outside of the variable's valid 
> > > range, it must
> > > > > stall endpoint 0. The current implementation of the USB 
> > > gadget does not
> > > > > support this.
> > > > > 
> > > > > This is a legacy protocol, so it cannot be changed as 
> > > this would break other
> > > > > applications that already use it.
> > > > > 
> > > > > Through my debugging, I believe that the souce of my 
> problems are:
> > > > > - The state machine is going to the setup stage 
> > > (MGC_END0_STAGE_SETUP) too
> > > > > early.
> > > > > - The USB peripheral hardware is being notified with "end 
> > > of data stage" too
> > > > > early (MGC_M_CSR0_P_DATAEND bit in MGC_O_HDRC_CSR0 being 
> > > written too early).
> > > > > 
> > > > > I noticed that on 22 Mar 2007, an update to the git tree 
> > > was made to correct
> > > > > problems on endpoint 0
> > > > > 
> > > (source.mvista.com/git/gitweb.cgi?p=linux-davinci-2.6.git;a=lo
> > > g). I scanned
> > > > > the changes that were made, and do not believe that my 
> > > changes are included.
> > > > > 
> > > > > I made changes to the code, and this has fixed the 
> > > problem for me. I would
> > > > > appreciate if someone could review them for correctness, 
> > > and if possible,
> > > > > add them to the git tree.
> > > > > 
> > > > > Only 1 file had to be modified: drivers/usb/musb/g_ep0.c
> > > > > 
> > > > > There are 4 files included in this e-mail:
> > > > > - g_ep0-2_6_20.c is the original Linux 2.6.20 g_ep0.c 
> > > from the git tree.
> > > > > - g_ep0.c is my modified file.
> > > > > - PATCH contains the differences between the 2 files.
> > > > > - README contains information on how PATCH was generated, 
> > > and why the
> > > > > changes were made.
> > > > 
> > > > Can you take a look at the file, 
> Documentation/SubmittingPatches and
> > > > resend this based on the directions written there for how 
> > > to create a
> > > > patch in a manner so that we can apply it?
> > > > 
> > > > Also, if you are having mvista specific issues, I 
> suggest contacting
> > > > them, there is nothing we can do about their kernels, and 
> > > we do not know
> > > > what they add or remove from them, based on the 
> kernel.org releases.
> > > 
> > > And also, musb driver is not yet pushed into 
> linux-2.6.git. Maybe you
> > > would like to sign to linux-omap mailing list. Here's the link:
> > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > > 
> > > Also, you would like to send this email to Kevin Hilman 
> > > <khilman@mvista.com>. He's the maintainer
> > > of the linux-davinci gittree.
> > > 
> > > 
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > > 
> > > --------------------------------------------------------------
> > > -----------
> > > > This SF.net email is sponsored by DB2 Express
> > > > Download DB2 Express C - the FREE version of DB2 
> express and take
> > > > control of your XML. No limits. Just data. Click to get it now.
> > > > http://sourceforge.net/powerbar/db2/
> > > > _______________________________________________
> > > > linux-usb-devel@lists.sourceforge.net
> > > > To unsubscribe, use the last form field at:
> > > > https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
> > > 
> > > -- 
> > > Best Regards,
> > > 
> > > Felipe Balbi
> > > felipe.lima@indt.org.br
> > > +55 92 2126-1003
> > > 
> > > Kernel Developers Team
> > > 
> > 
> 


 <<patch>>  <<g_ep0-2_6_20.c>>  <<g_ep0.c>>  <<PATCH>>  <<README>> 

------_=_NextPart_000_01C79264.D7BC5F60
Content-Type: application/octet-stream;
	name="patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch"

--- linux_mv_davinci/drivers/usb/musb/g_ep0.c.orig	2007-05-09 =
10:56:29.000000000 -0400=0A=
+++ linux_mv_davinci/drivers/usb/musb/g_ep0.c	2007-03-22 =
15:16:35.000000000 -0400=0A=
@@ -196,7 +196,6 @@ service_in_request(struct musb *pThis,=0A=
  */=0A=
 static void musb_g_ep0_giveback(struct musb *pThis, struct usb_request =
*req)=0A=
 {=0A=
-	pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
 	musb_g_giveback(&pThis->aLocalEnd[0].ep_in, req, 0);=0A=
 }=0A=
 =0A=
@@ -456,7 +455,6 @@ static void ep0_rxstate(struct musb *thi=0A=
 			req =3D NULL;=0A=
 	} else=0A=
 		tmp =3D MGC_M_CSR0_P_SVDRXPKTRDY | MGC_M_CSR0_P_SENDSTALL;=0A=
-	musb_writew(regs, MGC_O_HDRC_CSR0, tmp);=0A=
 =0A=
 =0A=
 	/* NOTE:  we "should" hold off reporting DATAEND and going to=0A=
@@ -465,6 +463,7 @@ static void ep0_rxstate(struct musb *thi=0A=
 	 */=0A=
 	if (req)=0A=
 		musb_g_ep0_giveback(this, req);=0A=
+	musb_writew(regs, MGC_O_HDRC_CSR0, tmp);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -503,7 +502,6 @@ static void ep0_txstate(struct musb *pTh=0A=
 		pRequest =3D NULL;=0A=
 =0A=
 	/* send it out, triggering a "txpktrdy cleared" irq */=0A=
-	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);=0A=
 =0A=
 	/* report completions as soon as the fifo's loaded; there's no=0A=
 	 * win in waiting till this last packet gets acked.  (other than=0A=
@@ -512,6 +510,7 @@ static void ep0_txstate(struct musb *pTh=0A=
 	 */=0A=
 	if (pRequest)=0A=
 		musb_g_ep0_giveback(pThis, pRequest);=0A=
+	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -937,6 +936,8 @@ static int musb_g_ep0_halt(struct usb_ep=0A=
 	case MGC_END0_STAGE_TX:		/* control-IN data */=0A=
 	case MGC_END0_STAGE_ACKWAIT:	/* STALL for zero-length data */=0A=
 	case MGC_END0_STAGE_RX:		/* control-OUT data */=0A=
+	case MGC_END0_STAGE_STATUSIN:		/* control-OUT status */=0A=
+	case MGC_END0_STAGE_STATUSOUT:		/* control-IN status */=0A=
 		status =3D 0;=0A=
 =0A=
 		MGC_SelectEnd(base, 0);=0A=

------_=_NextPart_000_01C79264.D7BC5F60
Content-Type: application/octet-stream;
	name="g_ep0-2_6_20.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="g_ep0-2_6_20.c"

/******************************************************************=0A=
 * Copyright 2005 Mentor Graphics Corporation=0A=
 * Copyright (C) 2005-2006 by Texas Instruments=0A=
 *=0A=
 * This file is part of the Inventra Controller Driver for Linux.=0A=
 *=0A=
 * The Inventra Controller Driver for Linux is free software; you=0A=
 * can redistribute it and/or modify it under the terms of the GNU=0A=
 * General Public License version 2 as published by the Free =
Software=0A=
 * Foundation.=0A=
 *=0A=
 * The Inventra Controller Driver for Linux is distributed in=0A=
 * the hope that it will be useful, but WITHOUT ANY WARRANTY;=0A=
 * without even the implied warranty of MERCHANTABILITY or=0A=
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public=0A=
 * License for more details.=0A=
 *=0A=
 * You should have received a copy of the GNU General Public License=0A=
 * along with The Inventra Controller Driver for Linux ; if not,=0A=
 * write to the Free Software Foundation, Inc., 59 Temple Place,=0A=
 * Suite 330, Boston, MA  02111-1307  USA=0A=
 *=0A=
 * ANY DOWNLOAD, USE, REPRODUCTION, MODIFICATION OR DISTRIBUTION=0A=
 * OF THIS DRIVER INDICATES YOUR COMPLETE AND UNCONDITIONAL =
ACCEPTANCE=0A=
 * OF THOSE TERMS.THIS DRIVER IS PROVIDED "AS IS" AND MENTOR =
GRAPHICS=0A=
 * MAKES NO WARRANTIES, EXPRESS OR IMPLIED, RELATED TO THIS DRIVER.=0A=
 * MENTOR GRAPHICS SPECIFICALLY DISCLAIMS ALL IMPLIED WARRANTIES=0A=
 * OF MERCHANTABILITY; FITNESS FOR A PARTICULAR PURPOSE AND=0A=
 * NON-INFRINGEMENT.  MENTOR GRAPHICS DOES NOT PROVIDE SUPPORT=0A=
 * SERVICES OR UPDATES FOR THIS DRIVER, EVEN IF YOU ARE A MENTOR=0A=
 * GRAPHICS SUPPORT CUSTOMER.=0A=
 ******************************************************************/=0A=
=0A=
#include <linux/kernel.h>=0A=
#include <linux/list.h>=0A=
#include <linux/timer.h>=0A=
#include <linux/spinlock.h>=0A=
#include <linux/init.h>=0A=
#include <linux/device.h>=0A=
#include <linux/interrupt.h>=0A=
=0A=
#include "musbdefs.h"=0A=
=0A=
/* ep0 is always musb->aLocalEnd[0].ep_in */=0A=
#define	next_ep0_request(musb)	=
next_in_request(&(musb)->aLocalEnd[0])=0A=
=0A=
/*=0A=
 * Locking note:  we use only the controller lock, for simpler =
correctness.=0A=
 * It's always held with IRQs blocked.=0A=
 *=0A=
 * It protects the ep0 request queue as well as ep0_state, not just =
the=0A=
 * controller and indexed registers.  And that lock stays held unless =
it=0A=
 * needs to be dropped to allow reentering this driver ... like upcalls =
to=0A=
 * the gadget driver, or adjusting endpoint halt status.=0A=
 */=0A=
=0A=
static char *decode_ep0stage(u8 stage)=0A=
{=0A=
	switch(stage) {=0A=
	case MGC_END0_STAGE_SETUP:	return "idle";=0A=
	case MGC_END0_STAGE_TX:		return "in";=0A=
	case MGC_END0_STAGE_RX:		return "out";=0A=
	case MGC_END0_STAGE_ACKWAIT:	return "wait";=0A=
	case MGC_END0_STAGE_STATUSIN:	return "in/status";=0A=
	case MGC_END0_STAGE_STATUSOUT:	return "out/status";=0A=
	default:			return "?";=0A=
	}=0A=
}=0A=
=0A=
/* handle a standard GET_STATUS request=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static int service_tx_status_request(=0A=
	struct musb *pThis,=0A=
	const struct usb_ctrlrequest *pControlRequest)=0A=
{=0A=
	void __iomem	*pBase =3D pThis->pRegs;=0A=
	int handled =3D 1;=0A=
	u8 bResult[2], bEnd =3D 0;=0A=
	const u8 bRecip =3D pControlRequest->bRequestType & USB_RECIP_MASK;=0A=
=0A=
	bResult[1] =3D 0;=0A=
=0A=
	switch (bRecip) {=0A=
	case USB_RECIP_DEVICE:=0A=
		bResult[0] =3D pThis->bIsSelfPowered << USB_DEVICE_SELF_POWERED;=0A=
		bResult[0] |=3D pThis->bMayWakeup << USB_DEVICE_REMOTE_WAKEUP;=0A=
#ifdef CONFIG_USB_MUSB_OTG=0A=
		if (pThis->g.is_otg) {=0A=
			bResult[0] |=3D pThis->g.b_hnp_enable=0A=
				<< USB_DEVICE_B_HNP_ENABLE;=0A=
			bResult[0] |=3D pThis->g.a_alt_hnp_support=0A=
				<< USB_DEVICE_A_ALT_HNP_SUPPORT;=0A=
			bResult[0] |=3D pThis->g.a_hnp_support=0A=
				<< USB_DEVICE_A_HNP_SUPPORT;=0A=
		}=0A=
#endif=0A=
		break;=0A=
=0A=
	case USB_RECIP_INTERFACE:=0A=
		bResult[0] =3D 0;=0A=
		break;=0A=
=0A=
	case USB_RECIP_ENDPOINT: {=0A=
		int		is_in;=0A=
		struct musb_ep	*ep;=0A=
		u16		tmp;=0A=
		void __iomem	*regs;=0A=
=0A=
		bEnd =3D (u8) pControlRequest->wIndex;=0A=
		if (!bEnd) {=0A=
			bResult[0] =3D 0;=0A=
			break;=0A=
		}=0A=
=0A=
		is_in =3D bEnd & USB_DIR_IN;=0A=
		if (is_in) {=0A=
			bEnd &=3D 0x0f;=0A=
			ep =3D &pThis->aLocalEnd[bEnd].ep_in;=0A=
		} else {=0A=
			ep =3D &pThis->aLocalEnd[bEnd].ep_out;=0A=
		}=0A=
		regs =3D pThis->aLocalEnd[bEnd].regs;=0A=
=0A=
		if (bEnd >=3D MUSB_C_NUM_EPS || !ep->desc) {=0A=
			handled =3D -EINVAL;=0A=
			break;=0A=
		}=0A=
=0A=
		MGC_SelectEnd(pBase, bEnd);=0A=
		if (is_in)=0A=
			tmp =3D musb_readw(regs, MGC_O_HDRC_TXCSR)=0A=
						& MGC_M_TXCSR_P_SENDSTALL;=0A=
		else=0A=
			tmp =3D musb_readw(regs, MGC_O_HDRC_RXCSR)=0A=
						& MGC_M_RXCSR_P_SENDSTALL;=0A=
		MGC_SelectEnd(pBase, 0);=0A=
=0A=
		bResult[0] =3D tmp ? 1 : 0;=0A=
		} break;=0A=
=0A=
	default:=0A=
		/* class, vendor, etc ... delegate */=0A=
		handled =3D 0;=0A=
		break;=0A=
	}=0A=
=0A=
	/* fill up the fifo; caller updates csr0 */=0A=
	if (handled > 0) {=0A=
		u16	len =3D le16_to_cpu(pControlRequest->wLength);=0A=
=0A=
		if (len > 2)=0A=
			len =3D 2;=0A=
		musb_write_fifo(&pThis->aLocalEnd[0], len, bResult);=0A=
	}=0A=
=0A=
	return handled;=0A=
}=0A=
=0A=
/*=0A=
 * handle a control-IN request, the end0 buffer contains the current =
request=0A=
 * that is supposed to be a standard control request. Assumes the fifo =
to=0A=
 * be at least 2 bytes long.=0A=
 *=0A=
 * @return 0 if the request was NOT HANDLED,=0A=
 * < 0 when error=0A=
 * > 0 when the request is processed=0A=
 *=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static int=0A=
service_in_request(struct musb *pThis,=0A=
		const struct usb_ctrlrequest *pControlRequest)=0A=
{=0A=
	int handled =3D 0;	/* not handled */=0A=
=0A=
	if ((pControlRequest->bRequestType & USB_TYPE_MASK)=0A=
			=3D=3D USB_TYPE_STANDARD) {=0A=
		switch (pControlRequest->bRequest) {=0A=
		case USB_REQ_GET_STATUS:=0A=
			handled =3D service_tx_status_request(pThis,=0A=
					pControlRequest);=0A=
			break;=0A=
=0A=
		/* case USB_REQ_SYNC_FRAME: */=0A=
=0A=
		default:=0A=
			break;=0A=
		}=0A=
	}=0A=
	return handled;=0A=
}=0A=
=0A=
/*=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static void musb_g_ep0_giveback(struct musb *pThis, struct usb_request =
*req)=0A=
{=0A=
	pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
	musb_g_giveback(&pThis->aLocalEnd[0].ep_in, req, 0);=0A=
}=0A=
=0A=
/*=0A=
 * Handle all control requests with no DATA stage, including =
standard=0A=
 * requests such as:=0A=
 * USB_REQ_SET_CONFIGURATION, USB_REQ_SET_INTERFACE, unrecognized=0A=
 *	always delegated to the gadget driver=0A=
 * USB_REQ_SET_ADDRESS, USB_REQ_CLEAR_FEATURE, USB_REQ_SET_FEATURE=0A=
 *	always handled here, except for class/vendor/... features=0A=
 *=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static int=0A=
service_zero_data_request(struct musb *pThis,=0A=
		struct usb_ctrlrequest *pControlRequest)=0A=
__releases(pThis->Lock)=0A=
__acquires(pThis->Lock)=0A=
{=0A=
	int handled =3D -EINVAL;=0A=
	void __iomem *pBase =3D pThis->pRegs;=0A=
	const u8 bRecip =3D pControlRequest->bRequestType & USB_RECIP_MASK;=0A=
=0A=
	/* the gadget driver handles everything except what we MUST handle =
*/=0A=
	if ((pControlRequest->bRequestType & USB_TYPE_MASK)=0A=
			=3D=3D USB_TYPE_STANDARD) {=0A=
		switch (pControlRequest->bRequest) {=0A=
		case USB_REQ_SET_ADDRESS:=0A=
			/* change it after the status stage */=0A=
			pThis->bSetAddress =3D TRUE;=0A=
			pThis->bAddress =3D (u8) (pControlRequest->wValue & 0x7f);=0A=
			handled =3D 1;=0A=
			break;=0A=
=0A=
		case USB_REQ_CLEAR_FEATURE:=0A=
			switch (bRecip) {=0A=
			case USB_RECIP_DEVICE:=0A=
				if (pControlRequest->wValue=0A=
						!=3D USB_DEVICE_REMOTE_WAKEUP)=0A=
					break;=0A=
				pThis->bMayWakeup =3D 0;=0A=
				handled =3D 1;=0A=
				break;=0A=
			case USB_RECIP_INTERFACE:=0A=
				break;=0A=
			case USB_RECIP_ENDPOINT:{=0A=
				const u8 bEnd =3D pControlRequest->wIndex & 0x0f;=0A=
				struct musb_ep *pEnd;=0A=
=0A=
				if (bEnd =3D=3D 0=0A=
						|| bEnd >=3D MUSB_C_NUM_EPS=0A=
						|| pControlRequest->wValue=0A=
							!=3D USB_ENDPOINT_HALT)=0A=
					break;=0A=
=0A=
				if (pControlRequest->wIndex & USB_DIR_IN)=0A=
					pEnd =3D &pThis->aLocalEnd[bEnd].ep_in;=0A=
				else=0A=
					pEnd =3D &pThis->aLocalEnd[bEnd].ep_out;=0A=
				if (!pEnd->desc)=0A=
					break;=0A=
=0A=
				/* REVISIT do it directly, no locking games */=0A=
				spin_unlock(&pThis->Lock);=0A=
				musb_gadget_set_halt(&pEnd->end_point, 0);=0A=
				spin_lock(&pThis->Lock);=0A=
=0A=
				/* select ep0 again */=0A=
				MGC_SelectEnd(pBase, 0);=0A=
				handled =3D 1;=0A=
				} break;=0A=
			default:=0A=
				/* class, vendor, etc ... delegate */=0A=
				handled =3D 0;=0A=
				break;=0A=
			}=0A=
			break;=0A=
=0A=
		case USB_REQ_SET_FEATURE:=0A=
			switch (bRecip) {=0A=
			case USB_RECIP_DEVICE:=0A=
				handled =3D 1;=0A=
				switch (pControlRequest->wValue) {=0A=
				case USB_DEVICE_REMOTE_WAKEUP:=0A=
					pThis->bMayWakeup =3D 1;=0A=
					break;=0A=
				case USB_DEVICE_TEST_MODE:=0A=
					if (pThis->g.speed !=3D USB_SPEED_HIGH)=0A=
						goto stall;=0A=
					if (pControlRequest->wIndex & 0xff)=0A=
						goto stall;=0A=
=0A=
					switch (pControlRequest->wIndex >> 8) {=0A=
					case 1:=0A=
						pr_debug("TEST_J\n");=0A=
						/* TEST_J */=0A=
						pThis->bTestModeValue =3D=0A=
							MGC_M_TEST_J;=0A=
						break;=0A=
					case 2:=0A=
						/* TEST_K */=0A=
						pr_debug("TEST_K\n");=0A=
						pThis->bTestModeValue =3D=0A=
							MGC_M_TEST_K;=0A=
						break;=0A=
					case 3:=0A=
						/* TEST_SE0_NAK */=0A=
						pr_debug("TEST_SE0_NAK\n");=0A=
						pThis->bTestModeValue =3D=0A=
							MGC_M_TEST_SE0_NAK;=0A=
						break;=0A=
					case 4:=0A=
						/* TEST_PACKET */=0A=
						pr_debug("TEST_PACKET\n");=0A=
						pThis->bTestModeValue =3D=0A=
							MGC_M_TEST_PACKET;=0A=
						break;=0A=
					default:=0A=
						goto stall;=0A=
					}=0A=
=0A=
					/* enter test mode after irq */=0A=
					if (handled > 0)=0A=
						pThis->bTestMode =3D TRUE;=0A=
					break;=0A=
#ifdef CONFIG_USB_MUSB_OTG=0A=
				case USB_DEVICE_B_HNP_ENABLE:=0A=
					if (!pThis->g.is_otg)=0A=
						goto stall;=0A=
					{ u8 devctl;=0A=
					pThis->g.b_hnp_enable =3D 1;=0A=
					devctl =3D musb_readb(pBase,=0A=
							MGC_O_HDRC_DEVCTL);=0A=
					musb_writeb(pBase, MGC_O_HDRC_DEVCTL,=0A=
						devctl | MGC_M_DEVCTL_HR);=0A=
					}=0A=
					break;=0A=
				case USB_DEVICE_A_HNP_SUPPORT:=0A=
					if (!pThis->g.is_otg)=0A=
						goto stall;=0A=
					pThis->g.a_hnp_support =3D 1;=0A=
					break;=0A=
				case USB_DEVICE_A_ALT_HNP_SUPPORT:=0A=
					if (!pThis->g.is_otg)=0A=
						goto stall;=0A=
					pThis->g.a_alt_hnp_support =3D 1;=0A=
					break;=0A=
#endif=0A=
stall:=0A=
				default:=0A=
					handled =3D -EINVAL;=0A=
					break;=0A=
				}=0A=
				break;=0A=
=0A=
			case USB_RECIP_INTERFACE:=0A=
				break;=0A=
=0A=
			case USB_RECIP_ENDPOINT:{=0A=
				const u8		bEnd =3D=0A=
					pControlRequest->wIndex & 0x0f;=0A=
				struct musb_ep		*pEnd;=0A=
				struct musb_hw_ep	*ep;=0A=
				void __iomem		*regs;=0A=
				int			is_in;=0A=
				u16			csr;=0A=
=0A=
				if (bEnd =3D=3D 0=0A=
						|| bEnd >=3D MUSB_C_NUM_EPS=0A=
						|| pControlRequest->wValue=0A=
							!=3D USB_ENDPOINT_HALT)=0A=
					break;=0A=
=0A=
				ep =3D pThis->aLocalEnd + bEnd;=0A=
				regs =3D ep->regs;=0A=
				is_in =3D pControlRequest->wIndex & USB_DIR_IN;=0A=
				if (is_in)=0A=
					pEnd =3D &ep->ep_in;=0A=
				else=0A=
					pEnd =3D &ep->ep_out;=0A=
				if (!pEnd->desc)=0A=
					break;=0A=
=0A=
				MGC_SelectEnd(pBase, bEnd);=0A=
				if (is_in) {=0A=
					csr =3D musb_readw(regs,=0A=
							MGC_O_HDRC_TXCSR);=0A=
					if (csr & MGC_M_TXCSR_FIFONOTEMPTY)=0A=
						csr |=3D MGC_M_TXCSR_FLUSHFIFO;=0A=
					csr |=3D MGC_M_TXCSR_P_SENDSTALL=0A=
						| MGC_M_TXCSR_CLRDATATOG=0A=
						| MGC_M_TXCSR_P_WZC_BITS;=0A=
					musb_writew(regs, MGC_O_HDRC_TXCSR,=0A=
							csr);=0A=
				} else {=0A=
					csr =3D musb_readw(regs,=0A=
							MGC_O_HDRC_RXCSR);=0A=
					csr |=3D MGC_M_RXCSR_P_SENDSTALL=0A=
						| MGC_M_RXCSR_FLUSHFIFO=0A=
						| MGC_M_RXCSR_CLRDATATOG=0A=
						| MGC_M_TXCSR_P_WZC_BITS;=0A=
					musb_writew(regs, MGC_O_HDRC_RXCSR,=0A=
							csr);=0A=
				}=0A=
=0A=
				/* select ep0 again */=0A=
				MGC_SelectEnd(pBase, 0);=0A=
				handled =3D 1;=0A=
				} break;=0A=
=0A=
			default:=0A=
				/* class, vendor, etc ... delegate */=0A=
				handled =3D 0;=0A=
				break;=0A=
			}=0A=
			break;=0A=
		default:=0A=
			/* delegate SET_CONFIGURATION, etc */=0A=
			handled =3D 0;=0A=
		}=0A=
	} else=0A=
		handled =3D 0;=0A=
	return handled;=0A=
}=0A=
=0A=
/* we have an ep0out data packet=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static void ep0_rxstate(struct musb *this)=0A=
{=0A=
	void __iomem		*regs =3D this->control_ep->regs;=0A=
	struct usb_request	*req;=0A=
	u16			tmp;=0A=
=0A=
	req =3D next_ep0_request(this);=0A=
=0A=
	/* read packet and ack; or stall because of gadget driver bug:=0A=
	 * should have provided the rx buffer before setup() returned.=0A=
	 */=0A=
	if (req) {=0A=
		void		*buf =3D req->buf + req->actual;=0A=
		unsigned	len =3D req->length - req->actual;=0A=
=0A=
		/* read the buffer */=0A=
		tmp =3D musb_readb(regs, MGC_O_HDRC_COUNT0);=0A=
		if (tmp > len) {=0A=
			req->status =3D -EOVERFLOW;=0A=
			tmp =3D len;=0A=
		}=0A=
		musb_read_fifo(&this->aLocalEnd[0], tmp, buf);=0A=
		req->actual +=3D tmp;=0A=
		tmp =3D MGC_M_CSR0_P_SVDRXPKTRDY;=0A=
		if (tmp < 64 || req->actual =3D=3D req->length) {=0A=
			this->ep0_state =3D MGC_END0_STAGE_STATUSIN;=0A=
			tmp |=3D MGC_M_CSR0_P_DATAEND;=0A=
		} else=0A=
			req =3D NULL;=0A=
	} else=0A=
		tmp =3D MGC_M_CSR0_P_SVDRXPKTRDY | MGC_M_CSR0_P_SENDSTALL;=0A=
	musb_writew(regs, MGC_O_HDRC_CSR0, tmp);=0A=
=0A=
=0A=
	/* NOTE:  we "should" hold off reporting DATAEND and going to=0A=
	 * STATUSIN until after the completion handler decides whether=0A=
	 * to issue a stall instead, since this hardware can do that.=0A=
	 */=0A=
	if (req)=0A=
		musb_g_ep0_giveback(this, req);=0A=
}=0A=
=0A=
/*=0A=
 * transmitting to the host (IN), this code might be called from IRQ=0A=
 * and from kernel thread.=0A=
 *=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static void ep0_txstate(struct musb *pThis)=0A=
{=0A=
	void __iomem		*regs =3D pThis->control_ep->regs;=0A=
	struct usb_request	*pRequest =3D next_ep0_request(pThis);=0A=
	u16			wCsrVal =3D MGC_M_CSR0_TXPKTRDY;=0A=
	u8			*pFifoSource;=0A=
	u8			wFifoCount;=0A=
=0A=
	if (!pRequest) {=0A=
		// WARN_ON(1);=0A=
		DBG(2, "odd; csr0 %04x\n", musb_readw(regs, MGC_O_HDRC_CSR0));=0A=
		return;=0A=
	}=0A=
=0A=
	/* load the data */=0A=
	pFifoSource =3D (u8 *) pRequest->buf + pRequest->actual;=0A=
	wFifoCount =3D min((unsigned) MGC_END0_FIFOSIZE,=0A=
		pRequest->length - pRequest->actual);=0A=
	musb_write_fifo(&pThis->aLocalEnd[0], wFifoCount, pFifoSource);=0A=
	pRequest->actual +=3D wFifoCount;=0A=
=0A=
	/* update the flags */=0A=
	if (wFifoCount < MUSB_MAX_END0_PACKET=0A=
			|| pRequest->actual =3D=3D pRequest->length) {=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_STATUSOUT;=0A=
		wCsrVal |=3D MGC_M_CSR0_P_DATAEND;=0A=
	} else=0A=
		pRequest =3D NULL;=0A=
=0A=
	/* send it out, triggering a "txpktrdy cleared" irq */=0A=
	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);=0A=
=0A=
	/* report completions as soon as the fifo's loaded; there's no=0A=
	 * win in waiting till this last packet gets acked.  (other than=0A=
	 * very precise fault reporting, needed by USB TMC; possible with=0A=
	 * this hardware, but not usable from portable gadget drivers.)=0A=
	 */=0A=
	if (pRequest)=0A=
		musb_g_ep0_giveback(pThis, pRequest);=0A=
}=0A=
=0A=
/*=0A=
 * Read a SETUP packet (struct usb_ctrlrequest) from the hardware.=0A=
 * Fields are left in USB byte-order.=0A=
 *=0A=
 * Context:  caller holds controller lock.=0A=
 */=0A=
static void=0A=
musb_read_setup(struct musb *pThis, struct usb_ctrlrequest *req)=0A=
{=0A=
	struct usb_request	*r;=0A=
	void __iomem		*regs =3D pThis->control_ep->regs;=0A=
=0A=
	musb_read_fifo(&pThis->aLocalEnd[0], sizeof *req, (u8 *)req);=0A=
=0A=
	/* NOTE:  earlier 2.6 versions changed setup packets to host=0A=
	 * order, but now USB packets always stay in USB byte order.=0A=
	 */=0A=
	DBG(3, "SETUP req%02x.%02x v%04x i%04x l%d\n",=0A=
		req->bRequestType,=0A=
		req->bRequest,=0A=
		le16_to_cpu(req->wValue),=0A=
		le16_to_cpu(req->wIndex),=0A=
		le16_to_cpu(req->wLength));=0A=
=0A=
	/* clean up any leftover transfers */=0A=
	r =3D next_ep0_request(pThis);=0A=
	if (r)=0A=
		musb_g_ep0_giveback(pThis, r);=0A=
=0A=
	/* For zero-data requests we want to delay the STATUS stage to=0A=
	 * avoid SETUPEND errors.  If we read data (OUT), delay accepting=0A=
	 * packets until there's a buffer to store them in.=0A=
	 *=0A=
	 * If we write data, the controller acts happier if we enable=0A=
	 * the TX FIFO right away, and give the controller a moment=0A=
	 * to switch modes...=0A=
	 */=0A=
	pThis->bSetAddress =3D FALSE;=0A=
	pThis->ackpend =3D MGC_M_CSR0_P_SVDRXPKTRDY;=0A=
	if (req->wLength =3D=3D 0) {=0A=
		if (req->bRequestType & USB_DIR_IN)=0A=
			pThis->ackpend |=3D MGC_M_CSR0_TXPKTRDY;=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_ACKWAIT;=0A=
	} else if (req->bRequestType & USB_DIR_IN) {=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_TX;=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SVDRXPKTRDY);=0A=
		while ((musb_readw(regs, MGC_O_HDRC_CSR0)=0A=
				& MGC_M_CSR0_RXPKTRDY) !=3D 0)=0A=
			cpu_relax();=0A=
		pThis->ackpend =3D 0;=0A=
	} else=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_RX;=0A=
}=0A=
=0A=
static int=0A=
forward_to_driver(struct musb *musb,=0A=
		const struct usb_ctrlrequest *pControlRequest)=0A=
__releases(musb->Lock)=0A=
__acquires(musb->Lock)=0A=
{=0A=
	int retval;=0A=
	if (!musb->pGadgetDriver)=0A=
		return -EOPNOTSUPP;=0A=
	spin_unlock(&musb->Lock);=0A=
	retval =3D musb->pGadgetDriver->setup(&musb->g, pControlRequest);=0A=
	spin_lock(&musb->Lock);=0A=
	return retval;=0A=
}=0A=
=0A=
/*=0A=
 * Handle peripheral ep0 interrupt=0A=
 * @param pThis this=0A=
 *=0A=
 * Context: irq handler; we won't re-enter the driver that way.=0A=
 */=0A=
irqreturn_t musb_g_ep0_irq(struct musb *pThis)=0A=
{=0A=
	u16		wCsrVal;=0A=
	u16		wCount;=0A=
	void __iomem	*pBase =3D pThis->pRegs;=0A=
	void __iomem	*regs =3D pThis->aLocalEnd[0].regs;=0A=
	irqreturn_t	retval =3D IRQ_NONE;=0A=
=0A=
	MGC_SelectEnd(pBase, 0);	/* select ep0 */=0A=
	wCsrVal =3D musb_readw(regs, MGC_O_HDRC_CSR0);=0A=
	wCount =3D musb_readb(regs, MGC_O_HDRC_COUNT0);=0A=
=0A=
	DBG(4, "csr %04x, count %d, myaddr %d, ep0stage %s\n",=0A=
			wCsrVal, wCount,=0A=
			musb_readb(pBase, MGC_O_HDRC_FADDR),=0A=
			decode_ep0stage(pThis->ep0_state));=0A=
=0A=
	/* I sent a stall.. need to acknowledge it now.. */=0A=
	if (wCsrVal & MGC_M_CSR0_P_SENTSTALL) {=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0,=0A=
				wCsrVal & ~MGC_M_CSR0_P_SENTSTALL);=0A=
		retval =3D IRQ_HANDLED;=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		wCsrVal =3D musb_readw(regs, MGC_O_HDRC_CSR0);=0A=
	}=0A=
=0A=
	/* request ended "early" */=0A=
	if (wCsrVal & MGC_M_CSR0_P_SETUPEND) {=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SVDSETUPEND);=0A=
		retval =3D IRQ_HANDLED;=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		wCsrVal =3D musb_readw(regs, MGC_O_HDRC_CSR0);=0A=
		/* NOTE:  request may need completion */=0A=
	}=0A=
=0A=
	/* docs from Mentor only describe tx, rx, and idle/setup states.=0A=
	 * we need to handle nuances around status stages, and also the=0A=
	 * case where status and setup stages come back-to-back ...=0A=
	 */=0A=
	switch (pThis->ep0_state) {=0A=
=0A=
	case MGC_END0_STAGE_TX:=0A=
		/* irq on clearing txpktrdy */=0A=
		if ((wCsrVal & MGC_M_CSR0_TXPKTRDY) =3D=3D 0) {=0A=
			ep0_txstate(pThis);=0A=
			retval =3D IRQ_HANDLED;=0A=
		}=0A=
		break;=0A=
=0A=
	case MGC_END0_STAGE_RX:=0A=
		/* irq on set rxpktrdy */=0A=
		if (wCsrVal & MGC_M_CSR0_RXPKTRDY) {=0A=
			ep0_rxstate(pThis);=0A=
			retval =3D IRQ_HANDLED;=0A=
		}=0A=
		break;=0A=
=0A=
	case MGC_END0_STAGE_STATUSIN:=0A=
		/* end of sequence #2 (OUT/RX state) or #3 (no data) */=0A=
=0A=
		/* update address (if needed) only @ the end of the=0A=
		 * status phase per usb spec, which also guarantees=0A=
		 * we get 10 msec to receive this irq... until this=0A=
		 * is done we won't see the next packet.=0A=
		 */=0A=
		if (pThis->bSetAddress) {=0A=
			pThis->bSetAddress =3D FALSE;=0A=
			musb_writeb(pBase, MGC_O_HDRC_FADDR, pThis->bAddress);=0A=
		}=0A=
=0A=
		/* enter test mode if needed (exit by reset) */=0A=
		else if (pThis->bTestMode) {=0A=
			DBG(1, "entering TESTMODE\n");=0A=
=0A=
			if (MGC_M_TEST_PACKET =3D=3D pThis->bTestModeValue)=0A=
				musb_load_testpacket(pThis);=0A=
=0A=
			musb_writeb(pBase, MGC_O_HDRC_TESTMODE,=0A=
					pThis->bTestModeValue);=0A=
		}=0A=
		/* FALLTHROUGH */=0A=
=0A=
	case MGC_END0_STAGE_STATUSOUT:=0A=
		/* end of sequence #1: write to host (TX state) */=0A=
		{=0A=
			struct usb_request	*req;=0A=
=0A=
			req =3D next_ep0_request(pThis);=0A=
			if (req)=0A=
				musb_g_ep0_giveback(pThis, req);=0A=
		}=0A=
		retval =3D IRQ_HANDLED;=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		/* FALLTHROUGH */=0A=
=0A=
	case MGC_END0_STAGE_SETUP:=0A=
		if (wCsrVal & MGC_M_CSR0_RXPKTRDY) {=0A=
			struct usb_ctrlrequest	setup;=0A=
			int			handled =3D 0;=0A=
=0A=
			if (wCount !=3D 8) {=0A=
				ERR("SETUP packet len %d !=3D 8 ?\n", wCount);=0A=
				break;=0A=
			}=0A=
			musb_read_setup(pThis, &setup);=0A=
			retval =3D IRQ_HANDLED;=0A=
=0A=
			/* sometimes the RESET won't be reported */=0A=
			if (unlikely(pThis->g.speed =3D=3D USB_SPEED_UNKNOWN)) {=0A=
				u8	power;=0A=
=0A=
				printk(KERN_NOTICE "%s: peripheral reset "=0A=
						"irq lost!\n",=0A=
						musb_driver_name);=0A=
				power =3D musb_readb(pBase, MGC_O_HDRC_POWER);=0A=
				pThis->g.speed =3D (power & MGC_M_POWER_HSMODE)=0A=
					? USB_SPEED_HIGH : USB_SPEED_FULL;=0A=
=0A=
			}=0A=
=0A=
			switch (pThis->ep0_state) {=0A=
=0A=
			/* sequence #3 (no data stage), includes requests=0A=
			 * we can't forward (notably SET_ADDRESS and the=0A=
			 * device/endpoint feature set/clear operations)=0A=
			 * plus SET_CONFIGURATION and others we must=0A=
			 */=0A=
			case MGC_END0_STAGE_ACKWAIT:=0A=
				handled =3D service_zero_data_request(=0A=
						pThis, &setup);=0A=
=0A=
				/* status stage might be immediate */=0A=
				if (handled > 0) {=0A=
					pThis->ackpend |=3D MGC_M_CSR0_P_DATAEND;=0A=
					pThis->ep0_state =3D=0A=
						MGC_END0_STAGE_STATUSIN;=0A=
				}=0A=
				break;=0A=
=0A=
			/* sequence #1 (IN to host), includes GET_STATUS=0A=
			 * requests that we can't forward, GET_DESCRIPTOR=0A=
			 * and others that we must=0A=
			 */=0A=
			case MGC_END0_STAGE_TX:=0A=
				handled =3D service_in_request(pThis, &setup);=0A=
				if (handled > 0) {=0A=
					pThis->ackpend =3D MGC_M_CSR0_TXPKTRDY=0A=
						| MGC_M_CSR0_P_DATAEND;=0A=
					pThis->ep0_state =3D=0A=
						MGC_END0_STAGE_STATUSOUT;=0A=
				}=0A=
				break;=0A=
=0A=
			/* sequence #2 (OUT from host), always forward */=0A=
			default:		/* MGC_END0_STAGE_RX */=0A=
				break;=0A=
			}=0A=
=0A=
			DBG(3, "handled %d, csr %04x, ep0stage %s\n",=0A=
				handled, wCsrVal,=0A=
				decode_ep0stage(pThis->ep0_state));=0A=
=0A=
			/* unless we need to delegate this to the gadget=0A=
			 * driver, we know how to wrap this up:  csr0 has=0A=
			 * not yet been written.=0A=
			 */=0A=
			if (handled < 0)=0A=
				goto stall;=0A=
			else if (handled > 0)=0A=
				goto finish;=0A=
=0A=
			handled =3D forward_to_driver(pThis, &setup);=0A=
			if (handled < 0) {=0A=
				MGC_SelectEnd(pBase, 0);=0A=
stall:=0A=
				DBG(3, "stall (%d)\n", handled);=0A=
				pThis->ackpend |=3D MGC_M_CSR0_P_SENDSTALL;=0A=
				pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
finish:=0A=
				musb_writew(regs, MGC_O_HDRC_CSR0,=0A=
						pThis->ackpend);=0A=
				pThis->ackpend =3D 0;=0A=
			}=0A=
		}=0A=
		break;=0A=
=0A=
	case MGC_END0_STAGE_ACKWAIT:=0A=
		/* This should not happen. But happens with tusb6010 with=0A=
		 * g_file_storage and high speed. Do nothing.=0A=
		 */=0A=
		retval =3D IRQ_HANDLED;=0A=
		break;=0A=
=0A=
	default:=0A=
		/* "can't happen" */=0A=
		WARN_ON(1);=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SENDSTALL);=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		break;=0A=
	}=0A=
=0A=
	return retval;=0A=
}=0A=
=0A=
=0A=
static int=0A=
musb_g_ep0_enable(struct usb_ep *ep, const struct =
usb_endpoint_descriptor *desc)=0A=
{=0A=
	/* always enabled */=0A=
	return -EINVAL;=0A=
}=0A=
=0A=
static int musb_g_ep0_disable(struct usb_ep *e)=0A=
{=0A=
	/* always enabled */=0A=
	return -EINVAL;=0A=
}=0A=
=0A=
static void *musb_g_ep0_alloc_buffer(struct usb_ep *ep, unsigned =
bytes,=0A=
			dma_addr_t * dma, gfp_t gfp_flags)=0A=
{=0A=
	*dma =3D DMA_ADDR_INVALID;=0A=
	return kmalloc(bytes, gfp_flags);=0A=
}=0A=
=0A=
static void musb_g_ep0_free_buffer(struct usb_ep *ep, void *address,=0A=
			dma_addr_t dma, unsigned bytes)=0A=
{=0A=
	kfree(address);=0A=
}=0A=
=0A=
static int=0A=
musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t =
gfp_flags)=0A=
{=0A=
	struct musb_ep		*ep;=0A=
	struct musb_request	*req;=0A=
	struct musb		*musb;=0A=
	int			status;=0A=
	unsigned long		lockflags;=0A=
	void __iomem		*regs;=0A=
=0A=
	if (!e || !r)=0A=
		return -EINVAL;=0A=
=0A=
	ep =3D to_musb_ep(e);=0A=
	musb =3D ep->pThis;=0A=
	regs =3D musb->control_ep->regs;=0A=
=0A=
	req =3D to_musb_request(r);=0A=
	req->musb =3D musb;=0A=
	req->request.actual =3D 0;=0A=
	req->request.status =3D -EINPROGRESS;=0A=
	req->bTx =3D ep->is_in;=0A=
=0A=
	spin_lock_irqsave(&musb->Lock, lockflags);=0A=
=0A=
	if (!list_empty(&ep->req_list)) {=0A=
		status =3D -EBUSY;=0A=
		goto cleanup;=0A=
	}=0A=
=0A=
	switch (musb->ep0_state) {=0A=
	case MGC_END0_STAGE_RX:		/* control-OUT data */=0A=
	case MGC_END0_STAGE_TX:		/* control-IN data */=0A=
	case MGC_END0_STAGE_ACKWAIT:	/* zero-length data */=0A=
		status =3D 0;=0A=
		break;=0A=
	default:=0A=
		DBG(1, "ep0 request queued in state %d\n",=0A=
				musb->ep0_state);=0A=
		status =3D -EINVAL;=0A=
		goto cleanup;=0A=
	}=0A=
=0A=
	/* add request to the list */=0A=
	list_add_tail(&(req->request.list), &(ep->req_list));=0A=
=0A=
	DBG(3, "queue to %s (%s), length=3D%d\n",=0A=
			ep->name, ep->is_in ? "IN/TX" : "OUT/RX",=0A=
			req->request.length);=0A=
=0A=
	MGC_SelectEnd(musb->pRegs, 0);=0A=
=0A=
	/* sequence #1, IN ... start writing the data */=0A=
	if (musb->ep0_state =3D=3D MGC_END0_STAGE_TX)=0A=
		ep0_txstate(musb);=0A=
=0A=
	/* sequence #3, no-data ... issue IN status */=0A=
	else if (musb->ep0_state =3D=3D MGC_END0_STAGE_ACKWAIT) {=0A=
		if (req->request.length)=0A=
			status =3D -EINVAL;=0A=
		else {=0A=
			musb->ep0_state =3D MGC_END0_STAGE_STATUSIN;=0A=
			musb_writew(regs, MGC_O_HDRC_CSR0,=0A=
					musb->ackpend | MGC_M_CSR0_P_DATAEND);=0A=
			musb->ackpend =3D 0;=0A=
			musb_g_ep0_giveback(ep->pThis, r);=0A=
		}=0A=
=0A=
	/* else for sequence #2 (OUT), caller provides a buffer=0A=
	 * before the next packet arrives.  deferred responses=0A=
	 * (after SETUP is acked) are racey.=0A=
	 */=0A=
	} else if (musb->ackpend) {=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, musb->ackpend);=0A=
		musb->ackpend =3D 0;=0A=
	}=0A=
=0A=
cleanup:=0A=
	spin_unlock_irqrestore(&musb->Lock, lockflags);=0A=
	return status;=0A=
}=0A=
=0A=
static int=0A=
musb_g_ep0_dequeue(struct usb_ep *ep, struct usb_request *req)=0A=
{=0A=
	/* we just won't support this */=0A=
	return -EINVAL;=0A=
}=0A=
=0A=
static int musb_g_ep0_halt(struct usb_ep *e, int value)=0A=
{=0A=
	struct musb_ep		*ep;=0A=
	struct musb		*musb;=0A=
	void __iomem		*base, *regs;=0A=
	unsigned long		flags;=0A=
	int			status;=0A=
	u16			csr;=0A=
=0A=
	if (!e || !value)=0A=
		return -EINVAL;=0A=
=0A=
	ep =3D to_musb_ep(e);=0A=
	musb =3D ep->pThis;=0A=
	base =3D musb->pRegs;=0A=
	regs =3D musb->control_ep->regs;=0A=
=0A=
	spin_lock_irqsave(&musb->Lock, flags);=0A=
=0A=
	if (!list_empty(&ep->req_list)) {=0A=
		status =3D -EBUSY;=0A=
		goto cleanup;=0A=
	}=0A=
=0A=
	switch (musb->ep0_state) {=0A=
	case MGC_END0_STAGE_TX:		/* control-IN data */=0A=
	case MGC_END0_STAGE_ACKWAIT:	/* STALL for zero-length data */=0A=
	case MGC_END0_STAGE_RX:		/* control-OUT data */=0A=
		status =3D 0;=0A=
=0A=
		MGC_SelectEnd(base, 0);=0A=
		csr =3D musb_readw(regs, MGC_O_HDRC_CSR0);=0A=
		csr |=3D MGC_M_CSR0_P_SENDSTALL;=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, csr);=0A=
		musb->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		break;=0A=
	default:=0A=
		DBG(1, "ep0 can't halt in state %d\n", musb->ep0_state);=0A=
		status =3D -EINVAL;=0A=
	}=0A=
=0A=
cleanup:=0A=
	spin_unlock_irqrestore(&musb->Lock, flags);=0A=
	return status;=0A=
}=0A=
=0A=
const struct usb_ep_ops musb_g_ep0_ops =3D {=0A=
	.enable		=3D musb_g_ep0_enable,=0A=
	.disable	=3D musb_g_ep0_disable,=0A=
	.alloc_request	=3D musb_alloc_request,=0A=
	.free_request	=3D musb_free_request,=0A=
	.alloc_buffer	=3D musb_g_ep0_alloc_buffer,=0A=
	.free_buffer	=3D musb_g_ep0_free_buffer,=0A=
	.queue		=3D musb_g_ep0_queue,=0A=
	.dequeue	=3D musb_g_ep0_dequeue,=0A=
	.set_halt	=3D musb_g_ep0_halt,=0A=
	.fifo_status	=3D NULL,=0A=
	.fifo_flush	=3D NULL,=0A=
};=0A=

------_=_NextPart_000_01C79264.D7BC5F60
Content-Type: application/octet-stream;
	name="g_ep0.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="g_ep0.c"

/******************************************************************=0A=
 * Copyright 2005 Mentor Graphics Corporation=0A=
 * Copyright (C) 2005-2006 by Texas Instruments=0A=
 *=0A=
 * This file is part of the Inventra Controller Driver for Linux.=0A=
 *=0A=
 * The Inventra Controller Driver for Linux is free software; you=0A=
 * can redistribute it and/or modify it under the terms of the GNU=0A=
 * General Public License version 2 as published by the Free =
Software=0A=
 * Foundation.=0A=
 *=0A=
 * The Inventra Controller Driver for Linux is distributed in=0A=
 * the hope that it will be useful, but WITHOUT ANY WARRANTY;=0A=
 * without even the implied warranty of MERCHANTABILITY or=0A=
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public=0A=
 * License for more details.=0A=
 *=0A=
 * You should have received a copy of the GNU General Public License=0A=
 * along with The Inventra Controller Driver for Linux ; if not,=0A=
 * write to the Free Software Foundation, Inc., 59 Temple Place,=0A=
 * Suite 330, Boston, MA  02111-1307  USA=0A=
 *=0A=
 * ANY DOWNLOAD, USE, REPRODUCTION, MODIFICATION OR DISTRIBUTION=0A=
 * OF THIS DRIVER INDICATES YOUR COMPLETE AND UNCONDITIONAL =
ACCEPTANCE=0A=
 * OF THOSE TERMS.THIS DRIVER IS PROVIDED "AS IS" AND MENTOR =
GRAPHICS=0A=
 * MAKES NO WARRANTIES, EXPRESS OR IMPLIED, RELATED TO THIS DRIVER.=0A=
 * MENTOR GRAPHICS SPECIFICALLY DISCLAIMS ALL IMPLIED WARRANTIES=0A=
 * OF MERCHANTABILITY; FITNESS FOR A PARTICULAR PURPOSE AND=0A=
 * NON-INFRINGEMENT.  MENTOR GRAPHICS DOES NOT PROVIDE SUPPORT=0A=
 * SERVICES OR UPDATES FOR THIS DRIVER, EVEN IF YOU ARE A MENTOR=0A=
 * GRAPHICS SUPPORT CUSTOMER.=0A=
 ******************************************************************/=0A=
=0A=
#include <linux/kernel.h>=0A=
#include <linux/list.h>=0A=
#include <linux/timer.h>=0A=
#include <linux/spinlock.h>=0A=
#include <linux/init.h>=0A=
#include <linux/device.h>=0A=
#include <linux/interrupt.h>=0A=
=0A=
#include "musbdefs.h"=0A=
=0A=
/* ep0 is always musb->aLocalEnd[0].ep_in */=0A=
#define	next_ep0_request(musb)	=
next_in_request(&(musb)->aLocalEnd[0])=0A=
=0A=
/*=0A=
 * Locking note:  we use only the controller lock, for simpler =
correctness.=0A=
 * It's always held with IRQs blocked.=0A=
 *=0A=
 * It protects the ep0 request queue as well as ep0_state, not just =
the=0A=
 * controller and indexed registers.  And that lock stays held unless =
it=0A=
 * needs to be dropped to allow reentering this driver ... like upcalls =
to=0A=
 * the gadget driver, or adjusting endpoint halt status.=0A=
 */=0A=
=0A=
static char *decode_ep0stage(u8 stage)=0A=
{=0A=
	switch(stage) {=0A=
	case MGC_END0_STAGE_SETUP:	return "idle";=0A=
	case MGC_END0_STAGE_TX:		return "in";=0A=
	case MGC_END0_STAGE_RX:		return "out";=0A=
	case MGC_END0_STAGE_ACKWAIT:	return "wait";=0A=
	case MGC_END0_STAGE_STATUSIN:	return "in/status";=0A=
	case MGC_END0_STAGE_STATUSOUT:	return "out/status";=0A=
	default:			return "?";=0A=
	}=0A=
}=0A=
=0A=
/* handle a standard GET_STATUS request=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static int service_tx_status_request(=0A=
	struct musb *pThis,=0A=
	const struct usb_ctrlrequest *pControlRequest)=0A=
{=0A=
	void __iomem	*pBase =3D pThis->pRegs;=0A=
	int handled =3D 1;=0A=
	u8 bResult[2], bEnd =3D 0;=0A=
	const u8 bRecip =3D pControlRequest->bRequestType & USB_RECIP_MASK;=0A=
=0A=
	bResult[1] =3D 0;=0A=
=0A=
	switch (bRecip) {=0A=
	case USB_RECIP_DEVICE:=0A=
		bResult[0] =3D pThis->bIsSelfPowered << USB_DEVICE_SELF_POWERED;=0A=
		bResult[0] |=3D pThis->bMayWakeup << USB_DEVICE_REMOTE_WAKEUP;=0A=
#ifdef CONFIG_USB_MUSB_OTG=0A=
		if (pThis->g.is_otg) {=0A=
			bResult[0] |=3D pThis->g.b_hnp_enable=0A=
				<< USB_DEVICE_B_HNP_ENABLE;=0A=
			bResult[0] |=3D pThis->g.a_alt_hnp_support=0A=
				<< USB_DEVICE_A_ALT_HNP_SUPPORT;=0A=
			bResult[0] |=3D pThis->g.a_hnp_support=0A=
				<< USB_DEVICE_A_HNP_SUPPORT;=0A=
		}=0A=
#endif=0A=
		break;=0A=
=0A=
	case USB_RECIP_INTERFACE:=0A=
		bResult[0] =3D 0;=0A=
		break;=0A=
=0A=
	case USB_RECIP_ENDPOINT: {=0A=
		int		is_in;=0A=
		struct musb_ep	*ep;=0A=
		u16		tmp;=0A=
		void __iomem	*regs;=0A=
=0A=
		bEnd =3D (u8) pControlRequest->wIndex;=0A=
		if (!bEnd) {=0A=
			bResult[0] =3D 0;=0A=
			break;=0A=
		}=0A=
=0A=
		is_in =3D bEnd & USB_DIR_IN;=0A=
		if (is_in) {=0A=
			bEnd &=3D 0x0f;=0A=
			ep =3D &pThis->aLocalEnd[bEnd].ep_in;=0A=
		} else {=0A=
			ep =3D &pThis->aLocalEnd[bEnd].ep_out;=0A=
		}=0A=
		regs =3D pThis->aLocalEnd[bEnd].regs;=0A=
=0A=
		if (bEnd >=3D MUSB_C_NUM_EPS || !ep->desc) {=0A=
			handled =3D -EINVAL;=0A=
			break;=0A=
		}=0A=
=0A=
		MGC_SelectEnd(pBase, bEnd);=0A=
		if (is_in)=0A=
			tmp =3D musb_readw(regs, MGC_O_HDRC_TXCSR)=0A=
						& MGC_M_TXCSR_P_SENDSTALL;=0A=
		else=0A=
			tmp =3D musb_readw(regs, MGC_O_HDRC_RXCSR)=0A=
						& MGC_M_RXCSR_P_SENDSTALL;=0A=
		MGC_SelectEnd(pBase, 0);=0A=
=0A=
		bResult[0] =3D tmp ? 1 : 0;=0A=
		} break;=0A=
=0A=
	default:=0A=
		/* class, vendor, etc ... delegate */=0A=
		handled =3D 0;=0A=
		break;=0A=
	}=0A=
=0A=
	/* fill up the fifo; caller updates csr0 */=0A=
	if (handled > 0) {=0A=
		u16	len =3D le16_to_cpu(pControlRequest->wLength);=0A=
=0A=
		if (len > 2)=0A=
			len =3D 2;=0A=
		musb_write_fifo(&pThis->aLocalEnd[0], len, bResult);=0A=
	}=0A=
=0A=
	return handled;=0A=
}=0A=
=0A=
/*=0A=
 * handle a control-IN request, the end0 buffer contains the current =
request=0A=
 * that is supposed to be a standard control request. Assumes the fifo =
to=0A=
 * be at least 2 bytes long.=0A=
 *=0A=
 * @return 0 if the request was NOT HANDLED,=0A=
 * < 0 when error=0A=
 * > 0 when the request is processed=0A=
 *=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static int=0A=
service_in_request(struct musb *pThis,=0A=
		const struct usb_ctrlrequest *pControlRequest)=0A=
{=0A=
	int handled =3D 0;	/* not handled */=0A=
=0A=
	if ((pControlRequest->bRequestType & USB_TYPE_MASK)=0A=
			=3D=3D USB_TYPE_STANDARD) {=0A=
		switch (pControlRequest->bRequest) {=0A=
		case USB_REQ_GET_STATUS:=0A=
			handled =3D service_tx_status_request(pThis,=0A=
					pControlRequest);=0A=
			break;=0A=
=0A=
		/* case USB_REQ_SYNC_FRAME: */=0A=
=0A=
		default:=0A=
			break;=0A=
		}=0A=
	}=0A=
	return handled;=0A=
}=0A=
=0A=
/*=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static void musb_g_ep0_giveback(struct musb *pThis, struct usb_request =
*req)=0A=
{=0A=
	musb_g_giveback(&pThis->aLocalEnd[0].ep_in, req, 0);=0A=
}=0A=
=0A=
/*=0A=
 * Handle all control requests with no DATA stage, including =
standard=0A=
 * requests such as:=0A=
 * USB_REQ_SET_CONFIGURATION, USB_REQ_SET_INTERFACE, unrecognized=0A=
 *	always delegated to the gadget driver=0A=
 * USB_REQ_SET_ADDRESS, USB_REQ_CLEAR_FEATURE, USB_REQ_SET_FEATURE=0A=
 *	always handled here, except for class/vendor/... features=0A=
 *=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static int=0A=
service_zero_data_request(struct musb *pThis,=0A=
		struct usb_ctrlrequest *pControlRequest)=0A=
__releases(pThis->Lock)=0A=
__acquires(pThis->Lock)=0A=
{=0A=
	int handled =3D -EINVAL;=0A=
	void __iomem *pBase =3D pThis->pRegs;=0A=
	const u8 bRecip =3D pControlRequest->bRequestType & USB_RECIP_MASK;=0A=
=0A=
	/* the gadget driver handles everything except what we MUST handle =
*/=0A=
	if ((pControlRequest->bRequestType & USB_TYPE_MASK)=0A=
			=3D=3D USB_TYPE_STANDARD) {=0A=
		switch (pControlRequest->bRequest) {=0A=
		case USB_REQ_SET_ADDRESS:=0A=
			/* change it after the status stage */=0A=
			pThis->bSetAddress =3D TRUE;=0A=
			pThis->bAddress =3D (u8) (pControlRequest->wValue & 0x7f);=0A=
			handled =3D 1;=0A=
			break;=0A=
=0A=
		case USB_REQ_CLEAR_FEATURE:=0A=
			switch (bRecip) {=0A=
			case USB_RECIP_DEVICE:=0A=
				if (pControlRequest->wValue=0A=
						!=3D USB_DEVICE_REMOTE_WAKEUP)=0A=
					break;=0A=
				pThis->bMayWakeup =3D 0;=0A=
				handled =3D 1;=0A=
				break;=0A=
			case USB_RECIP_INTERFACE:=0A=
				break;=0A=
			case USB_RECIP_ENDPOINT:{=0A=
				const u8 bEnd =3D pControlRequest->wIndex & 0x0f;=0A=
				struct musb_ep *pEnd;=0A=
=0A=
				if (bEnd =3D=3D 0=0A=
						|| bEnd >=3D MUSB_C_NUM_EPS=0A=
						|| pControlRequest->wValue=0A=
							!=3D USB_ENDPOINT_HALT)=0A=
					break;=0A=
=0A=
				if (pControlRequest->wIndex & USB_DIR_IN)=0A=
					pEnd =3D &pThis->aLocalEnd[bEnd].ep_in;=0A=
				else=0A=
					pEnd =3D &pThis->aLocalEnd[bEnd].ep_out;=0A=
				if (!pEnd->desc)=0A=
					break;=0A=
=0A=
				/* REVISIT do it directly, no locking games */=0A=
				spin_unlock(&pThis->Lock);=0A=
				musb_gadget_set_halt(&pEnd->end_point, 0);=0A=
				spin_lock(&pThis->Lock);=0A=
=0A=
				/* select ep0 again */=0A=
				MGC_SelectEnd(pBase, 0);=0A=
				handled =3D 1;=0A=
				} break;=0A=
			default:=0A=
				/* class, vendor, etc ... delegate */=0A=
				handled =3D 0;=0A=
				break;=0A=
			}=0A=
			break;=0A=
=0A=
		case USB_REQ_SET_FEATURE:=0A=
			switch (bRecip) {=0A=
			case USB_RECIP_DEVICE:=0A=
				handled =3D 1;=0A=
				switch (pControlRequest->wValue) {=0A=
				case USB_DEVICE_REMOTE_WAKEUP:=0A=
					pThis->bMayWakeup =3D 1;=0A=
					break;=0A=
				case USB_DEVICE_TEST_MODE:=0A=
					if (pThis->g.speed !=3D USB_SPEED_HIGH)=0A=
						goto stall;=0A=
					if (pControlRequest->wIndex & 0xff)=0A=
						goto stall;=0A=
=0A=
					switch (pControlRequest->wIndex >> 8) {=0A=
					case 1:=0A=
						pr_debug("TEST_J\n");=0A=
						/* TEST_J */=0A=
						pThis->bTestModeValue =3D=0A=
							MGC_M_TEST_J;=0A=
						break;=0A=
					case 2:=0A=
						/* TEST_K */=0A=
						pr_debug("TEST_K\n");=0A=
						pThis->bTestModeValue =3D=0A=
							MGC_M_TEST_K;=0A=
						break;=0A=
					case 3:=0A=
						/* TEST_SE0_NAK */=0A=
						pr_debug("TEST_SE0_NAK\n");=0A=
						pThis->bTestModeValue =3D=0A=
							MGC_M_TEST_SE0_NAK;=0A=
						break;=0A=
					case 4:=0A=
						/* TEST_PACKET */=0A=
						pr_debug("TEST_PACKET\n");=0A=
						pThis->bTestModeValue =3D=0A=
							MGC_M_TEST_PACKET;=0A=
						break;=0A=
					default:=0A=
						goto stall;=0A=
					}=0A=
=0A=
					/* enter test mode after irq */=0A=
					if (handled > 0)=0A=
						pThis->bTestMode =3D TRUE;=0A=
					break;=0A=
#ifdef CONFIG_USB_MUSB_OTG=0A=
				case USB_DEVICE_B_HNP_ENABLE:=0A=
					if (!pThis->g.is_otg)=0A=
						goto stall;=0A=
					{ u8 devctl;=0A=
					pThis->g.b_hnp_enable =3D 1;=0A=
					devctl =3D musb_readb(pBase,=0A=
							MGC_O_HDRC_DEVCTL);=0A=
					musb_writeb(pBase, MGC_O_HDRC_DEVCTL,=0A=
						devctl | MGC_M_DEVCTL_HR);=0A=
					}=0A=
					break;=0A=
				case USB_DEVICE_A_HNP_SUPPORT:=0A=
					if (!pThis->g.is_otg)=0A=
						goto stall;=0A=
					pThis->g.a_hnp_support =3D 1;=0A=
					break;=0A=
				case USB_DEVICE_A_ALT_HNP_SUPPORT:=0A=
					if (!pThis->g.is_otg)=0A=
						goto stall;=0A=
					pThis->g.a_alt_hnp_support =3D 1;=0A=
					break;=0A=
#endif=0A=
stall:=0A=
				default:=0A=
					handled =3D -EINVAL;=0A=
					break;=0A=
				}=0A=
				break;=0A=
=0A=
			case USB_RECIP_INTERFACE:=0A=
				break;=0A=
=0A=
			case USB_RECIP_ENDPOINT:{=0A=
				const u8		bEnd =3D=0A=
					pControlRequest->wIndex & 0x0f;=0A=
				struct musb_ep		*pEnd;=0A=
				struct musb_hw_ep	*ep;=0A=
				void __iomem		*regs;=0A=
				int			is_in;=0A=
				u16			csr;=0A=
=0A=
				if (bEnd =3D=3D 0=0A=
						|| bEnd >=3D MUSB_C_NUM_EPS=0A=
						|| pControlRequest->wValue=0A=
							!=3D USB_ENDPOINT_HALT)=0A=
					break;=0A=
=0A=
				ep =3D pThis->aLocalEnd + bEnd;=0A=
				regs =3D ep->regs;=0A=
				is_in =3D pControlRequest->wIndex & USB_DIR_IN;=0A=
				if (is_in)=0A=
					pEnd =3D &ep->ep_in;=0A=
				else=0A=
					pEnd =3D &ep->ep_out;=0A=
				if (!pEnd->desc)=0A=
					break;=0A=
=0A=
				MGC_SelectEnd(pBase, bEnd);=0A=
				if (is_in) {=0A=
					csr =3D musb_readw(regs,=0A=
							MGC_O_HDRC_TXCSR);=0A=
					if (csr & MGC_M_TXCSR_FIFONOTEMPTY)=0A=
						csr |=3D MGC_M_TXCSR_FLUSHFIFO;=0A=
					csr |=3D MGC_M_TXCSR_P_SENDSTALL=0A=
						| MGC_M_TXCSR_CLRDATATOG=0A=
						| MGC_M_TXCSR_P_WZC_BITS;=0A=
					musb_writew(regs, MGC_O_HDRC_TXCSR,=0A=
							csr);=0A=
				} else {=0A=
					csr =3D musb_readw(regs,=0A=
							MGC_O_HDRC_RXCSR);=0A=
					csr |=3D MGC_M_RXCSR_P_SENDSTALL=0A=
						| MGC_M_RXCSR_FLUSHFIFO=0A=
						| MGC_M_RXCSR_CLRDATATOG=0A=
						| MGC_M_TXCSR_P_WZC_BITS;=0A=
					musb_writew(regs, MGC_O_HDRC_RXCSR,=0A=
							csr);=0A=
				}=0A=
=0A=
				/* select ep0 again */=0A=
				MGC_SelectEnd(pBase, 0);=0A=
				handled =3D 1;=0A=
				} break;=0A=
=0A=
			default:=0A=
				/* class, vendor, etc ... delegate */=0A=
				handled =3D 0;=0A=
				break;=0A=
			}=0A=
			break;=0A=
		default:=0A=
			/* delegate SET_CONFIGURATION, etc */=0A=
			handled =3D 0;=0A=
		}=0A=
	} else=0A=
		handled =3D 0;=0A=
	return handled;=0A=
}=0A=
=0A=
/* we have an ep0out data packet=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static void ep0_rxstate(struct musb *this)=0A=
{=0A=
	void __iomem		*regs =3D this->control_ep->regs;=0A=
	struct usb_request	*req;=0A=
	u16			tmp;=0A=
=0A=
	req =3D next_ep0_request(this);=0A=
=0A=
	/* read packet and ack; or stall because of gadget driver bug:=0A=
	 * should have provided the rx buffer before setup() returned.=0A=
	 */=0A=
	if (req) {=0A=
		void		*buf =3D req->buf + req->actual;=0A=
		unsigned	len =3D req->length - req->actual;=0A=
=0A=
		/* read the buffer */=0A=
		tmp =3D musb_readb(regs, MGC_O_HDRC_COUNT0);=0A=
		if (tmp > len) {=0A=
			req->status =3D -EOVERFLOW;=0A=
			tmp =3D len;=0A=
		}=0A=
		musb_read_fifo(&this->aLocalEnd[0], tmp, buf);=0A=
		req->actual +=3D tmp;=0A=
		tmp =3D MGC_M_CSR0_P_SVDRXPKTRDY;=0A=
		if (tmp < 64 || req->actual =3D=3D req->length) {=0A=
			this->ep0_state =3D MGC_END0_STAGE_STATUSIN;=0A=
			tmp |=3D MGC_M_CSR0_P_DATAEND;=0A=
		} else=0A=
			req =3D NULL;=0A=
	} else=0A=
		tmp =3D MGC_M_CSR0_P_SVDRXPKTRDY | MGC_M_CSR0_P_SENDSTALL;=0A=
=0A=
=0A=
	/* NOTE:  we "should" hold off reporting DATAEND and going to=0A=
	 * STATUSIN until after the completion handler decides whether=0A=
	 * to issue a stall instead, since this hardware can do that.=0A=
	 */=0A=
	if (req)=0A=
		musb_g_ep0_giveback(this, req);=0A=
	musb_writew(regs, MGC_O_HDRC_CSR0, tmp);=0A=
}=0A=
=0A=
/*=0A=
 * transmitting to the host (IN), this code might be called from IRQ=0A=
 * and from kernel thread.=0A=
 *=0A=
 * Context:  caller holds controller lock=0A=
 */=0A=
static void ep0_txstate(struct musb *pThis)=0A=
{=0A=
	void __iomem		*regs =3D pThis->control_ep->regs;=0A=
	struct usb_request	*pRequest =3D next_ep0_request(pThis);=0A=
	u16			wCsrVal =3D MGC_M_CSR0_TXPKTRDY;=0A=
	u8			*pFifoSource;=0A=
	u8			wFifoCount;=0A=
=0A=
	if (!pRequest) {=0A=
		// WARN_ON(1);=0A=
		DBG(2, "odd; csr0 %04x\n", musb_readw(regs, MGC_O_HDRC_CSR0));=0A=
		return;=0A=
	}=0A=
=0A=
	/* load the data */=0A=
	pFifoSource =3D (u8 *) pRequest->buf + pRequest->actual;=0A=
	wFifoCount =3D min((unsigned) MGC_END0_FIFOSIZE,=0A=
		pRequest->length - pRequest->actual);=0A=
	musb_write_fifo(&pThis->aLocalEnd[0], wFifoCount, pFifoSource);=0A=
	pRequest->actual +=3D wFifoCount;=0A=
=0A=
	/* update the flags */=0A=
	if (wFifoCount < MUSB_MAX_END0_PACKET=0A=
			|| pRequest->actual =3D=3D pRequest->length) {=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_STATUSOUT;=0A=
		wCsrVal |=3D MGC_M_CSR0_P_DATAEND;=0A=
	} else=0A=
		pRequest =3D NULL;=0A=
=0A=
	/* send it out, triggering a "txpktrdy cleared" irq */=0A=
=0A=
	/* report completions as soon as the fifo's loaded; there's no=0A=
	 * win in waiting till this last packet gets acked.  (other than=0A=
	 * very precise fault reporting, needed by USB TMC; possible with=0A=
	 * this hardware, but not usable from portable gadget drivers.)=0A=
	 */=0A=
	if (pRequest)=0A=
		musb_g_ep0_giveback(pThis, pRequest);=0A=
	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);=0A=
}=0A=
=0A=
/*=0A=
 * Read a SETUP packet (struct usb_ctrlrequest) from the hardware.=0A=
 * Fields are left in USB byte-order.=0A=
 *=0A=
 * Context:  caller holds controller lock.=0A=
 */=0A=
static void=0A=
musb_read_setup(struct musb *pThis, struct usb_ctrlrequest *req)=0A=
{=0A=
	struct usb_request	*r;=0A=
	void __iomem		*regs =3D pThis->control_ep->regs;=0A=
=0A=
	musb_read_fifo(&pThis->aLocalEnd[0], sizeof *req, (u8 *)req);=0A=
=0A=
	/* NOTE:  earlier 2.6 versions changed setup packets to host=0A=
	 * order, but now USB packets always stay in USB byte order.=0A=
	 */=0A=
	DBG(3, "SETUP req%02x.%02x v%04x i%04x l%d\n",=0A=
		req->bRequestType,=0A=
		req->bRequest,=0A=
		le16_to_cpu(req->wValue),=0A=
		le16_to_cpu(req->wIndex),=0A=
		le16_to_cpu(req->wLength));=0A=
=0A=
	/* clean up any leftover transfers */=0A=
	r =3D next_ep0_request(pThis);=0A=
	if (r)=0A=
		musb_g_ep0_giveback(pThis, r);=0A=
=0A=
	/* For zero-data requests we want to delay the STATUS stage to=0A=
	 * avoid SETUPEND errors.  If we read data (OUT), delay accepting=0A=
	 * packets until there's a buffer to store them in.=0A=
	 *=0A=
	 * If we write data, the controller acts happier if we enable=0A=
	 * the TX FIFO right away, and give the controller a moment=0A=
	 * to switch modes...=0A=
	 */=0A=
	pThis->bSetAddress =3D FALSE;=0A=
	pThis->ackpend =3D MGC_M_CSR0_P_SVDRXPKTRDY;=0A=
	if (req->wLength =3D=3D 0) {=0A=
		if (req->bRequestType & USB_DIR_IN)=0A=
			pThis->ackpend |=3D MGC_M_CSR0_TXPKTRDY;=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_ACKWAIT;=0A=
	} else if (req->bRequestType & USB_DIR_IN) {=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_TX;=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SVDRXPKTRDY);=0A=
		while ((musb_readw(regs, MGC_O_HDRC_CSR0)=0A=
				& MGC_M_CSR0_RXPKTRDY) !=3D 0)=0A=
			cpu_relax();=0A=
		pThis->ackpend =3D 0;=0A=
	} else=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_RX;=0A=
}=0A=
=0A=
static int=0A=
forward_to_driver(struct musb *musb,=0A=
		const struct usb_ctrlrequest *pControlRequest)=0A=
__releases(musb->Lock)=0A=
__acquires(musb->Lock)=0A=
{=0A=
	int retval;=0A=
	if (!musb->pGadgetDriver)=0A=
		return -EOPNOTSUPP;=0A=
	spin_unlock(&musb->Lock);=0A=
	retval =3D musb->pGadgetDriver->setup(&musb->g, pControlRequest);=0A=
	spin_lock(&musb->Lock);=0A=
	return retval;=0A=
}=0A=
=0A=
/*=0A=
 * Handle peripheral ep0 interrupt=0A=
 * @param pThis this=0A=
 *=0A=
 * Context: irq handler; we won't re-enter the driver that way.=0A=
 */=0A=
irqreturn_t musb_g_ep0_irq(struct musb *pThis)=0A=
{=0A=
	u16		wCsrVal;=0A=
	u16		wCount;=0A=
	void __iomem	*pBase =3D pThis->pRegs;=0A=
	void __iomem	*regs =3D pThis->aLocalEnd[0].regs;=0A=
	irqreturn_t	retval =3D IRQ_NONE;=0A=
=0A=
	MGC_SelectEnd(pBase, 0);	/* select ep0 */=0A=
	wCsrVal =3D musb_readw(regs, MGC_O_HDRC_CSR0);=0A=
	wCount =3D musb_readb(regs, MGC_O_HDRC_COUNT0);=0A=
=0A=
	DBG(4, "csr %04x, count %d, myaddr %d, ep0stage %s\n",=0A=
			wCsrVal, wCount,=0A=
			musb_readb(pBase, MGC_O_HDRC_FADDR),=0A=
			decode_ep0stage(pThis->ep0_state));=0A=
=0A=
	/* I sent a stall.. need to acknowledge it now.. */=0A=
	if (wCsrVal & MGC_M_CSR0_P_SENTSTALL) {=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0,=0A=
				wCsrVal & ~MGC_M_CSR0_P_SENTSTALL);=0A=
		retval =3D IRQ_HANDLED;=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		wCsrVal =3D musb_readw(regs, MGC_O_HDRC_CSR0);=0A=
	}=0A=
=0A=
	/* request ended "early" */=0A=
	if (wCsrVal & MGC_M_CSR0_P_SETUPEND) {=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SVDSETUPEND);=0A=
		retval =3D IRQ_HANDLED;=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		wCsrVal =3D musb_readw(regs, MGC_O_HDRC_CSR0);=0A=
		/* NOTE:  request may need completion */=0A=
	}=0A=
=0A=
	/* docs from Mentor only describe tx, rx, and idle/setup states.=0A=
	 * we need to handle nuances around status stages, and also the=0A=
	 * case where status and setup stages come back-to-back ...=0A=
	 */=0A=
	switch (pThis->ep0_state) {=0A=
=0A=
	case MGC_END0_STAGE_TX:=0A=
		/* irq on clearing txpktrdy */=0A=
		if ((wCsrVal & MGC_M_CSR0_TXPKTRDY) =3D=3D 0) {=0A=
			ep0_txstate(pThis);=0A=
			retval =3D IRQ_HANDLED;=0A=
		}=0A=
		break;=0A=
=0A=
	case MGC_END0_STAGE_RX:=0A=
		/* irq on set rxpktrdy */=0A=
		if (wCsrVal & MGC_M_CSR0_RXPKTRDY) {=0A=
			ep0_rxstate(pThis);=0A=
			retval =3D IRQ_HANDLED;=0A=
		}=0A=
		break;=0A=
=0A=
	case MGC_END0_STAGE_STATUSIN:=0A=
		/* end of sequence #2 (OUT/RX state) or #3 (no data) */=0A=
=0A=
		/* update address (if needed) only @ the end of the=0A=
		 * status phase per usb spec, which also guarantees=0A=
		 * we get 10 msec to receive this irq... until this=0A=
		 * is done we won't see the next packet.=0A=
		 */=0A=
		if (pThis->bSetAddress) {=0A=
			pThis->bSetAddress =3D FALSE;=0A=
			musb_writeb(pBase, MGC_O_HDRC_FADDR, pThis->bAddress);=0A=
		}=0A=
=0A=
		/* enter test mode if needed (exit by reset) */=0A=
		else if (pThis->bTestMode) {=0A=
			DBG(1, "entering TESTMODE\n");=0A=
=0A=
			if (MGC_M_TEST_PACKET =3D=3D pThis->bTestModeValue)=0A=
				musb_load_testpacket(pThis);=0A=
=0A=
			musb_writeb(pBase, MGC_O_HDRC_TESTMODE,=0A=
					pThis->bTestModeValue);=0A=
		}=0A=
		/* FALLTHROUGH */=0A=
=0A=
	case MGC_END0_STAGE_STATUSOUT:=0A=
		/* end of sequence #1: write to host (TX state) */=0A=
		{=0A=
			struct usb_request	*req;=0A=
=0A=
			req =3D next_ep0_request(pThis);=0A=
			if (req)=0A=
				musb_g_ep0_giveback(pThis, req);=0A=
		}=0A=
		retval =3D IRQ_HANDLED;=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		/* FALLTHROUGH */=0A=
=0A=
	case MGC_END0_STAGE_SETUP:=0A=
		if (wCsrVal & MGC_M_CSR0_RXPKTRDY) {=0A=
			struct usb_ctrlrequest	setup;=0A=
			int			handled =3D 0;=0A=
=0A=
			if (wCount !=3D 8) {=0A=
				ERR("SETUP packet len %d !=3D 8 ?\n", wCount);=0A=
				break;=0A=
			}=0A=
			musb_read_setup(pThis, &setup);=0A=
			retval =3D IRQ_HANDLED;=0A=
=0A=
			/* sometimes the RESET won't be reported */=0A=
			if (unlikely(pThis->g.speed =3D=3D USB_SPEED_UNKNOWN)) {=0A=
				u8	power;=0A=
=0A=
				printk(KERN_NOTICE "%s: peripheral reset "=0A=
						"irq lost!\n",=0A=
						musb_driver_name);=0A=
				power =3D musb_readb(pBase, MGC_O_HDRC_POWER);=0A=
				pThis->g.speed =3D (power & MGC_M_POWER_HSMODE)=0A=
					? USB_SPEED_HIGH : USB_SPEED_FULL;=0A=
=0A=
			}=0A=
=0A=
			switch (pThis->ep0_state) {=0A=
=0A=
			/* sequence #3 (no data stage), includes requests=0A=
			 * we can't forward (notably SET_ADDRESS and the=0A=
			 * device/endpoint feature set/clear operations)=0A=
			 * plus SET_CONFIGURATION and others we must=0A=
			 */=0A=
			case MGC_END0_STAGE_ACKWAIT:=0A=
				handled =3D service_zero_data_request(=0A=
						pThis, &setup);=0A=
=0A=
				/* status stage might be immediate */=0A=
				if (handled > 0) {=0A=
					pThis->ackpend |=3D MGC_M_CSR0_P_DATAEND;=0A=
					pThis->ep0_state =3D=0A=
						MGC_END0_STAGE_STATUSIN;=0A=
				}=0A=
				break;=0A=
=0A=
			/* sequence #1 (IN to host), includes GET_STATUS=0A=
			 * requests that we can't forward, GET_DESCRIPTOR=0A=
			 * and others that we must=0A=
			 */=0A=
			case MGC_END0_STAGE_TX:=0A=
				handled =3D service_in_request(pThis, &setup);=0A=
				if (handled > 0) {=0A=
					pThis->ackpend =3D MGC_M_CSR0_TXPKTRDY=0A=
						| MGC_M_CSR0_P_DATAEND;=0A=
					pThis->ep0_state =3D=0A=
						MGC_END0_STAGE_STATUSOUT;=0A=
				}=0A=
				break;=0A=
=0A=
			/* sequence #2 (OUT from host), always forward */=0A=
			default:		/* MGC_END0_STAGE_RX */=0A=
				break;=0A=
			}=0A=
=0A=
			DBG(3, "handled %d, csr %04x, ep0stage %s\n",=0A=
				handled, wCsrVal,=0A=
				decode_ep0stage(pThis->ep0_state));=0A=
=0A=
			/* unless we need to delegate this to the gadget=0A=
			 * driver, we know how to wrap this up:  csr0 has=0A=
			 * not yet been written.=0A=
			 */=0A=
			if (handled < 0)=0A=
				goto stall;=0A=
			else if (handled > 0)=0A=
				goto finish;=0A=
=0A=
			handled =3D forward_to_driver(pThis, &setup);=0A=
			if (handled < 0) {=0A=
				MGC_SelectEnd(pBase, 0);=0A=
stall:=0A=
				DBG(3, "stall (%d)\n", handled);=0A=
				pThis->ackpend |=3D MGC_M_CSR0_P_SENDSTALL;=0A=
				pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
finish:=0A=
				musb_writew(regs, MGC_O_HDRC_CSR0,=0A=
						pThis->ackpend);=0A=
				pThis->ackpend =3D 0;=0A=
			}=0A=
		}=0A=
		break;=0A=
=0A=
	case MGC_END0_STAGE_ACKWAIT:=0A=
		/* This should not happen. But happens with tusb6010 with=0A=
		 * g_file_storage and high speed. Do nothing.=0A=
		 */=0A=
		retval =3D IRQ_HANDLED;=0A=
		break;=0A=
=0A=
	default:=0A=
		/* "can't happen" */=0A=
		WARN_ON(1);=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SENDSTALL);=0A=
		pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		break;=0A=
	}=0A=
=0A=
	return retval;=0A=
}=0A=
=0A=
=0A=
static int=0A=
musb_g_ep0_enable(struct usb_ep *ep, const struct =
usb_endpoint_descriptor *desc)=0A=
{=0A=
	/* always enabled */=0A=
	return -EINVAL;=0A=
}=0A=
=0A=
static int musb_g_ep0_disable(struct usb_ep *e)=0A=
{=0A=
	/* always enabled */=0A=
	return -EINVAL;=0A=
}=0A=
=0A=
static void *musb_g_ep0_alloc_buffer(struct usb_ep *ep, unsigned =
bytes,=0A=
			dma_addr_t * dma, gfp_t gfp_flags)=0A=
{=0A=
	*dma =3D DMA_ADDR_INVALID;=0A=
	return kmalloc(bytes, gfp_flags);=0A=
}=0A=
=0A=
static void musb_g_ep0_free_buffer(struct usb_ep *ep, void *address,=0A=
			dma_addr_t dma, unsigned bytes)=0A=
{=0A=
	kfree(address);=0A=
}=0A=
=0A=
static int=0A=
musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t =
gfp_flags)=0A=
{=0A=
	struct musb_ep		*ep;=0A=
	struct musb_request	*req;=0A=
	struct musb		*musb;=0A=
	int			status;=0A=
	unsigned long		lockflags;=0A=
	void __iomem		*regs;=0A=
=0A=
	if (!e || !r)=0A=
		return -EINVAL;=0A=
=0A=
	ep =3D to_musb_ep(e);=0A=
	musb =3D ep->pThis;=0A=
	regs =3D musb->control_ep->regs;=0A=
=0A=
	req =3D to_musb_request(r);=0A=
	req->musb =3D musb;=0A=
	req->request.actual =3D 0;=0A=
	req->request.status =3D -EINPROGRESS;=0A=
	req->bTx =3D ep->is_in;=0A=
=0A=
	spin_lock_irqsave(&musb->Lock, lockflags);=0A=
=0A=
	if (!list_empty(&ep->req_list)) {=0A=
		status =3D -EBUSY;=0A=
		goto cleanup;=0A=
	}=0A=
=0A=
	switch (musb->ep0_state) {=0A=
	case MGC_END0_STAGE_RX:		/* control-OUT data */=0A=
	case MGC_END0_STAGE_TX:		/* control-IN data */=0A=
	case MGC_END0_STAGE_ACKWAIT:	/* zero-length data */=0A=
		status =3D 0;=0A=
		break;=0A=
	default:=0A=
		DBG(1, "ep0 request queued in state %d\n",=0A=
				musb->ep0_state);=0A=
		status =3D -EINVAL;=0A=
		goto cleanup;=0A=
	}=0A=
=0A=
	/* add request to the list */=0A=
	list_add_tail(&(req->request.list), &(ep->req_list));=0A=
=0A=
	DBG(3, "queue to %s (%s), length=3D%d\n",=0A=
			ep->name, ep->is_in ? "IN/TX" : "OUT/RX",=0A=
			req->request.length);=0A=
=0A=
	MGC_SelectEnd(musb->pRegs, 0);=0A=
=0A=
	/* sequence #1, IN ... start writing the data */=0A=
	if (musb->ep0_state =3D=3D MGC_END0_STAGE_TX)=0A=
		ep0_txstate(musb);=0A=
=0A=
	/* sequence #3, no-data ... issue IN status */=0A=
	else if (musb->ep0_state =3D=3D MGC_END0_STAGE_ACKWAIT) {=0A=
		if (req->request.length)=0A=
			status =3D -EINVAL;=0A=
		else {=0A=
			musb->ep0_state =3D MGC_END0_STAGE_STATUSIN;=0A=
			musb_writew(regs, MGC_O_HDRC_CSR0,=0A=
					musb->ackpend | MGC_M_CSR0_P_DATAEND);=0A=
			musb->ackpend =3D 0;=0A=
			musb_g_ep0_giveback(ep->pThis, r);=0A=
		}=0A=
=0A=
	/* else for sequence #2 (OUT), caller provides a buffer=0A=
	 * before the next packet arrives.  deferred responses=0A=
	 * (after SETUP is acked) are racey.=0A=
	 */=0A=
	} else if (musb->ackpend) {=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, musb->ackpend);=0A=
		musb->ackpend =3D 0;=0A=
	}=0A=
=0A=
cleanup:=0A=
	spin_unlock_irqrestore(&musb->Lock, lockflags);=0A=
	return status;=0A=
}=0A=
=0A=
static int=0A=
musb_g_ep0_dequeue(struct usb_ep *ep, struct usb_request *req)=0A=
{=0A=
	/* we just won't support this */=0A=
	return -EINVAL;=0A=
}=0A=
=0A=
static int musb_g_ep0_halt(struct usb_ep *e, int value)=0A=
{=0A=
	struct musb_ep		*ep;=0A=
	struct musb		*musb;=0A=
	void __iomem		*base, *regs;=0A=
	unsigned long		flags;=0A=
	int			status;=0A=
	u16			csr;=0A=
=0A=
	if (!e || !value)=0A=
		return -EINVAL;=0A=
=0A=
	ep =3D to_musb_ep(e);=0A=
	musb =3D ep->pThis;=0A=
	base =3D musb->pRegs;=0A=
	regs =3D musb->control_ep->regs;=0A=
=0A=
	spin_lock_irqsave(&musb->Lock, flags);=0A=
=0A=
	if (!list_empty(&ep->req_list)) {=0A=
		status =3D -EBUSY;=0A=
		goto cleanup;=0A=
	}=0A=
=0A=
	switch (musb->ep0_state) {=0A=
	case MGC_END0_STAGE_TX:		/* control-IN data */=0A=
	case MGC_END0_STAGE_ACKWAIT:	/* STALL for zero-length data */=0A=
	case MGC_END0_STAGE_RX:		/* control-OUT data */=0A=
	case MGC_END0_STAGE_STATUSIN:		/* control-OUT status */=0A=
	case MGC_END0_STAGE_STATUSOUT:		/* control-IN status */=0A=
		status =3D 0;=0A=
=0A=
		MGC_SelectEnd(base, 0);=0A=
		csr =3D musb_readw(regs, MGC_O_HDRC_CSR0);=0A=
		csr |=3D MGC_M_CSR0_P_SENDSTALL;=0A=
		musb_writew(regs, MGC_O_HDRC_CSR0, csr);=0A=
		musb->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
		break;=0A=
	default:=0A=
		DBG(1, "ep0 can't halt in state %d\n", musb->ep0_state);=0A=
		status =3D -EINVAL;=0A=
	}=0A=
=0A=
cleanup:=0A=
	spin_unlock_irqrestore(&musb->Lock, flags);=0A=
	return status;=0A=
}=0A=
=0A=
const struct usb_ep_ops musb_g_ep0_ops =3D {=0A=
	.enable		=3D musb_g_ep0_enable,=0A=
	.disable	=3D musb_g_ep0_disable,=0A=
	.alloc_request	=3D musb_alloc_request,=0A=
	.free_request	=3D musb_free_request,=0A=
	.alloc_buffer	=3D musb_g_ep0_alloc_buffer,=0A=
	.free_buffer	=3D musb_g_ep0_free_buffer,=0A=
	.queue		=3D musb_g_ep0_queue,=0A=
	.dequeue	=3D musb_g_ep0_dequeue,=0A=
	.set_halt	=3D musb_g_ep0_halt,=0A=
	.fifo_status	=3D NULL,=0A=
	.fifo_flush	=3D NULL,=0A=
};=0A=

------_=_NextPart_000_01C79264.D7BC5F60
Content-Type: application/octet-stream;
	name="PATCH"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="PATCH"

199d198=0A=
< 	pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
459d457=0A=
< 	musb_writew(regs, MGC_O_HDRC_CSR0, tmp);=0A=
467a466=0A=
> 	musb_writew(regs, MGC_O_HDRC_CSR0, tmp);=0A=
506d504=0A=
< 	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);=0A=
514a513=0A=
> 	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);=0A=
939a939,940=0A=
> 	case MGC_END0_STAGE_STATUSIN:		/* control-OUT status */=0A=
> 	case MGC_END0_STAGE_STATUSOUT:		/* control-IN status */=0A=

------_=_NextPart_000_01C79264.D7BC5F60
Content-Type: application/octet-stream;
	name="README"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="README"

DIFF was obtained by running diff g_ep0-2_6_20.c g_ep0.c > PATCH=0A=
=0A=
In a USB control transfer, there are 3 stages: the setup, data, and =
status=0A=
stages. The callback function may be called after the data stage of a =
USB=0A=
control transfer, so the state machine cannot go back to the "setup" =
stage=0A=
after the callback is executed.=0A=
199d198=0A=
< 	pThis->ep0_state =3D MGC_END0_STAGE_SETUP;=0A=
=0A=
The code cannot signal the completion of the data stage to the USB =
peripheral=0A=
until after the callback function determines whether to stall the =
endpoint.=0A=
This is consistent with the comment in this area of code.=0A=
459d457=0A=
< 	musb_writew(regs, MGC_O_HDRC_CSR0, tmp);=0A=
467a466=0A=
> 	musb_writew(regs, MGC_O_HDRC_CSR0, tmp);=0A=
=0A=
The code cannot signal the completion of the data stage to the USB =
peripheral=0A=
until after the callback function determines whether to stall the =
endpoint.=0A=
506d504=0A=
< 	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);=0A=
514a513=0A=
> 	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);=0A=
=0A=
According to section 8.5.3 of version 2.0 of the USB spec, a stall may =
occur in=0A=
either the data or status stages of the control transfer.=0A=
939a939,940=0A=
> 	case MGC_END0_STAGE_STATUSIN:		/* control-OUT status */=0A=
> 	case MGC_END0_STAGE_STATUSOUT:		/* control-IN status */=0A=

------_=_NextPart_000_01C79264.D7BC5F60
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_000_01C79264.D7BC5F60--
