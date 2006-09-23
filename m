From: "Hieu Ninh" <hninh@hotmail.com>
Subject: In system software upgrade
Date: Fri, 22 Sep 2006 22:56:53 -0500
Message-ID: <BAY122-DAV978325FCA9F5416C60A15A6260@phx.gbl>
References: <20060922204246.7423A8062F@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Message-ID: <002101c6dec4$4e279110$0201a8c0@hn>
In-Reply-To: <20060922204246.7423A8062F@linux.omap.com>
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

All,

Our system requires the software upgrade feature (for both application and
kernel) during the user space application is running.  I don't know how to
go about it in Linux environment.  

If I can get an image (from USB flash) and copy it to the RAM while the
system running and some how reboot the system in U-boot (without reset the
RAM).  From there I can run the uboot script to copy the image from RAM to
flash.  Would this work? Is there any better way to do this?

Thanks

HN
