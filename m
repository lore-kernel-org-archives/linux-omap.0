From: "Shobhit Kumar" <shos.arora@gmail.com>
Subject: ALSA driver for audio codec on TWL4030
Date: Fri, 14 Dec 2007 00:22:29 +0530
Message-ID: <376191c90712131052p359b9927ic31671ed8b4de0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hi,I was planning to use the 2.6.21 kernel from the omap git tree, but found
that the ALSA driver for audio codec on TWL4030 is not included. I checked
the 2.6.14 release from TI which has the driver for the same. But this same
driver cannot probably used as is on 2.6.21 kernel due to various ALSA
framework changes.

Is there a port available on 2.6.21 kernel or would I have to port it..

Thanks & Regards
Shos
