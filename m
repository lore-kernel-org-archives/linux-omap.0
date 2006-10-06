From: Ravi KK <ravikk@huawei.com>
Subject: RE: How to upload u-boot to H3 with serial port ?
Date: Fri, 06 Oct 2006 13:33:34 +0530
Message-ID: <000901c6e91d$ec516b00$4414120a@china.huawei.com>
References: <7b1b9c8b0610050732pfb70762q36f8d83658c9519b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <7b1b9c8b0610050732pfb70762q36f8d83658c9519b@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Prashant' <prashantkhoje@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks prashant.
I tried with the steps but some problem. I am sending log details @ OST tool
I tried with uboot.out and uboot.bin.raw files 

Option1: uboot.out  & "Image Download and Run from RAM"
----> Log details @ ost tool <------
11:12.40 AM  Error, A Problem occurred while downloading
11:12.40 AM  Loading the section ".intvecs" (size 12 bytes) at 0x11ff0010 
11:12.40 AM  Downloading Coff Image file...
11:12.40 AM  Error, Downloaded SW Failed to Acknowledge Host
11:12.40 AM  Downloaded SW Sent to Target, Target should Acknowledge
11:12.40 AM  Loading Secondary Boot Code
11:12.30 AM  Waiting for USB device to connect
11:12.30 AM  Waiting for USB connection
11:12.30 AM  Already signed Downloaded SW
------------------------------------

Option2:  uboot.out  & "Image Download and flashing"
----> Log details @ ost tool <------
11:13.40 AM  Error, A Problem occurred while sending the Vars section
11:13.39 AM  Downloading Variables
11:13.39 AM  Downloaded SW Sent to Target, Target should Acknowledge
11:13.39 AM  Error, Downloaded SW Failed to Acknowledge Host
11:13.39 AM  Downloaded SW Sent to Target, Target should Acknowledge
11:13.39 AM  Loading Secondary Boot Code
11:13.34 AM  Waiting for USB device to connect
11:13.34 AM  Waiting for USB connection
11:13.34 AM  Already signed Downloaded SW
11:13.34 AM  Reading Input Image
------------------------------------
Option3:  uboot.bin.raw  & "Image Download and Run from RAM"
----> Log details @ ost tool <------
11:09.14 AM  Error, A Problem occurred while sending the Image
11:09.14 AM  Downloading Image Data...
11:09.14 AM  Error, Downloaded SW Failed to Acknowledge Host
11:09.14 AM  Downloaded SW Sent to Target, Target should Acknowledge
11:09.14 AM  Loading Secondary Boot Code
11:09.08 AM  Waiting for USB device to connect
11:09.08 AM  Waiting for USB connection
11:09.08 AM  Already signed Downloaded SW
11:09.08 AM  Reading Input Image
11:09.05 AM  New Image File Selected
------------------------------------

Option4:  uboot.bin.raw  & "Image Download and flashing"
----> Log details @ ost tool <------
11:11.45 AM  Error, A Problem occurred while sending the Vars section
11:11.45 AM  Downloading Variables
11:11.45 AM  Downloaded SW Sent to Target, Target should Acknowledge
11:11.45 AM  Error, Downloaded SW Failed to Acknowledge Host
11:11.45 AM  Downloaded SW Sent to Target, Target should Acknowledge
11:11.45 AM  Loading Secondary Boot Code
11:11.37 AM  Waiting for USB device to connect
11:11.37 AM  Waiting for USB connection
11:11.37 AM  Already signed Downloaded SW
11:11.37 AM  Reading Input Image
------------------------------------
What can be the problem?

Regards
Ravi KK







-----Original Message-----
From: linux-omap-open-source-bounces+ravikk=huawei.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+ravikk=huawei.com@linux.omap.com] On
Behalf Of Prashant
Sent: Thursday, October 05, 2006 8:02 PM
To: linux-omap-open-source@linux.omap.com
Subject: Re:How to upload u-boot to H3 with serial port ?

With these steps you can flash u-boot using USB OTG on H3.

Try the following Settings -

Switch settings to Flash (Uart Cable on debug board)

# SW101   OFF ON ON OFF
# SW1501 1-OFF, 2-OFF, 3-ON,  4-OFF, 5-OFF, 6-OFF, 7-OFF, 8-OFF
Switch ON H3.
With these setting windows should detect H3 h/w as 'OMAP1710'. Install
the driver for H3.


Flashing u-boot:
1. Settings->Configuration->Platform->16xx_17xx DDR
2. Settings->Configuration->Interface->USB
3. Settings->Configuration->Flash Type->NOR
4. Settings->Configuration->Device->HS or EMU



5. Select "Image Download and Run from RAM" on the Main Window
6. Click "Download To Target"
7. When the message box shows  'Waiting for Target to send ASIC ID';
Reset the board by switching it off and on, Uboot Image will
downloaded automatically.

You may need to change the setting "Image Download and flashing" or
"Image Download and Run from RAM" depends on your Uboot.


To boot now change switch settings to
# SW101   ON ON ON OFF
# TeraTerm at 115200 (Uart Cable on debug board).


Regards,
Prashant K
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
