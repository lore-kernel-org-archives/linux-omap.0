From: "arun c" <arun.edarath@gmail.com>
Subject: Does Uboot do lowlevel clock settings if it is in RAM?
Date: Tue, 3 Jul 2007 20:42:58 +0530
Message-ID: <c656a4d20707030812i313e111at9eff98700e3c50fd@mail.gmail.com>
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

Hi all,

i am working with omap2430sdp.

i am downloading the uboot.bin file through JTAG using CCS.
its downloading sucessfully. But after running it nothing comes
in the serial port.

we checked the clock settings. its going wrong after we start
running uboot(its fine untill we download through JTAG).

But what i understood that uboot won't change any clock settings
if it is running from RAM.

I want to know whether uboot changes clock settings if its
running from RAM??

please somebody help me out.

Regards
Arun
