From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: Fwd: Problems loading ffs image
Date: Mon, 18 Sep 2006 18:00:34 -0300
Message-ID: <ae36f8040609181400h1b1ef261v3c25fc5630351392@mail.gmail.com>
References: <ae36f8040609151022l1239fc8ft91e96ad26e7db4ed@mail.gmail.com>
	<ae36f8040609181359u40b0862cyfd380e33192d1a6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040609181359u40b0862cyfd380e33192d1a6d@mail.gmail.com>
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

hi,
I'm working one the problem i fixed the init problem, remove init support
from busybox and cross compiled the coreutils and sysvinit to my plataform,
besides i still having the following problem:
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
0x2cac instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004:
0x4b8b instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000008:
0x7b8a instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000000c:
0xb6e7 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000010:
0x3bfe instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000014:
0xb17a instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000018:
0x5826 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c:
0x25dd instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020:
0x188a instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000024:
0x0447 instead

Further such events for this erase block will not be printed
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 116K
Warning: unable to open an initial console.

someone could help me ?


On 9/15/06, Lu=EDs Vit=F3rio Cargnini <lvcargnini@ieee.org> wrote:

> Hi everybody,
> I having problems to boot my file system image i receive the following
> error:
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
> 0x0a10 instead
> >>cut to reduce message size <<
>

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000024:
> 0xf1a4 instead
> Further such events for this erase block will not be printed
> VFS: Mounted root (jffs2 filesystem).
> Freeing init memory: 116K
> Warning: unable to open an initial console.
> Kernel panic - not syncing: Attempted to kill init!
>
>
> i updated the kernel yesterday, and created the image with following
> options:
>
> mkfs.jffs2 -p -e 0x20000 -n -v -r bbox/ -o instramed.jffs2
>
> i used the mkfs.jffs2 compiled from latest mtd-utils (as recommended)
>
> uploaded to osk 5912 board, punt on flsh with cp.b 0x1000......
> 0x0010...... size
> than i boot and the error, could someone help please.
>
> --
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
