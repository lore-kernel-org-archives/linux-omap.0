From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: OMAP 730 audio driver
Date: Thu, 17 May 2007 19:58:54 +0530
Message-ID: <61445c750705170728ubbf884cn1b34df8f196834ea@mail.gmail.com>
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

Hi,
I am working on OMAP 730 based p2-sample board. AFAIK, there is no audio
driver support for this board. I have found
2.4 drivers for the same board which I have ported to 2.6, but it is an OSS
driver.

So, the question:
1. Do I need to migrate these drivers to be ALSA compliant?
2. Has anyone written ALSA drivers for the above mentioned board? Any
pointers will be helpful regarding the same.


-pharaoh.
