From: Kristian Mueller <Kristian-M@kristian-m.de>
Subject: Re: Problem in arch/arm/mm between 2.6.13-rc1 and 2.6.15-rc2
Date: Thu, 08 Dec 2005 09:33:30 +0100
Message-ID: <1134030810.2994.30.camel@pismo>
References: <8028e5750512020508g68c5fe5fl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8028e5750512020508g68c5fe5fl@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Romain Goyet <r.goyet@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Romain

> I managed to find out that the kernel
> crashes in paging_init, but I couldn't find out why.
>  Could you give me any suggestions ? In particular, I would like to
> know what changed in arch/arm/mm between 2.6.13 and 2.6.15, since
> 2.6.13 was working like a charm.

You can see the changes made in arch/arm/mm/init.c in the git history at
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=history;f=arch/arm/mm/init.c

Maybe you can try older versions to isolate the date of the patch...


Best Regards
Kristian
