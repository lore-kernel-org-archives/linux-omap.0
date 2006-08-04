From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: NPTL on OMAP 5912
Date: Fri, 4 Aug 2006 07:42:58 +0200
Message-ID: <20060804054258.GA5329@orphique>
References: <20060803122348.GA23880@orphique>
	<00b601c6b70f$a08b1620$642aa8c0@Buffy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <00b601c6b70f$a08b1620$642aa8c0@Buffy>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 03, 2006 at 04:15:16PM +0100, Richard Copeman wrote:
> Hi,
> 
> Thanks for the pointers. Which shared objects do you include in your target
> filesystem?

Depends on what you want to run. You may need more or less, it's easy to
control it with PTXdist :-)
http://www.pengutronix.de/software/ptxdist_en.html

-rwxr-xr-x 1 root root  136248 2006-06-29 15:48 ld-2.4.so
-rwxr-xr-x 1 root root 1116104 2006-06-29 15:48 libc-2.4.so
-rwxr-xr-x 1 root root   22016 2006-06-29 15:48 libcrypt-2.4.so
-rwxr-xr-x 1 root root    9908 2006-06-29 15:48 libdl-2.4.so
-rwxr-xr-x 1 root root   35728 2006-06-29 15:48 libgcc_s.so.1
-rwxr-xr-x 1 root root  453380 2006-06-29 15:48 libm-2.4.so
-rwxr-xr-x 1 root root   68176 2006-06-29 15:48 libnsl-2.4.so
-rwxr-xr-x 1 root root   26400 2006-06-29 15:48 libnss_compat-2.4.so
-rwxr-xr-x 1 root root   17952 2006-06-29 15:48 libnss_dns-2.4.so
-rwxr-xr-x 1 root root   38644 2006-06-29 15:48 libnss_files-2.4.so
-rwxr-xr-x 1 root root   18008 2006-06-29 15:48 libnss_hesiod-2.4.so
-rwxr-xr-x 1 root root   34640 2006-06-29 15:48 libnss_nis-2.4.so
-rwxr-xr-x 1 root root   42744 2006-06-29 15:48 libnss_nisplus-2.4.so
-rwxr-xr-x 1 root root   70828 2006-06-29 15:48 libpthread-2.4.so
-rwxr-xr-x 1 root root   63620 2006-06-29 15:48 libresolv-2.4.so
-rwxr-xr-x 1 root root   27128 2006-06-29 15:48 librt-2.4.so
-rwxr-xr-x 1 root root   26988 2006-06-29 15:48 libthread_db-1.0.so
-rwxr-xr-x 1 root root    9812 2006-06-29 15:48 libutil-2.4.so

	ladis
