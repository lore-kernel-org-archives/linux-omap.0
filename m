From: "Yang, Xiaopeng" <xiaopeng.yang@windriver.com>
Subject: ads7846: data read from tsc2046 are all zeros
Date: Thu, 08 Nov 2007 18:33:50 +0800
Message-ID: <4732E60E.3000308@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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

I'm working on the tsc2046 touchscreen controller (using ads7846 driver) on 
sdp2430 v5.0.1 board. I can't get the touchscreen work with the linux-omap 
git tree. The driver builds, boots and register itself with no problem, 
interrupts can also be triggered when touching the panel, but no input 
events can be read. By enabling debug output, I finally found that all the 
values read from tsc2046 are all zeros.

Does anyone encounter the same problem? What could be the root cause for 
this problem? Any suggestions are welcome.

Thanks,
Xiaopeng
