From: Ravi KK <ravikk@huawei.com>
Subject: How to upload u-boot to H3 with serial port ?
Date: Thu, 05 Oct 2006 11:28:58 +0530
Message-ID: <003701c6e843$59ed88f0$4414120a@china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
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

Hi

How to load u-boot on OMAP 1710 board?

Following steps are followed to load u-boot.bin.raw file to board.

1. Connected UART on main board to PC serial port (using Rs232 with DB9
connector). (also tried between debug board UART and PC serial interface,
but end up with same status)

2. Set the switches according "omap_1710v1.4.txt" 

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

3. Run OST tool V2.5.

  Set "16xx_17xx DDR" in Platform.

  Set "COM1" in Interface

  Set "NOR" in Flash Type

  Set "HS" in Device.

  Flash Firmware is OST_Flash_16xx.out.

  Downloaded SW is OST_Load_GP_16xx.2nd.

  Input File is u-boot.bin.raw

 Click the button "Download To target", and the message box show  'Waiting
for Target to send ASIC ID'

4. Power up H3,

OST Tool status shows ''Waiting for Target to send ASIC ID' no change
further!!!!

------------------->

Based on above switch settings USB OTG is connected to PC USB.

Followed above step 3 and set 'interface' in OST tool to 'USB' and step 4.
But the status is 'Waiting for USB device to connect" and no other reaction.


During this step, when power up the board PC identifies the board as unknown
device. I tried to install USB driver provided by TI, but is not getting
installed as windows says current installed  driver is newer than the new
one. 

How to get the board identified as a normal USB to PC host? Any other is
available?

 

Looking for support.

 

Regards

Ravi KK

 
