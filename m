From: Adam Ford <aford173@gmail.com>
Subject: Passing NAND mtdparts to OMAP2+ Kernel
Date: Tue, 28 Mar 2017 10:43:01 -0500
Message-ID: <CAHCN7xJoVF+3HjHwaS_U=jDqmU_Yv201KJSQ2s8N0gSNVR8pdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

I posted this on the linux-omap list, and I was asked to post this on
the linux-mtd list:


I tried to remove the MTD partitions from the Linux device tree, and I
noticed that there was no partition information being pushed anymore
unless I changed the mtdparts name in U-Boot.

It appears as if the MTD drivers have changed a bit.  I found a few
e-mails floating around that attempt to fix this

Commit f7a8e38f07a17be907585 ("mtd: nand: assign reasonable default
name for NAND drivers") attempts to address this, and someone over at
https://patchwork.ozlabs.org/patch/707065/ attempted to address it as
well in a slightly different way.

Both of them refer to the same commit: 853f1c58c4b2 ("mtd: nand:
omap2: show parent device structure in sysfs") as the source for the
issue.

It now appears as if the name "omap2-nand.0" was replaced with
"30000000.nand"  Is this intentional? It seems like a lot of people
will have to update their bootloaders if they want to pass 'mtdparts'
from the bootloader to the kernel.

I am not a member of the MTD mailing list, so maybe this is more
properly sent over there, but since it's an OMAP related thing, I
thought I'd post it here.  My other ARM boards don't appear to be
impacted.  If the trend is to not pass the partition info from U-boot,
I can live with that too.  I was just more curious to know what the
long term plan is and what solution is recommended.

I have verified this in 4.11-RC4 and 4.9.18

adam

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
