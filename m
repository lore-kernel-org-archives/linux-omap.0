From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH 0/2] Updated OMAP 2 camera driver and N800 platform camera
 patches
Date: Mon, 20 Aug 2007 15:02:21 +0300
Message-ID: <46C982CD.80802@nokia.com>
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Here are the new OMAP 2 camera driver and N800 platform camera patches. 
I have posted the updates to V4L int if and TCM825x driver to the V4L 
list already as they have been integrated into V4L tree at 
<URL:http://linuxtv.org/hg/v4l-dvb> (excluding the new patches, sorry).

The changes since the last update include the following:

- Update to use vidioc_int_g_ifparm.

- VIDIOC_DQBUF fix.

     The driver assumed that every slave would return zero from
     vidioc_int_g_needs_reset. This doesn't hold true for the slaves that
     do not implement that ioctl at all.

- Small cleanups, remove useless & characters.

-- 
Sakari Ailus
sakari.ailus@nokia.com
