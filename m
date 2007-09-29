From: radha k <radha_kodirekka@yahoo.com>
Subject: regarding usb web cam
Date: Fri, 28 Sep 2007 20:55:58 -0700 (PDT)
Message-ID: <182377.18152.qm@web60920.mail.yahoo.com>
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


HI

I have connected logitech quick cam to osk5912.I hav
wriiten code for that.when i boot osk5912 it detected.
when i executed 

3.6 Build servfox or spcaserv for the board.
		Get servfox from here, uncompressed it, modify the
Makefile.arm to suitable your host platform.	
	Then, use the command "make -fMakfile.arm" to build
it. Move the output file to the NFS server home
directory.
	Goto minicom, input like this:
	cd
/lib/modules/2.6.12.6-omap1/kernel/drivers/usb/media/spca5xx/
      	insmod spca5xx.ko
	/root/servfox -d /dev/video0 -s 320x240
	Then the server is ready.

	3.7 Build spcaview, get the source file of spcaview
from here.
	Just build it.
	spcaview -w192.168.0.12:7070
	You will see the captured picture from the board.

when i am doing /root/servfox -d /dev/video0 -s
320x240
like this at osk 
it is giving error /root/servfox: 1: Syntax error: "("
unexpected

i dont know how to proceed let me know



       
____________________________________________________________________________________
Need a vacation? Get great deals
to amazing places on Yahoo! Travel.
http://travel.yahoo.com/
