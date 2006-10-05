From: Prashant <prashantkhoje@gmail.com>
Subject: Re:How to upload u-boot to H3 with serial port ?
Date: Thu, 5 Oct 2006 20:02:00 +0530
Message-ID: <7b1b9c8b0610050732pfb70762q36f8d83658c9519b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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
