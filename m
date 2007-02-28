From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] OMAP2 camera and TCM825x sensor drivers
Date: Wed, 28 Feb 2007 17:49:29 +0200
Message-ID: <45E5A489.2040108@nokia.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I'm about to send a patch set of OMAP 2 camera and a TCM825x sensor 
drivers. Compared to those from maemo.org, there are clean-ups and the 
overlay support has been removed, among other things.

This is all still very much work in progress but I'd be glad to hear 
comments about it.

Both drivers should compile, and also function with 2.6.18 from 
maemo.org. (Except that there's a bug in VIDIOC_DQBUF in 2.6.18.) Some 
N800-specific code is missing for the moment. Also locking is in sore 
state. The interface changes (temporarily) break existing OMAP 1 camera 
driver and the ov9640 sensor driver.

These patches are against Tony's tree.

I recommend not to apply these for the time being. :)

Regards,

-- 
Sakari Ailus
sakari.ailus@nokia.com
