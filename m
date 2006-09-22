From: Basavaraj Hiremath <hbasava@yahoo.com>
Subject: Mount problem
Date: Thu, 21 Sep 2006 17:31:47 -0700 (PDT)
Message-ID: <20060922003147.41000.qmail@web36108.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

Hi,
I am running Debian lInux, I am trying to mount USB
thumb drive with following command, not successful

Please help me:

in super user mode:

#mount -t auto /dev/sda1 /media/usb0

I tried , auto, vfat options
This is error message:
mount: unknown filesystem type 'vfat'


#dmesg | tail <as folowssda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 258048 512-byte hdwr sectors (132 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 sda: sda1
 sd 3:0:0:0: Attached scsi removable disk sda
 sd 3:0:0:0: Attached scsi generic sg0 type 0
 usb-storage: device scan complete
 >


 Thanks in advance,
 It's silly, but not working.

 Thanks,
 Raj



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
