From: Matthew Percival <matthew@capgo.com>
Subject: Re: OSK5912 Deep Sleep
Date: Mon, 22 May 2006 09:08:52 +1000
Message-ID: <1148252932.9017.4.camel@localhost.localdomain>
References: 446C7FC0.4070503@web.de  <446D9F6A.9080202@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <446D9F6A.9080202@web.de>
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

> i tried what you told me, but i got this message from the shell: cannot 
> create /sys/power/state: No such file or directory

	Ah, you either have not compiled the sysfs into kernel, or have not
mounted it.  Ensure you have CONFIG_SYSFS=y in your kernel's .config
(this is in the root source directory) --- =m is also OK, if you load
the module later.  If not, enable it, and recompile.  Then, make sure
you have the following line in your OSK's /etc/fstab:
none		/sys		sysfs	defaults	0	0
This will load the sysfs on boot (make sure you have created /sys/ for
it to mount there).  If you check the contents of /sys/ (with ls) after
it has been mounted, you should see a collection of directories: these
can be very useful to running your system.

	-- Matthew
