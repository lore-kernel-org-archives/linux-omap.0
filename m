From: "balaji  narayanam" <narayanamb@rediffmail.com>
Subject: Regarding the OMAP Camera patch
Date: 18 Aug 2007 12:23:06 -0000
Message-ID: <20070818122306.21563.qmail@f5mail-237-201.rediffmail.com>
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

  =0ADear Mr.Trilok Soni,=0A=0AI had seeen the [PATCH 1/2] ov9640: Add Omni=
Vision ov9640 driver - new=0Ainterface. I am trying to interface the OV7620=
 cmos Image sensor to the Expansion connector C pins of the OMAP5912 OSK.=
=0A=0AFOR THAT WE DESIGNED A SIMPLE PCB to connect the Expansion Connector =
C of OSK5912 TO OV720 SENSOR.=0A=0AWhile Building the Linux kernel image in=
 the make menuconfig I had chosen the OVCAMCHIP as module in Linux/drivers/=
media/video/ovcamchip"=0Awhich contain the ov7620 kernel space driver modul=
e. =0ABut I am not gettinmg any response from the sensor.=0A=0A In the make=
 menuconfig under =0A Device Drivers --->=0A   Multimedia devices --->=0A  =
  Video For Linux ---->=0A    ---Video Adapters=0A            < > OMAP Came=
ra support (EXPERIMENTAL) =0A                      < >OV9640 sensor support=
 (NEW)=0A I could find only the OV9640 sensor support.=0A I searched for th=
e OV7620 sensor patch under the OMAP Camera support.=0A But no where I coul=
d find the OV7620sensor support patch for OMAP5912  =0A OSK.=0A I am trying=
 to build a patch for the OV7620 sensor support for OMAP  =0A Camera.=0A=0A=
 1) I would like to know whether I am proceeding in the correct way=0A     =
for the Interfacing of the sensor with OSK?=0A  2) IF not what is the corre=
ct procedure.=0A=0A Thanks In advance=0AWith Warm regards=0ABalaji.N =0A
