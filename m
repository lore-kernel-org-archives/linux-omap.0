From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Qeury regarding EAC driver for omap 24xx
Date: Wed, 6 Jun 2007 16:32:24 +0530
Message-ID: <61445c750706060402q34388d3fm7bf2c097b34f6346@mail.gmail.com>
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

I am referring the EAC driver for omap 24xx which is used by n800 board. The
EAC 24xx driver
doesn't look complete since it has only hardware init sequences and very
basic ALSA related
functionalities i.e. register the sound card etc. Is omap 24xx eac driver
still in intermediate stage?Or
it is complete but not yet integrated in to omap git tree? In later case,
where can I find the complete
eac driver?

Also, omap 24xx driver doesn't seem to follow the framework/structure of
other omap alsa
drivers in sound/arm/omap/ , any particular reason?  Please enlighten.
