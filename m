From: anshuman.goswami@tcs.com
Subject: How to configure stack on ARM of OMAP5912 using Linux?
Date: Fri, 5 May 2006 15:41:03 +0530
Message-ID: <OF1D9231E9.494C20BE-ON65257165.00371AAB-65257165.0037F1FE@tcs.com>
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

Hi all,

I want to know what is the method of setting the stack size manually used 
by ARM926EJ-S of OMAP5912 from MontaVIsta Linux.
I have used "arm_v4t_le-gcc" to compile and generate the executable which 
was loded onto ARM926EJ-S through Monta Vista Linux.

Is there anything like the linker command file like the one used in CCS to 
configure the memory map when using the ARM926 Simulator which uses TI's 
TMS470RXX CPU core?

Any suggestion is eagerly awaited.

Thanks in advance,

Regards,
Anshuman Goswami
COMPUTER CONSULTANCY
Tata Consultancy Services Limited
M2 & N2, Sector V, Block GP,
Salt Lake Electronics Complex
Kolkata - 700091,West Bengal
India
Mailto: anshuman.goswami@tcs.com
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
