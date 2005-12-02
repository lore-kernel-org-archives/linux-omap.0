From: Romain Goyet <r.goyet@gmail.com>
Subject: Re: OMAP5912 and Intel P30 Flash
Date: Fri, 2 Dec 2005 14:06:34 +0100
Message-ID: <8028e5750512020506p41b7b81fk@mail.gmail.com>
References: <2CBB9620-2407-4313-9AE8-7222247BC0BD@capgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <2CBB9620-2407-4313-9AE8-7222247BC0BD@capgo.com>
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
Cc: OMAP Linux mailing list <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello everybody,
 I'm still porting Linux to the Palm Tungsten E , and it happened that
Linux stopped working when I upgraded from 2.6.13 to 2.6.15-rc2.
 My biggest problem is that this board has _no_ UART nor JTAG, so
it's _very_ difficult to debug. I managed to find out that the kernel
crashes in paging_init, but I couldn't find out why.
 Could you give me any suggestions ? In particular, I would like to
know what changed in arch/arm/mm between 2.6.13 and 2.6.15, since
2.6.13 was working like a charm.
 What's rather weird is that it sounds to be working OK on other
OMAP1510 devices. As the Tungsten E uses an OMAP310 which defines
IS_OMAP_15XX, I don't really understand why it doesn't work as well on
the OMAP310.

Kind regards,

Romain Goyet
