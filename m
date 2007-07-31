From: "balaji  narayanam" <narayanamb@rediffmail.com>
Subject: Regarding the I2C error
Date: 31 Jul 2007 14:26:29 -0000
Message-ID: <20070731142629.30975.qmail@f5mail11.rediffmail.com>
Reply-To: balaji narayanam <narayanamb@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

  =0AHi,=0A=0AI am trying to interface the OV7620 cmos Image sensor to the =
Expansion connector C pins of the OMAP5912 OSK.=0A=0AFOR THAT WE DESIGNED A=
 SIMPLE PCB to connect the Expansion Connector C of OSK5912 TO OV720 SENSOR=
.=0A=0AWhile Building the Linux kernel image in the make menuconfig I had c=
hosen the OVCAMCHIP as module in Linux/drivers/media/video/ovcamchip"=0Awhi=
ch contain the ov7620 kernel space driver module.=0AEven I selected the I2C=
 in the menu configuration.=0AI verified that the camera  is receiving the =
necessary voltages.=0A=0ABut in the U-boot log we are not getting any OV762=
0 chip detected message. I am not getting any response at the i2c node in /=
dev/i2c-0 of OSK5912. =0Awhen I give  # cat /dev/i2c-0=0AI am getting the f=
ollowing error=0A=0Ai2c_omap i2c_omap.1: timeout waiting for bus ready=0Aca=
t: Read error: Connection timed out.=0A=0APlease clarify=0A=0ABalaji.N=0A=
=0A=0A
