From: "Girish" <girishsg@ti.com>
Subject: [RFC] [PATCH 0/2] High Speed uart support on 3430
Date: Mon, 17 Dec 2007 19:49:12 +0530
Message-ID: <02a301c840b7$ccdcbbb0$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
This patch series adds high speed uart support on 3430.=20

UART library Interfaces:
The UART library interfaces the user drivers with UART hardware and =
exports API=92s to configure UART for different types of
applications such as High speed(HS) UART, IrDA and Bluetooth etc.=20
The most of the API=92s exported by UART library are functionality based =
API=92s which are used by client drivers for different purposes
such as=20
-	Requesting UART
-	Initial UART configuration
-	Data transfer Configuration(DMA mode)
-	ISR registration
-	UART Speed change


Regards,
Girish
