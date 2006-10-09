From: Philip Balister <philip@balister.org>
Subject: Updated images for the OSK
Date: Mon, 09 Oct 2006 16:49:58 -0400
Message-ID: <452AB5F6.7030709@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

I just built these images and loaded them into my OSK and successfully 
booted. The kernel is based on today's git with the dsp gateway enabled. 
Let me know if you try these and you have suggestions for improvements. 
The udev start is slow.

http://ossie.mprg.org/download/osk/

Load the kernel at 0x40000 and the file system at 0x240000.

See the instructions for flashing the kernel image and the filesystem here.

http://oskfordummies.hp.infoseek.co.jp/howto.html

Philip
