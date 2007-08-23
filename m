From: Trilok Soni <trilok_soni@yahoo.co.in>
Subject: merging camera_core and omap16xxcam files
Date: Thu, 23 Aug 2007 04:57:01 -0700 (PDT)
Message-ID: <244556.6253.qm@web8506.mail.in.yahoo.com>
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

Hi All,

As we don't see multiple hardware interfaces attached
to omap1 camera_core.c from the long time except for
the present omap16xxcam.c, I would like take code from
omap16xxcam.c to camera_core.c and dma code to
omap16xxdma.c. This will help us while going to
upstream and then using new v4l2_int interface and new
ov9640 sensor driver which I had submitted few days
back.

Please let me know if some one is having other
hardware interfaces implemented but not submitted to
list e.g omap850cam.c, omap5910cam.c etc. 

---Trilok Soni


       
____________________________________________________________________________________
Be a better Heartthrob. Get better relationship answers from someone who knows. Yahoo! Answers - Check it out. 
http://answers.yahoo.com/dir/?link=list&sid=396545433
