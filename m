From: batsayan.das@tcs.com
Subject: Help req on writing JFFS2 filesystem to flash
Date: Tue, 7 Nov 2006 17:30:44 +0530
Message-ID: <OFC26FE4B2.FF8BBC4C-ON6525721F.00411E32-6525721F.0041FB77@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I have built a JFFS2 filesystem for OMAP5912 board. The size of the JFFS2 
filesystem is 20MB.

When copying the filesystem (by tftp) to SDRAM, it hangs after some time. 

Whereas, it is able to copy the default JFFS2 filesystem to SDRAM of size 
15MB.

Is there any specific reason for this? How should I copy the 20MB 
filesystem to the flash? 

Thanks in advance.



Regards,
Batsayan Das
Tata Consultancy Services
Mailto: batsayan.das@tcs.com
Website: http://www.tcs.com
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you
