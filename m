From: =?gb2312?B?TmluZ3pob25nIE1pYW8gLSDD58T+1tI=?= <Ningzhong.Miao@palmsource.com>
Subject: Re: How to upload u-boot to H3 with serial port ?
Date: Mon, 4 Sep 2006 20:03:30 +0800
Message-ID: <122E40D9F186B44FBA6A032362C5FB65564767@mtnex1.mtn.palmsource.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: "Ningzhong.Miao" <Ningzhong.Miao@palmsource.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I set "HS" in Devices option, and then it succeed.
I have loaded u-boot to H3 through TS232 UART successfully. Thank you =
all!

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: =
linux-omap-open-source-bounces+ningzhong.miao=3Dpalmsource.com@linux.omap=
.com =
[mailto:linux-omap-open-source-bounces+ningzhong.miao=3Dpalmsource.com@li=
nux.omap.com] =B4=FA=B1=ED Ningzhong Miao - =C3=E7=C4=FE=D6=D2
=B7=A2=CB=CD=CA=B1=BC=E4: 2006=C4=EA9=D4=C24=C8=D5 17:42
=CA=D5=BC=FE=C8=CB: linux-omap-open-source@linux.omap.com
=D6=F7=CC=E2: Re: How to upload u-boot to H3 with serial port ?

Hi,guys, I make some progress.
I changed switch setting to:
       SW101-1 OFF
       SW101-2 ON
       SW101-3 ON
       SW101-4 OFF

       SW401-1 OFF
       SW401-2 OFF
       SW401-3 ON
       SW401-4 ON
 I connect USB OTG to my PC and power up H3, then installed OMAP1710 =
driver.

Now I download to target through USB with OST, the message box show:

17:12.41 PM  Error, A Problem occurred while sending the Vars section
17:12.41 PM  Downloading Variables
17:12.41 PM  Downloaded SW Sent to Target, Target should Acknowledge
17:12.41 PM  Error, Downloaded SW Failed to Acknowledge Host
17:12.23 PM  Downloaded SW Sent to Target, Target should Acknowledge
17:12.23 PM  =
0501050117100708130201011215014d0f637aa41b6cdb54e0885cbd6e823e2123a2aa141=
501195f111a9543a8644e77e1677296ab23000000001509011dfd66132c872fd4
17:12.23 PM  Got ASIC ID, dumping in Hex...
17:12.23 PM  Loading Secondary Boot Code
17:12.18 PM  Waiting for USB device to connect
17:12.18 PM  Waiting for USB connection
17:12.18 PM  Already signed Downloaded SW
17:12.18 PM  Reading Input Image
17:11.57 PM  New Image File Selected
17:11.27 PM  New Image File Selected
17:11.27 PM  OMAP Software Tools Version 2.5

A Problem occurred, what should I do ?

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: Ningzhong Miao - =C3=E7=C4=FE=D6=D2=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2006=C4=EA9=D4=C24=C8=D5 14:47
=CA=D5=BC=FE=C8=CB: 'Nishanth Menon'; Kipisz, Steven; =
linux-omap-open-source@linux.omap.com
=D6=F7=CC=E2: =B4=F0=B8=B4: How to upload u-boot to H3 with serial port =
?

Hi,Nishanth, thank you for your letter.
I have the OST tool. But there are some problems on using OST.
Below is the steps:
1, I set the switches according "omap_1710v1.4.txt"
    - Main Board

       SW101-1 ON
       SW101-2 ON
       SW101-3 ON
       SW101-4 OFF

       SW401-1 ON
       SW401-2 OFF
       SW401-3 ON
       SW401-4 ON

       - Multiport debug board

       SW2-1 OFF
       SW2-2 OFF
       SW2-3 OFF
       SW2-4 OFF

       SW3-1 ON
       SW3-2 ON
       SW3-3 ON
       SW3-4 ON
       SW3-5 ON
       SW3-6 ON
       SW3-7 OFF
       SW3-8 OFF
2, run OST tool V2.5.
  Set "16xx_17xx DDR" in Platform.
  Set "COM1" in Interface
  Set "NOR" in Flash Type
  Set "GP" in Device.
  Flash Firmware is OST_Flash_16xx.out.
  Downloaded SW is OST_Load_GP_16xx.2nd.
  Input File is u-boot.bin.raw
 Click the button "Download To target", and the message box show "Mon, =
September 04, 2006:  14:04.19 PM  Waiting for Target to send ASIC ID".

3, connect TS232 UART to my PC, Power up H3,
  OST Tool didn't have any reaction!!!

If I connect USB to my PC, and set "USB" in Interfaces, OST show " =
Waiting for USB device to connect" and no other reaction.

Is there some wrong in my steps ? Please help me to check it, thank you.


-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: Nishanth Menon [mailto:menon.nishanth@gmail.com]=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2006=C4=EA9=D4=C21=C8=D5 11:13
=CA=D5=BC=FE=C8=CB: Kipisz, Steven
=B3=AD=CB=CD: Amit Verma; Ningzhong Miao - =C3=E7=C4=FE=D6=D2; =
linux-omap-open-source@linux.omap.com
=D6=F7=CC=E2: Re: How to upload u-boot to H3 with serial port ?

Greeting Miao/Amit
>> I want upload u-boot to H3, but I don't have JTAG and CCS, I only =
have
>> serial port.

CCS,Lauterbach, USB.. And.... There is supposedly a "poor man's"
approach... ;)
There is OST host(some name to that effect) tool which should be usable
over serial port... if you are lucky enough to get the box in which the
h3 came with, then it hides innocently in a CD in it...

http://linux.omap.com/pub/documentation/P2_NAND_boot_support.txt

can help you started though it is for P2.. but note that this was
written sometime back... things have changed since then, but most
probably not about OST host - if u can flash u-boot to flash.. Ur good
to GO :)!!

If you cant find OST host... u could contact your TI contact person for =
it..

Regards,
Nishanth Menon
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
