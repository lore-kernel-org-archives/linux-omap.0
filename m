From: "Mitchell, Danny" <dmitchell@ti.com>
Subject: Latest 2.6.14 source for 2430 Uploaded to linux.omap.com
Date: Thu, 27 Sep 2007 14:30:07 -0500
Message-ID: <BF1161CB0828C54FB897AAC235D2A4860208CA28@dlee11.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Khasim

=20

I was looking at this version of OMAP2430 linux and it stated that
support for USB isochronous transfers had been added.  I'm trying to
verify if the functionality in the TRM has been tested, possibly by this
drop.

=20

25.11.6 High Bandwidth Isochronous Endpoints

=20

In high-speed mode, isochronous endpoints can transfer up to three USB
packets in any microframe with

a payload of up to 1024 bytes in each packet, corresponding to a data
transfer rate of up to 3072 bytes

per microframe (see USB Specification Revision 2.0).

For TX endpoints, the high-speed USB controller supports this by
allowing loading data packets of up to

3072 bytes (that is, 3 x 1024 bytes) into the associated endpoint FIFO,
which is then automatically split

into USB packets of the maximum payload, or smaller to be transmitted in
one microframe.

For RX endpoints, the module automatically combines all the USB packets
received during a microframe

into a single packet of up to 3072 bytes (that is, 3 x 1024 bytes)
within the Rx FIFO.

The number of USB packets transferred per microframe and the maximum
payload in each packet is

defined through the appropriate registers (RXMAXP, TXMAXP, see Mentor
Graphics specifications).

=20

=20

=20

Best Regards,

Danny Mitchell

PAV Applications

=20
