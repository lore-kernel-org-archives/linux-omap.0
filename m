From: "Filipe Braz" <ferlipaz@gmail.com>
Subject: ALSA and TWL4030 in full duplex mode
Date: Mon, 1 Oct 2007 15:06:46 -0700
Message-ID: <1678610a0710011506o7d7a8effp61cad3c09e2d89d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

I have been having trouble running the ALSA driver for the TWL4030 audio
codec in Full duplex mode, using the OMAP 2430SDP. The driver used is the
ALSA OMAP2430SDP driver (or the TWL4030 driver in 2.6.14 v3).

It works fine in half-duplex mode but not in full duplex mode. I tried this
with the following ti kernels:

 - linux-2.6.14-omap2-v3.tgz
 - linux-2.6.14-omap2-v4.tgz

When opening the device for capture (after successfully opening for
playback), the driver prints the following kernel error message:

"Request for MCBSP Failed[-22]"

This error occurs in omap2-audio-twl4030.c and is caused by attempting to
request the McBSP interface when it is already reserved.

I also notice that the there is an additional driver: the OMAP2430DASF. This
driver seems to use a message queue but its unclear on how it is supposed to
work and if it supports full duplex mode. When attempting to play sound
using it, it blocks the application and eventually fails with write error.

Any information on these would be appreciated

Thanks,
Filipe
