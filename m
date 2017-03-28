From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: Passing NAND mtdparts to OMAP2+ Kernel
Date: Tue, 28 Mar 2017 21:57:05 +0200
Message-ID: <20170328215705.438d7af8@bbrezillon>
References: <CAHCN7xJoVF+3HjHwaS_U=jDqmU_Yv201KJSQ2s8N0gSNVR8pdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAHCN7xJoVF+3HjHwaS_U=jDqmU_Yv201KJSQ2s8N0gSNVR8pdQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: "Leto, Enrico" <enrico.leto@siemens.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

+Roger and Enrico

On Tue, 28 Mar 2017 10:43:01 -0500
Adam Ford <aford173@gmail.com> wrote:

> I posted this on the linux-omap list, and I was asked to post this on
> the linux-mtd list:
> 
> 
> I tried to remove the MTD partitions from the Linux device tree, and I
> noticed that there was no partition information being pushed anymore
> unless I changed the mtdparts name in U-Boot.
> 
> It appears as if the MTD drivers have changed a bit.  I found a few
> e-mails floating around that attempt to fix this
> 
> Commit f7a8e38f07a17be907585 ("mtd: nand: assign reasonable default
> name for NAND drivers") attempts to address this, and someone over at
> https://patchwork.ozlabs.org/patch/707065/ attempted to address it as
> well in a slightly different way.

Can you test the patch and let me know if solves the problem. If it
does, I'll send a clean version of the patch and queue it for 4.12.

Thanks,

Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
