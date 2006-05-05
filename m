From: "Bharat Kumar Reddy" <bharat.mailing@gmail.com>
Subject: Compact Flash Issue on OSK 5912
Date: Fri, 5 May 2006 20:45:05 +0530
Message-ID: <31bab3780605050815v5906b07ap994bcb3204a8b49d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello All,

On the OSK 5912 Linux kernel version 2.6.15.1, I tried to mount CF
device of capacity 512 MB and 2GB, this mounts successfully but when
we try to copy some files to the mount point I get a kernel panic,
While a 32 MB CF disk gives no problems.

We also tried by creating a "swap" partition on the CF and doing
"swapon", but this too fails.

Has anyone faced these problems before and are there any patch fixes for th=
is ?

Thanks in Advance.
Warm Regards
Bharat.
