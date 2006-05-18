From: ruchir.gulati@tcs.com
Subject: Problem with play in O_RDWR mode on OMAP5912 OSK board
Date: Thu, 18 May 2006 18:29:32 +0530
Message-ID: <OF6A9A48FE.85EDD736-ON65257172.00470E97-65257172.00474F68@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Dear All,

I have tried for sometime now to simultaneously play and recored audio in 
the O_RDWR mode on the OMAP 5912 OSK board, without any success!
With larger fragment size (32k), audio is played for a while but then the 
board hangs. For smaller fragment sizes, I get the following error:
"omap_audio: received DMA IRQ for non existent buffers!"
I have also looked at the driver code and seen that 2 DMA channels are 
used when the device is opened in the O_RDWR mode. However, one of the 
channels has one buffer unallocated, which causes this error. I have also 
tried doing read and write in separate threads, but to no avail. Though 
recording happens more or less properly

I have seen sevral posts whixh say that simultaneous read/write is rather 
not do-able....

Does any of you have any ideas as to how things can be fixed?  If not then 
I might have to start with ALSA.

Thanks & Regards,
Ruchir
ForwardSourceID:NT00005786 
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
