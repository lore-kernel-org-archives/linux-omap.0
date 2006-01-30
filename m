From: Madhu Punjabi <madhu_p83@yahoo.com>
Subject: Audio driver on OMAP 1510 Innovator with MontaVista Linux
Date: Mon, 30 Jan 2006 07:16:40 -0800 (PST)
Message-ID: <20060130151640.79660.qmail@web50702.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,
 I am new to arm. I am trying to enable Audio on MontaVista Linux 2.4.20 on my OMAP 1510 Innovator board. So please be patient in reading the following and answering for the same.
I am having the following hardware:
1. OMAP 1510 Innovator board
2. JTAG
3. Serial cable connected to COM1 on my PC.
  I am using the following software/tools:
1. Redhat linux 7.2 on my Build PC
2. MontaVista Linux 2.4.20
3. Prebuilt rrload image used as bootloader for Omap 1510 Innovator board
4. Prebuilt arm_v4t_le- toolchain on my Build PC
5. minicom as a terminal program which in turn is using the serial cable connected to my PC.
  I am using the following steps for building MontaVista linux-kernel image for OMAP 1510 Innovator:
1. cd mvlcee-2.4.20
2. make ARCH=arm CROSS_COMPILE=/opt/mvlcee/devkit/arm/v4t_le/bin/arm_v4t_le- menuconfig
   Here, in the "Menu" I select the "Sound" menu, where I make the following changes:
 a. For the "Omap Sound Drivers" submenu I select the "Allow DSP to control Audio McBSP" option for configuration
3. make ARCH=arm CROSS_COMPILE=/opt/mvlcee/devkit/arm/v4t_le/bin/arm_v4t_le- dep
4. make ARCH=arm CROSS_COMPILE=/opt/mvlcee/devkit/arm/v4t_le/bin/arm_v4t_le- vmlinux
5. ./../rrload/mkimage --LAddr 0x10008000 --EAddr 0x10008000 vmlinux vmlinux.rr
  This gives me the vmlinux.rr file to be put on the board using rrload.
  I am using rrload as bootloader. My Minicom terminal program shows me the rrload prompt:
Here are I am using the following steps to download the kernel image:
1. Boot arguments are set as follows:
   console=ttyS0,115200n8 nointrd root=/dev/nfs rw ip=bootp nfsroot=10.41.1.73:/opt/mvlcee/devkit/arm/v4t_le/target,nolock
2. I then burn the kernel image vmlinux.rr to Flash.
  I am then able to boot the kernel successfully.
Here I am testing the sound device as follows:
1. cat endoftheworld > /dev/dsp
  This gives me the error "No such device"
  Thus, I am not able to use Audio on the board.
So can anybody please tell where I am wrong. Has anybody successfully made Audio working on board?
  I desperately need help. so please reply soon.
  --Riya

		
---------------------------------
 
 What are the most popular cars? Find out at Yahoo! Autos 
