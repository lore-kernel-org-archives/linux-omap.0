From: Matthew Percival <matthew@capgo.com>
Subject: RE: DSP gateway build problems with 2.6.13.4
Date: Fri, 16 Dec 2005 09:38:55 +1100
Message-ID: <1134686335.8910.11.camel@localhost.localdomain>
References: <000001c60170$d3da45a0$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <000001c60170$d3da45a0$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> Also, how do I fix it so that this directory is automatically created and
> mounted at boot time?

	The directory should be there once you have created it, but to mount it
automatically add the following line to your /etc/fstab file:
none            /sys            sysfs   defaults        0       0

	If you already have it linked into kernel, then I am a little stuck as
to why it would not be creating the /sys/device/platform/dsp/ directory;
this should be automatically done, once you have sysfs compiled in and
mounted (as you have now done).

	-- Matthew
