From: "Raghunandan Dhongadi" <dk.raghu@gmail.com>
Subject: Compile Time Issue
Date: Tue, 23 Jan 2007 10:00:31 +0530
Message-ID: <7d8fdf6f0701222030k4a683397qcff970c767b265dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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

Hello All,

We are trying to build the "DSP-LInk" for the muru Linux OMAP 2.6.19 with
the "patch-2.6.19-omap1", but we hit on a "compile time" error "DIVIDE BY
ZERO" which is caused in the "include/linux/jiffies.h" file. The macro
"CONFIG_HZ" is getting a default value of 100MHz. However even if we select
the 32KHz timer the CONFIG_HZ gets defined as 128MHz.Wanted to know if
anyone has fix for this ?

TIA.
Warm Regards,
Raghu
