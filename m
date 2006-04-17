From: Ram <vshrirama@gmail.com>
Subject: MMC/SD Not Working - OMAP 5912
Date: Mon, 17 Apr 2006 08:13:54 -0700
Message-ID: <8bf247760604170813j6e189386t5f668562b1fa7010@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
  I am using OMAP OSK 5912 OSK

  I am also using an Mistral's RDK add on board  for SD/MMC Card I/F.

  I have made the changes for enabling the MMC/SD I/F as suggested in
oskfordummies
  http://oskfordummies.hp.infoseek.co.jp/howto/mmcsd.html


  But When i try to do:
 # mount /dev/mmcblk0 /mnt/mmc -t vfat
  mount: Mounting /dev/mmcblk0 on /mnt/mmc failed: No such device or addres=
s


  I have tried having the mmc/sd drivers both within and as modules.


  Could anyone tell me where i am going wrong? Is there any checks i
need to do to isolate the problem.


  I checked both the MUX Control Register and the values are correct.



#lsmod
mmc_block 6344 0 - Live 0xbf00b000
omap 12968 0 - Live 0xbf006000
mmc_core 18964 2 mmc_block,omap, Live 0xbf000000

 # mount /dev/mmcblk0 /mnt/mmc -t vfat
  mount: Mounting /dev/mmcblk0 on /mnt/mmc failed: No such device or addres=
s



   Please Advice.

Regards,
sriram
