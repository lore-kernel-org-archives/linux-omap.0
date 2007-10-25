From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP3 & PRCM register ??
Date: Thu, 25 Oct 2007 14:38:06 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290253052A@dlee13.ent.ti.com>
References: <31e679430710251056p467b7161tccf52693745ba0eb@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290253046F@dlee13.ent.ti.com>
	<31e679430710251124w70f370c5of30b209eacbf8753@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429025304BF@dlee13.ent.ti.com>
	<31e679430710251154p4f87f124h181ffc6a2a8c8dc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <31e679430710251154p4f87f124h181ffc6a2a8c8dc1@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> thanks for your prompt reply, richard... and only one more question.
> Who's dealing the usb otg transceiver logic in omap 3430sdp ?? I
> wonder tusb6010 has been left aside in this board, is that right ? Is
> there any code for such transceiver publicly available yet?

I think Nishanth got this.  I'll elaborate a bit more.

The IP block which the external tusb6010 chip uses is integrated inside =
of the omap34xx (and 243x).  No need for an external chip to get HS-USB. =
 Probably the main driver difference is DMA usage and transceiver setup =
I suppose.

On current SDPs this internal HS-USB block is talking to the companion =
IO chip (T2) which among other things has a USB transceiver.

TI 2430 and 3430 images have necessary code to make all this work for =
OTG.  There likely is some work in merging it back into the latest =
omap-git.

Regards,
Richard W.
