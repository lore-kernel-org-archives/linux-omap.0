From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Putting Uboot back into H4 board
Date: Tue, 20 Dec 2005 07:16:25 -0800 (PST)
Message-ID: <20051220151625.94035.qmail@web32902.mail.mud.yahoo.com>
References: <000201c60571$9e3b7d60$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <000201c60571$9e3b7d60$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Richard Copeman <richard.copeman@lauterbach.co.uk> wrote:

> Hi,
> 
>  
> 
> I have an H4 board (OMAP-2420)  with a broken Uboot. Can somebody
> point me
> at a set of instructions or a utility to replace it please?

Hope you have got H4 Menelaus board. You can download h4 u-boot source
from http://linux.omap.com and use OST tools, it is available from the
ti site:

--------
Flashing Uboot (Menelaus Board)

Procedure for flashing u-boot using OST tools

1. Make the following switch settings

Menelaus SDR based board:

Processor Daughter card:

SW4: OFF, OFF, ON, ON 
SW1: ON, OFF, ON, OFF(OFF, OFF, ON, ON for booting)
SW2: OFF, OFF, ON, ON(All ON for booting)
SW3: OFF, ON, ON, ON

Main H4 board:

S1: All ON except 1,2,9,10
S2: ON, OFF, OFF, ON


2. Connect the Serial cable to UART J400 socket (near to power supply)
of H4 board and serial port of PC. NOTE: 1. Make sure that there is no
other program running on PC monitoring the serial port.

     2. DO NOT switch on the board just follow the instructions

3. Launch OSTtools tools Click on Settings->Configuration... menu to
launch Configuration Dialog box In Configuration Dialog box

- Click on 'Restore Default Addresses' button
- Select '2420 Menelaus SDR' as platform 
- Select 'UART' as interface
- Select 'FlashWriterNOR.out' file name as Flash loader 
- select 'OST_Load.2nd' as Downloaded SW
- Click on 'OK' to close the dialog box

On main GUI window

- Select 'Image downloading and Flashing' as mode of operation 
- Select 'h4_u-boot.raw' as input file name
- Click on 'Download To Target' button 
 You should see following message
 'Waiting for Target to Send ASIC ID' 


4. SWITCH ON the board. OST tools will download/flash the u-boot raw
binary on to the board. OST tools will display the downloading/Flashing
progress. The whole process will take less than 18 sec. Once the
flashing is completed, close the OST tool and switch OFF the board

5. Make following changes and switch ON the board

SW1: OFF, OFF, ON, ON
SW2: All ON 

NOTE: To get u-boot o/p you need to connect the serial cable to debug
board 

-----snip-------------------------

Hope it helps !!!

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
