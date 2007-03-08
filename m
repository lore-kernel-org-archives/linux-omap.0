From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: U-Boot prompt is not visible
Date: Thu, 8 Mar 2007 17:28:44 +0530
Message-ID: <61445c750703080358jd7e2b76sbd010420b975bef8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi
I have loaded the u-boot.elf binary to RAM over UART using the OST
utility on Windows XP. The ELF binary which is compiled on Linux for omap730p2
sample board gets successfully downloaded to RAM at the specified
address. I have configured the UART as mentioned in the manual by
using Hyperterminal. After downloading the ELF binary to RAM, I should
be seeing the U-boot prompt on console. But, just a cursor blinks on
screen. I am sure the  connection is being established but no prompt
is seen.

The OST tool says that the image is downlaoded to RAM successfully and
it is executing at address XXXXXX. How can check whether U-Boot image
is really in RAM and executing?

If burning ELF is correct then what might have gone wrong ? Why the
u-boot prompt is not visible? What I am missing? I have checked the
COM1 setting and they are as they should be.

-Pharaoh.
