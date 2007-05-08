From: Nagaraj <raj-0555@hotmail.com>
Subject: RE: Regarding ost_host... omap 1710 sdp
Date: Tue, 8 May 2007 16:15:22 +0530
Message-ID: <BAY113-W7E8D9774342EE054637019E440@phx.gbl>
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

first i want to say thanks for giving suggestion. I make some progress. i i=
nstalled the usb driver for the omap 1710. Now when I download u-boot.bin.r=
aw to target through USB with OST, the message box show: the log messages a=
re:  Reading Input ImageAlready signed Downloaded SWWaiting for USB connect=
ionWaiting for USB device to connectLoading Secondary Boot CodeGot ASIC ID,=
 dumping in Hex...050105011710070813020100121501000000000000000000000000000=
000000000000014150100000000000000000000000000000000000000001509011dfd661300=
000000Downloaded SW Sent to Target, Target should AcknowledgeError, Downloa=
ded SW Failed to Acknowledge HostDownloaded SW Sent to Target, Target shoul=
d AcknowledgeDownloading VariablesError, A Problem occurred while sending t=
he Vars section  what should I do ?please help me in this issues... Rgds,Na=
garaju.P


From: raj-0555@hotmail.comTo: linux-omap-open-source@linux.omap.comSubject:=
 Regarding ost_host... omap 1710 sdpDate: Fri, 4 May 2007 14:15:19 +0530


Hi all, I am using omap 1710 software development platform (SDP1710 v2.1.1)=
.my aim is to download uboot.There are few problems encounted. please help =
in this issues.1. Setting the switchs as said in the "ost_tool_reference_gu=
ide.pdf".SW101 (Boot Mode)SW101 (1-4) - OFF, ON, ON, OFF (CS0 Mode)SW101 (1=
-4) - ON, ON, ON, OFF (CS3 Mode)SW401 (DB9/irda)SW401 (1-4) - OFF, OFF, ON,=
 ONSW1501 (USB dev or otg)SW1501 (1-3) - ON, ON, OFF (USB Dev)SW1501 (1-3) =
- OFF, OFF, ON (USB OTG)i connected one end of the usb cable to pc and othe=
r end to usb dev on the board. my pc is showing unknown device detected. wh=
en i am updating the drivers pc is unable to load the drivers for the usb d=
ev.By changing the switch setting to (usb otg ) if connect one end of the u=
sb cable to pc and other end to usb otg . my pc not at all dectecting the u=
sb. 2. i compiled uboot image for omap1710. after that i rename the file u-=
boot.bin.raw.The Image file, is selected by File and Image Option in the me=
nu in Ost_HostBoard settings:# SW101 OFF ON ON OFF # SW1501 1-OFF, 2-OFF, 3=
-ON, 4-OFF, 5-OFF, 6-OFF, 7-OFF, 8-OFFSwitch ON H3i used following setting =
in ost_host  Flashing u-boot: 1. Settings->Configuration->Platform->16xx_17=
xx DDR2. Settings->Configuration->Interface->com1 3. Settings->Configuratio=
n->Flash Type->NOR 4. Settings->Configuration->Device->HS or EMU 5. Select =
"Image Download and flashing" on the Main Window 6. Click "Download To Targ=
et" error showing "Unable to open the file Not Set""Error in Flash Firmware=
 file name" .please give me help in thes issues..Thanks & Regards,Nagaraju.=
P

Sign in and get updated with all the action! Formula One=20
_________________________________________________________________
The idiot box is no longer passe!
http://content.msn.co.in/Entertainment/TV/Default.aspx=
