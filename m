From: Maximus <john.maximus@gmail.com>
Subject: Re: Git tree
Date: Wed, 25 Jul 2007 20:45:22 +0530
Message-ID: <3634de740707250815v27a3e612me22626ba80592428@mail.gmail.com>
References: <a5eaedfa0707170441x5427b8cey6095bcb95b87347d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <a5eaedfa0707170441x5427b8cey6095bcb95b87347d@mail.gmail.com>
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
To: Veda N <veda74@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 7/17/07, Veda N <veda74@gmail.com> wrote:
> Hi,
>    I am using the latest git tree. MTD and nand support for SDP does not
> exist.

   Were you able to boot out of nand flash using the git-tree?.

  "make omap_2430sdp_defconfig" does not enable nand support.

  one-nand support is enabled. Both are exclusive.


-- john


>    Am not able to boot out of JFFS file system.
>
>   Has anyone tried booting latest git kernel out of JFFS2 filesystem.
>
>
> Regards,
> vedan
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
