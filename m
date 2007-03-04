From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH] ARM: OMAP: Fix SPI merge issues and reintroduce
	omap_uwire.c
Date: Sun, 04 Mar 2007 13:28:29 +0100
Message-ID: <85tzx1gple.fsf@orfeo.duckcorp.org>
References: <45EAB7F5.2040603@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45EAB7F5.2040603@googlemail.com> (Dirk Behme's message of "Sun,
	04 Mar 2007 13:13:41 +0100")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme <dirk.behme@googlemail.com> writes:

> Is there any special reason why
>
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=ba6d3cf6f7900c7586cca6bbd9dca55d7c6386fb
>
> deleted drivers/spi/omap_uwire.c?

looks like forgotten git-update-index or something like that. I didn't
check closely but I bet that this conflicts explains also why the
ads7846 touchscreen driver doesn't work. I had to take the versions from
the old linux-omap-2.6 tree to get my touchscreen back :(

>
> If not, reintroduce it and remove double entries in Kconfig
> and Makefile. Please check if I hit the most recent version
> of omap_uwire.c.
>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

fwiw: Acked-by: Arnaud Patard <arnaud.patard@rtp-net.org> :)
