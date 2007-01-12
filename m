From: "Raghunandan Dhongadi" <dk.raghu@gmail.com>
Subject: Processing of command line mem=32M
Date: Fri, 12 Jan 2007 16:37:27 +0530
Message-ID: <7d8fdf6f0701120307gee02aa1j7ff80e5eac4eefe9@mail.gmail.com>
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

Hello All,

I have Linux kernel 2.6.14-7 for OMAP2430 SDP board. The SDP has 128MB
of SDRAM memory. I want to share the 128MB into 64MB for ARM core and
64MB for DSP core.
I am giving the kernel command line parameter "mem=64M" but with this
the boot process
stops at "Uncompressing Kernel".

But if I give a minimum of "mem=113M" it boots fine. Wanted to know
where does the processing of command line parameters happen and what
could be the issue ?

Warm Regards,
Raghu
