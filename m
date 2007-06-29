From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: how to write/read HDQ bus device
Date: Thu, 28 Jun 2007 21:52:04 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47013BF445@dlee13.ent.ti.com>
References: <OFE76AA642.970231BB-ON48257309.000C9B24-48257309.000E0BEF@accton.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <OFE76AA642.970231BB-ON48257309.000C9B24-48257309.000E0BEF@accton.com.tw>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: jeffrey_chuang@accton.com.tw, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>I am using 2.6.14 kernel , I found HDQ interface @ following path
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
># cd /sys/devices/platform/omap_hdq.0/bus/devices/omap_hdq.0
># ls
>bus     cmd     power   result
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>i can open it as below message ,
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
># echo open > cmd
>OMAP_HDQ:sysfs cmd: *open*, len=3D4, count=3D5
>OMAP_HDQ:process open cmd ...
>OMAP_HDQ:exiting cmd_set, 0
>#
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>but I do not how to write 0x55 to DHQ device(bq27000) register address
>0x00~0x7F
>or read data from it.
>
>any body can help me ? thank you

First question which board are you using? SDP2430 version ?

Setup to read/write from bq27000: The battery pack must be plugged into =
SDP. 2430SDP2.0 and later has HDQ pin disconnected, this pin should be =
connected on your board.

Sample test:
=20
# echo "open" > /sys/devices/platform/omap_hdq.0/cmd
# echo "read 01" > /sys/devices/platform/omap_hdq.0/cmd
# cat /sys/devices/platform/omap_hdq.0/result
# echo "write 01 ab" > /sys/devices/platform/omap_hdq.0/cmd
# echo "read 01" > /sys/devices/platform/omap_hdq.0/cmd
# cat /sys/devices/platform/omap_hdq.0/result

The first cat command returns the old value of register 0x01. The second =
cat should return the new value 0xab.

Regards
Khasim
