From: Nagaraj <raj-0555@hotmail.com>
Subject: Regarding ost_host... omap 1710 sdp
Date: Fri, 4 May 2007 14:15:19 +0530
Message-ID: <BAY119-W13028383025D2C3B1A85B89E400@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi all,
=20
I am using omap 1710 software development platform (SDP1710 v2.1.1).
my aim is to download uboot.
There are few problems encounted. please help in this issues.
1. Setting the switchs as said in the "ost_tool_reference_guide.pdf".
SW101 (Boot Mode)
SW101 (1-4) - OFF, ON, ON, OFF (CS0 Mode)
SW101 (1-4) - ON, ON, ON, OFF (CS3 Mode)
SW401 (DB9/irda)
SW401 (1-4) - OFF, OFF, ON, ON
SW1501 (USB dev or otg)
SW1501 (1-3) - ON, ON, OFF (USB Dev)
SW1501 (1-3) - OFF, OFF, ON (USB OTG)
i connected one end of the usb cable to pc and other end to usb dev on the =
board. my pc is showing unknown device detected. when i am updating the dri=
vers pc is unable to load the drivers for the usb dev.
By changing the switch setting to (usb otg ) if connect one end of the usb =
cable to pc and other end to usb otg . my pc not at all dectecting the usb.
=20
2. i compiled uboot image for omap1710. after that i rename the file u-boot=
.bin.raw.
The Image file, is selected by File and Image Option in the menu in Ost_Hos=
t

Board settings:
# SW101 OFF ON ON OFF=20
# SW1501 1-OFF, 2-OFF, 3-ON, 4-OFF, 5-OFF, 6-OFF, 7-OFF, 8-OFF
Switch ON H3
i used following setting in ost_host=20
=20
Flashing u-boot:=20
1. Settings->Configuration->Platform->16xx_17xx DDR
2. Settings->Configuration->Interface->com1=20
3. Settings->Configuration->Flash Type->NOR=20
4. Settings->Configuration->Device->HS or EMU=20
5. Select "Image Download and flashing" on the Main Window=20
6. Click "Download To Target"=20
error showing=20
"Unable to open the file Not Set"
"Error in Flash Firmware file name" .
please give me help in thes issues..
Thanks & Regards,
Nagaraju.P
_________________________________________________________________
Sign in and get updated with all the action!
http://content.msn.co.in/Sports/FormulaOne/Default=
